clear; close all; clc; warning off

aerial = imread('inputs/aerial.bmp');
[rn, cn] = size(aerial);
imgDFT = fftshift(fft2(double(aerial)));

%% Part A
[u, v] = meshgrid(1:rn, 1:cn);
u = u - fix(rn/2) - 1; v = v - fix(cn/2) - 1;
TD = (u.^2 + v.^2) .^ (5/6);

figure; imshow(aerial); title('original');

K = [0.0025 0.00025 0.000025];

H1_blur = exp(-K(1) .* TD);
output1 = imgDFT .* H1_blur;
aerial_severe = uint8(real(ifft2(ifftshift(output1))));
figure(1); imshow(aerial_severe); title('aerial severe');
imwrite(aerial_severe,'outputs\ex05_aerial_severe.bmp');

H2_blur = exp(-K(2) .* TD);
output2 = imgDFT .* H2_blur;
aerial_mild = uint8(real(ifft2(ifftshift(output2))));
figure(2); imshow(aerial_mild); title('aerial mild');
imwrite(aerial_mild,'outputs\ex05_aerial_mild.bmp');

H3_blur = exp(-K(3) .* TD);
output3 = imgDFT .* H3_blur;
aerial_low = uint8(real(ifft2(ifftshift(output3))));
figure(3); imshow(aerial_low); title('aerial low');
imwrite(aerial_low,'outputs\ex05_aerial_low.bmp');

%% Part B
cover = imread('inputs/cover.bmp');
figure(4); subplot(3,2,1); imshow(cover); title('Original image');
% lngth = [20 30 40];
% theta = [45 55 65];
lngth = [20 20 40 60 80];
theta = [45 75 45 45 75];
Hfilter = cell(1,3);
MotionBlurredICov = cell(1,3);
for c1 = 1:5
    Hfilter(c1) = {fspecial('motion',lngth(c1),theta(c1))};
    MotionBlurredICov(c1) = {imfilter(cover,cell2mat(Hfilter(c1)),'replicate')};
    figure(4); subplot(3,2,c1+1); imshow(cell2mat(MotionBlurredICov(c1))); title(sprintf('MotionBlurred, length=%d, Theta=%d',lngth(c1),theta(c1)));
end

