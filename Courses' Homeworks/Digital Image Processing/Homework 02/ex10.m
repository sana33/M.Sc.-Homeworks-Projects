warning off;
skelImg = imread('inputs/skeleton.jpg');
%% 1st: Utilizing the laplacian to highlight fine details
laplacfilt = [-1 -1 -1; -1 9 -1; -1 -1 -1];
skelLaplac = imfilter(skelImg,laplacfilt);
figure(1);
subplot(2,3,1); imshow(skelLaplac); title('Laplacian+Addition(noisy) operator result');

%% 2nd: Using the gradient mask (sobel operators) to enhance prominent edges
gX = [-1 -2 -1; 0 0 0; 1 2 1]; % Horizontal derivative approximation filter
gY = gX'; % Vertical derivative approximation filter
skelImgHorDer = imfilter(skelImg,gX);
skelImgVerDer = imfilter(skelImg,gY);
skelImgGrad = uint8(abs(skelImgHorDer)+abs(skelImgVerDer));
subplot(2,3,2); imshow(skelImgGrad); title('Sobel gradient operator result');

%% 3rd: Smoothing the gradient image by a 5*5 averaging filter
avgFilt = ones(5)./25;
skelImgGradSmth = imfilter(skelImgGrad,avgFilt);
subplot(2,3,3); imshow(skelImgGradSmth); title('Smoothed gradient image');

%% 4th: Considering the gray-level masking: Laplacian * SGI
skelImgGLmasked = double(skelImgGradSmth) .* double(skelLaplac);
skelImgGLmasked = im2uint8(mat2gray(skelImgGLmasked));
subplot(2,3,4); imshow(skelImgGradSmth); title('Gray-level masknig (Laplacian * SGI) result');

%% 5th: Adding the original image to the latter result
skelImgOrigAdd = skelImgGLmasked + skelImg;
subplot(2,3,5); imshow(skelImgOrigAdd); title('Gray-level masknig output plus the original image');

%% 6th: Performing power-law transformation to increase the dynamic range of the latter result
skelImgPowLawOut = double(skelImgOrigAdd) .^ (1/2);
skelImgFinal = im2uint8(mat2gray(skelImgPowLawOut));
subplot(2,3,6); imshow(skelImgFinal); title('Power-law transformation result');

% Writing the final result into the outputs directory
imwrite(skelImgFinal,'outputs/skeletol_combine.bmp');
