clear; close all; clc; warning off

% presBlur = im2double(imread('inputs\presidentBLURRED.tif'));
presBlur = imread('inputs\presidentBLURRED.tif'); I = presBlur;
% PSF = im2double(imread('inputs\presidentFILTER.tif')) ./ 255;
% PSF = im2double(presFilt) ./ 255;
PSFac = load('inputs\presidentFILTER.mat'); PSFac = PSFac.sHHH;
% PSFi = ifft2(PSF);
% figure; imshow(presBlur);
% figure; imshow(presFilt);

% I = im2double(presBlur);
% LEN = 50; 
% THETA = 0; 
% noise_var = 0.001;
% est_nsr = noise_var / var(I(:)); 
% PSF = fspecial('motion',LEN,THETA);
% wnr = deconvwnr(I,PSF, est_nsr);
% wnr = deconvwnr(I,PSF, est_nsr);
% figure; imshow(wnr);

% noise_var = 0.0001;
% signal_var = var(im2double(presBlur(:)));
% wnr1 = deconvwnr(presBlur, PSFac, noise_var / signal_var);
% imshow(wnr1);
% title('Restored Image');

uniform_quantization_var = (1/256)^2 / 12;
signal_var = var(im2double(I(:)));
wnr5 = deconvwnr(presBlur, PSFac, ...
    uniform_quantization_var / signal_var);
imshow(wnr5)
title('Restoration of Blurred, Quantized Image - Estimated NSR');

