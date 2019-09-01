clear; close all; clc; warning off

im = imread('input\circle_and_lines.jpg');
level = graythresh(im);
imBin = im2bw(im,level);
figure; imshow(imBin);

%% Separating circles
se1 = strel('disk',9);
imCircles = imopen(imBin,se1);
figure; imshow(imCircles);
se1 = strel('disk',3);
imCircles = imopen(imBin,se1);
figure; imshow(imCircles);
se1 = strel('disk',6);
imCircles = imopen(imBin,se1);
figure; imshow(imCircles);
[~,numCC] = bwlabel(imCircles,8);
imwrite(imCircles,'output\ex04_circle.png');

%% Separating lines
linDeg0 = imopen(imBin,strel('line',60,0)); figure; imshow(linDeg0);
linDeg10 = imopen(imBin,strel('line',60,10)); figure; imshow(linDeg10);
linDeg20 = imopen(imBin,strel('line',60,20)); figure; imshow(linDeg20);
linDeg75 = imopen(imBin,strel('line',60,75)); linDeg75 = imclose(linDeg75,strel('line',60,75)); figure; imshow(linDeg75);
linDeg95 = imopen(imBin,strel('line',40,95)); linDeg95 = imdilate(linDeg95,strel('disk',1)); figure; imshow(linDeg95);
linDeg135 = imopen(imBin,strel('line',60,135)); linDeg135 = imdilate(linDeg135,strel('disk',1)); figure; imshow(linDeg135);
linDeg170 = imopen(imBin,strel('line',60,170)); figure; imshow(linDeg170);

imLines = linDeg0 | linDeg10 | linDeg20 | linDeg75 | linDeg95 | linDeg135 | linDeg170;
figure; imshow(imLines);
imwrite(imLines,'output\ex04_line.png');
