clear; close all; clc; warning off

%% Initializations
imgBall = imread('input/ball.bmp');
imgBallSz = size(imgBall);
imgBallPad = padarray(imgBall,size(imgBall),'post');
imgBallPadSz = size(imgBallPad);
imgBallFourier = fft2(imgBallPad);
imgBallMagn = fftshift(abs(imgBallFourier));
imgBallPhase = angle(imgBallFourier);

%% Ideal High-pass Filter
idealHpFiltRad = 40;
idealHpFilter = zeros(imgBallPadSz);
l1 = floor(imgBallPadSz(1) / 2) + 1;
l2 = floor(imgBallPadSz(2) / 2) + 1;
for i1 = 1:imgBallPadSz(1)
    for i2 = 1:imgBallPadSz(2)
        if((i1 - l1)^2 + (i2 - l2)^2 <= idealHpFiltRad^2)
            idealHpFilter(i1,i2) = 1;
        end
    end
end
idealHpFilter = 1 - idealHpFilter;
idealHpFiltRes = uint8(real(ifft2(ifftshift(idealHpFilter .* imgBallMagn) .* exp(1j * imgBallPhase))));
idealHpFiltRes = idealHpFiltRes(1:imgBallSz(1),1:imgBallSz(2));
figure(1); 
subplot(3,2,1); imshow(idealHpFilter); subplot(3,2,2); imshow(idealHpFiltRes);
imwrite(idealHpFiltRes,'output/ex04-partC_ball_IHPF_best.bmp');

%% ButterWorth High-pass Filter
bwHpCutoff = 0.07; % butterworth cutoff value
bwHpOrder = 1; % butterworth order
i1 =  (ones(imgBallPadSz(1),1) * [1:imgBallPadSz(2)]  - (fix(imgBallPadSz(2)/2)+1)) / imgBallPadSz(2);
i2 =  (transpose(1:imgBallPadSz(1)) * ones(1,imgBallPadSz(2)) - (fix(imgBallPadSz(1)/2)+1)) / imgBallPadSz(1);
bwHpFiltRad = sqrt(i1.^2 + i2.^2);
butterworthHpFilter = 1 - mat2gray(1 ./ (1.0 + (bwHpFiltRad ./ bwHpCutoff) .^ (2*bwHpOrder)));
butterworthHpFiltRes = uint8(real(ifft2(ifftshift(butterworthHpFilter .* imgBallMagn) .* exp(1j * imgBallPhase))));
butterworthHpFiltRes = butterworthHpFiltRes(1:imgBallSz(1),1:imgBallSz(2));
subplot(3,2,3); imshow(butterworthHpFilter); subplot(3,2,4); imshow(butterworthHpFiltRes);
imwrite(butterworthHpFiltRes,'output/ex04-partC_ball_BHPF_best.bmp');

%% Gaussian High-pass Filter
gassianHpFilter = 1 - mat2gray(fspecial('gaussian',size(imgBallPad),40));
gaussianHpFiltRes = uint8(real(ifft2(ifftshift(gassianHpFilter .* imgBallMagn) .* exp(1j * imgBallPhase))));
gaussianHpFiltRes = gaussianHpFiltRes(1:imgBallSz(1),1:imgBallSz(2));
subplot(3,2,5); imshow(gassianHpFilter); subplot(3,2,6); imshow(gaussianHpFiltRes);
imwrite(gaussianHpFiltRes,'output/ex04-partC_ball_GHPF_best.bmp');
