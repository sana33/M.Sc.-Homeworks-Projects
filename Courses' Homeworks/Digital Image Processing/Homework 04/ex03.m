clear; close all; clc; warning off

blindImg01 = imread('inputs\blindssnow.jpg');
blindImg01_restored = zeros(size(blindImg01));
for c1 = 1:size(blindImg01,3)
    blindImg01_restored(:,:,c1) = notchFilter(blindImg01(:,:,c1));
end
blindImg01_restored = uint8(blindImg01_restored);
figure;
subplot(1,2,1); imshow(blindImg01); title('Original Image');
subplot(1,2,2); imshow(blindImg01_restored); title('Restored Image');
imwrite(blindImg01_restored,'outputs\ex03_blindssnow_restored.jpg');

blindImg02 = imread('inputs\blindscity.jpg');
blindImg02_restored = zeros(size(blindImg02));
for c1 = 1:size(blindImg02,3)
    blindImg02_restored(:,:,c1) = notchFilter(blindImg02(:,:,c1));
end
blindImg02_restored = uint8(blindImg02_restored);
figure;
subplot(1,2,1); imshow(blindImg02); title('Original Image');
subplot(1,2,2); imshow(blindImg02_restored); title('Restored Image');
imwrite(blindImg02_restored,'outputs\ex03_blindscity_restored.jpg');

