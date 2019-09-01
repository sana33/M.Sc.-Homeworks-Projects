function output = notchFilter(im)
    FT = fft2(double(im));
    FT1 = fftshift(FT);%finding spectrum
    % imtool(abs(FT1),[]);
    m = size(im,1);
    n = size(im,2);

    t = 0:pi/20:2*pi;
    xc=(m+150)/2; % point around which we filter image
    yc=(n-150)/2;
    r=200;   %Radium of circular region of interest(for BRF)
    r1 = 40;
    xcc = r*cos(t)+xc;
    ycc =  r*sin(t)+yc;

    xcc1 = r1*cos(t)+xc;
    ycc1 =  r1*sin(t)+yc;

    mask = poly2mask(double(xcc),double(ycc), m,n);
    mask1 = poly2mask(double(xcc1),double(ycc1), m,n);%generating mask for filtering

    mask(mask1)=0;

    FT2=FT1;
    FT2(mask)=0;%cropping area or bandreject filtering

    % imtool(abs(FT2),[]);
    output = abs(ifft2(ifftshift(FT2)));
    % imtool(output,[]);
end

function [F_blindImg,S1,S2] = notch_filter(blindImg)
    % Determine good padding for Fourier transform
    PQ = paddedsize(size(blindImg));

    % Create Notch filters corresponding to extra peaks in the Fourier transform
    H1 = notch('btw', PQ(1), PQ(2), 10, 50, 100);
    H2 = notch('btw', PQ(1), PQ(2), 10, 1, 400);
    H3 = notch('btw', PQ(1), PQ(2), 10, 620, 100);
    H4 = notch('btw', PQ(1), PQ(2), 10, 22, 414);
    H5 = notch('btw', PQ(1), PQ(2), 10, 592, 414);
    H6 = notch('btw', PQ(1), PQ(2), 10, 1, 114);

    % Calculate the discrete Fourier transform of the image
    F = fft2(double(blindImg),PQ(1),PQ(2));

    % Apply the notch filters to the Fourier spectrum of the image
    FS = F.*H1.*H2.*H3.*H4.*H5.*H6;

    % convert the result to the spacial domain.
    F_blindImg = real(ifft2(FS)); 

    % Crop the image to undo padding
    F_blindImg = F_blindImg(1:size(blindImg,1), 1:size(blindImg,2));

    % Display the blurred image
    % figure; imshow(F_blindImg,[]);

    % Display the Fourier Spectrum 
    % Move the origin of the transform to the center of the frequency rectangle.
    Fc = fftshift(F);
    Fcf = fftshift(FS);

    % Use abs to compute the magnitude and use log to brighten display
    S1 = log(1+abs(Fc)); 
    S2 = log(1+abs(Fcf));
    % figure; imshow(S1,[]);
    % figure; imshow(S2,[]);
end

function PQ = paddedsize(AB, CD, PARAM)
    if nargin == 1
       PQ = 2*AB;
    elseif nargin == 2 && ~ischar(CD)
       PQ = AB + CD - 1;
       PQ = 2 * ceil(PQ / 2);
    elseif nargin == 2
       m = max(AB); % Maximum dimension.

       % Find power-of-2 at least twice m.
       P = 2^nextpow2(2*m);
       PQ = [P, P];
    elseif nargin == 3
       m = max([AB CD]); %Maximum dimension.
       P = 2^nextpow2(2*m);
       PQ = [P, P];
    else
       error('Wrong number of inputs.')
    end
end

function H = notch(type, M, N, D0, x, y, n)
    if nargin == 6
       n = 1; % Default value of n.
    end

    % Generate highpass filter.
    Hlp = lpfilter(type, M, N, D0, n);
    H = 1 - Hlp;
    H = circshift(H, [y-1 x-1]);
end

function [U, V] = dftuv(M, N)
    % Set up range of variables.
    u = 0:(M-1);
    v = 0:(N-1);

    % Compute the indices for use in meshgrid
    idx = find(u > M/2);
    u(idx) = u(idx) - M;
    idy = find(v > N/2);
    v(idy) = v(idy) - N;

    % Compute the meshgrid arrays
    [V, U] = meshgrid(v, u);
end

function H = lpfilter(type, M, N, D0, n)
    % Use function dftuv to set up the meshgrid arrays needed for 
    % computing the required distances.
    [U, V] = dftuv(M, N);

    % Compute the distances D(U, V).
    D = sqrt(U.^2 + V.^2);

    % Begin fiter computations.
    switch type
    case 'ideal'
       H = double(D <=D0);
    case 'btw'
       if nargin == 4
          n = 1;
       end
       H = 1./(1 + (D./D0).^(2*n));
    case 'gaussian'
       H = exp(-(D.^2)./(2*(D0^2)));
    otherwise
       error('Unknown filter type.')
    end
end

