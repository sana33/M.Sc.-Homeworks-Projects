clear; close all; clc; warning off

imgNames = {'falcon.jpg','girl.jpg','hotballoon.jpg','dog.jpg'};
imgThined = cell(1,length(imgNames));
for c1 = 1:length(imgNames)
    img = imread(['input\',cell2mat(imgNames(c1))]);
    level = graythresh(img);
    imgBin = im2bw(img,level);
    imgBinInv = ~im2bw(img,level);
    imgThined(c1) = {bwmorph(imgBinInv,'skel',inf)};
    figure;
    subplot(1,2,1); imshow(imgBinInv); subplot(1,2,2); imshow(cell2mat(imgThined(c1)));
end