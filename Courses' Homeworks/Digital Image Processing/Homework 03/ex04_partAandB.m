clear; close all; clc; warning off

%% Initializations
imgTxd = imread('input/TaxiDriver.bmp');
imgTxdSz = size(imgTxd);
imgTxdPad = padarray(imgTxd,size(imgTxd),'post');
imgTxdPadSz = size(imgTxdPad);
imgTxdFourier = fft2(imgTxdPad);
imgTxdMagn = fftshift(abs(imgTxdFourier));
imgTxdPhase = angle(imgTxdFourier);

%% Ideal Low-pass Filter
idealLpFiltRad = 100;
idealLpFilter = zeros(imgTxdPadSz);
l1 = floor(imgTxdPadSz(1) / 2) + 1;
l2 = floor(imgTxdPadSz(2)/ 2) + 1;
for i1 = 1:imgTxdPadSz(1)
    for i2 = 1:imgTxdPadSz(2)
        if((i1 - l1)^2 + (i2 - l2)^2 <= idealLpFiltRad^2)
            idealLpFilter(i1,i2) = 1;
        end
    end
end
idealLpFiltFinalRes = uint8(real(ifft2(ifftshift(idealLpFilter .* imgTxdMagn) .* exp(1j * imgTxdPhase))));
idealLpFiltFinalRes = idealLpFiltFinalRes(1:imgTxdSz(1),1:imgTxdSz(2));
figure(1); 
subplot(3,2,1); imshow(idealLpFilter); subplot(3,2,2); imshow(idealLpFiltFinalRes);
imwrite(idealLpFiltFinalRes,'output/ex04-partA_TaxiDriver_ILPF_best.bmp');

%% ButterWorth Low-pass Filter
bwLpCutoff = 0.09; % butterworth cutoff value
bwLpOrder = 1; % butterworth order
j1 =  (ones(imgTxdPadSz(1),1) * [1:imgTxdPadSz(2)]  - (fix(imgTxdPadSz(2)/2)+1)) / imgTxdPadSz(2);
j2 =  (transpose(1:imgTxdPadSz(1)) * ones(1,imgTxdPadSz(2)) - (fix(imgTxdPadSz(1)/2)+1)) / imgTxdPadSz(1);
bwLpFiltRad = sqrt(j1.^2 + j2.^2);
butterworthLpFilter = mat2gray(1 ./ (1.0 + (bwLpFiltRad ./ bwLpCutoff) .^ (2 * bwLpOrder)));
butterWorthLpFiltFinalRes = uint8(real(ifft2(ifftshift(butterworthLpFilter .* imgTxdMagn) .* exp(1j * imgTxdPhase))));
butterWorthLpFiltFinalRes = butterWorthLpFiltFinalRes(1:imgTxdSz(1), 1:imgTxdSz(2));
subplot(3,2,3); imshow(butterworthLpFilter); subplot(3,2,4); imshow(butterWorthLpFiltFinalRes);
imwrite(butterWorthLpFiltFinalRes,'output/ex04-partA_TaxiDriver_BLPF_best.bmp');

%% Gaussian Low-pass Filter
gaussLpFiltStartTime = tic % setting start time
gassianLpFilter = mat2gray(fspecial('gaussian',imgTxdPadSz,150));
gaussianLpFiltFinalRes = uint8(real(ifft2(ifftshift(gassianLpFilter .* imgTxdMagn) .* exp(1i * imgTxdPhase))));
gaussianLpFiltFinalRes = gaussianLpFiltFinalRes(1:imgTxdSz(1),1:imgTxdSz(2));
gaussLpFiltElapsedTime = toc(gaussLpFiltStartTime) % getting finish time
subplot(3,2,5); imshow(gassianLpFilter); subplot(3,2,6); imshow(gaussianLpFiltFinalRes);
imwrite(gaussianLpFiltFinalRes,'output/ex04-partA_TaxiDriver_GLPF_best.bmp');

%% Gaussian Spatial Filter (Ex04-Part B)
gaussSpatFiltStartTime = tic % setting start time
gaussSpatKernel = fspecial('gaussian',[7, 7],2); % gaussian spatial filter with sigma=2
gaussianSpatFiltFinalRes = imfilter(imgTxd,gaussSpatKernel);
gaussSpatFiltElapsedTime = toc(gaussSpatFiltStartTime) % getting finish time
figure(2);
subplot(1,2,1); imshow(gaussianSpatFiltFinalRes); subplot(1,2,2); imshow(gaussianLpFiltFinalRes);
