clear; close all; clc; warning off

imgNames = {'falcon.jpg','girl.jpg','hotballoon.jpg','dog.jpg'};
imgMassCent = zeros(length(imgNames),2);
for c1 = 1:length(imgNames)
    img = imread(['input\',cell2mat(imgNames(c1))]);
    level = graythresh(img);
    imgBin = im2bw(img,level);
    imgBinInv = ~im2bw(img,level);
    s = regionprops(imgBinInv);
    areas = cat(1,s.Area);
    centroids = cat(1,s.Centroid);
    [~,idx] = max(areas);
    figure; imshow(imgBinInv); hold on;
    plot(centroids(idx,1),centroids(idx,2),'bs','LineWidth',7);
end