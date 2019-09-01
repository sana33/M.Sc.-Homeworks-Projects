clear; close all; clc; warning off

imgHouse = imread('input/house.bmp');
filtVer = mat2gray(imread('input/mask_ver.bmp'));
filtHor = mat2gray(imrotate(filtVer,90));
filtAng315 = mat2gray(imrotate(filtVer,45,'crop'));
filtAng45 = mat2gray(imrotate(filtVer,-45,'crop'));
% filtAng40 = mat2gray(imrotate(filtVer,-50,'crop'));

imgHouseFourier = fft2(imgHouse);
imgHouseMagn = fftshift(abs(imgHouseFourier));
imgHousePhase = angle(imgHouseFourier);

figure; imshow(mat2gray(log(imgHouseMagn + 1))); title('Original Image Magnitude');

reconsHouseVer = uint8(real(ifft2( ifftshift(filtVer .* imgHouseMagn) .* exp(1i * imgHousePhase) )));
figure; imshow(reconsHouseVer); title('Vertical stripes smoothed');

reconsHouseHor = uint8(real(ifft2( ifftshift(filtHor .* imgHouseMagn) .* exp(1i * imgHousePhase) )));
figure; imshow(reconsHouseHor); title('Horizontal stripes smoothed');

reconsHouseAng315 = uint8(real(ifft2( ifftshift(filtAng315 .* imgHouseMagn) .* exp(1i * imgHousePhase) )));
figure; imshow(reconsHouseAng315); title('-45 degree stripes smoothed');

reconsHouseAng45 = uint8(real(ifft2( ifftshift(filtAng45 .* imgHouseMagn) .* exp(1i * imgHousePhase) )));
figure; imshow(reconsHouseAng45); title('+45 degree stripes smoothed');

% reconsHouseAng40 = uint8(real(ifft2( ifftshift(filtAng40 .* imgHouseMagn) .* exp(1i * imgHousePhase) )));
% figure; imshow(reconsHouseAng45); title('+40 degree stripes smoothed');
% 
