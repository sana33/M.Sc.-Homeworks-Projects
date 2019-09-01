clear; close all; clc; warning off

NiepceImg = im2double(imread('inputs/Niepce.jpg'));

npcTmp = medfilt2(NiepceImg,[20 20]); % applying median filter
figure; subplot(1,2,1); imshow(NiepceImg); title('Original Image');
subplot(1,2,2); imshow(npcTmp); title('Applying Median Filter');
imwrite(npcTmp,'outputs/ex02_01_medianFilter.jpg');

meanFilter = fspecial('average',20); % creating mean filter
npcTmp = imfilter(npcTmp,meanFilter); % applying mean filter
figure; subplot(1,2,1); imshow(NiepceImg); title('Original Image');
subplot(1,2,2); imshow(npcTmp); title('Applying Median + Mean Filters');
imwrite(npcTmp,'outputs/ex02_02_median+meanFilters.jpg');

npcTmp = imsharpen(npcTmp,'Radius',10,'Amount',1.2,'Threshold',1); % unsharp masking
figure; subplot(1,2,1); imshow(NiepceImg); title('Original Image');
subplot(1,2,2); imshow(npcTmp); title('Applying Median + Mean + UnsharpMasking Filters');
imwrite(npcTmp,'outputs/ex02_03_median+mean+unsharpMaskFilters.jpg');

npcTmp = imadjust(npcTmp); % contrast adjustment
figure; subplot(1,2,1); imshow(NiepceImg); title('Original Image');
subplot(1,2,2); imshow(npcTmp); title('Applying Median + Mean + UnsharpMasking Filters & Contrast Adjustment');
imwrite(npcTmp,'outputs/ex02_04_median+mean+unsharpMaskFilters&contrastAdj.jpg');

