clear; close all; clc; warning off

image = imread('inputs/BWCheckboard.bmp');
image = im2double(image);
figure; subplot(1,2,1); imshow(image); subplot(1,2,2); imhist(image); title('Original Image'); saveas(gcf,'outputs/ex01_Original_Image.png');;
noiseIntens = .2;

%% Applying salt and pepper noise
noiseMat = rand(size(image));
saltNsInd = find(noiseMat > (1 - noiseIntens/2)); pepperNsInd = find(noiseMat < noiseIntens/2);
imNoisedSaltPepper = image; 
imNoisedSaltPepper(saltNsInd) = 1; imNoisedSaltPepper(pepperNsInd) = 0;
figure; 
subplot(1,2,1); imshow(imNoisedSaltPepper); subplot(1,2,2); imhist(imNoisedSaltPepper);
title('Salt & Pepper Noise');
saveas(gcf,'outputs/ex01_Noised_Salt&Pepper.png');

%% Applying uniform noise
noiseMat = rand(size(image));
noiseMat = (noiseMat*noiseIntens - noiseIntens/2);
imNoisedUniform = uint8(255 * (image + noiseMat));
figure;
subplot(1,2,1); imshow(imNoisedUniform); subplot(1,2,2); imhist(imNoisedUniform);
title('Uniform Noise');
saveas(gcf,'outputs/ex01_Noised_Uniform.png');

%% Applying gaussian noise
noiseMat = (noiseIntens/2) * randn(size(image));
imNoisedGaussian = uint8(255 * (image + noiseMat));
figure; 
subplot(1,2,1); imshow(imNoisedGaussian); subplot(1,2,2); imhist(imNoisedGaussian);
title('Gaussian Noise');
saveas(gcf,'outputs/ex01_Noised_Gaussian.png');

%% Applying rayleigh noise
noiseMat = random('rayl',noiseIntens/2,size(image,1),size(image,2));
imNoisedRayl = uint8(255 * (image + noiseMat));
figure; 
subplot(1,2,1); imshow(imNoisedRayl); subplot(1,2,2); imhist(imNoisedRayl);
title('Rayleigh Noise');
saveas(gcf,'outputs/ex01_Noised_Rayleigh.png');

%% Applying gamma noise
noiseMat = random('Gamma',.5,1,size(image,1),size(image,2));
imNoisedGamma = uint8(255 * (image + noiseMat));
figure; 
subplot(1,2,1); imshow(imNoisedGamma); subplot(1,2,2); imhist(imNoisedGamma);
title('Gamma Noise');
saveas(gcf,'outputs/ex01_Noised_Gamma.png')

%% Applying exponential noise
noiseMat = random('exp',noiseIntens/2,size(image,1),size(image,2));
imNoisedExp = uint8(255 * (image + noiseMat));
figure; 
subplot(1,2,1); imshow(imNoisedExp); subplot(1,2,2); imhist(imNoisedExp);
title('Exponential Noise');
saveas(gcf,'outputs/ex01_Noised_Exponential.png');
