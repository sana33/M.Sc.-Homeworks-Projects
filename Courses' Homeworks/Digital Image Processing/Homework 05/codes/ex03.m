clear; close all; clc; warning off

im = imread('input\pcb.jpg');
level = graythresh(im);
imBin = im2bw(im,level);
figure(1); imshow(imBin); title('Binarized Original Image');
imBinInv = ~imBin;
figure(2); imshow(imBinInv); title('Inverted Binarized Original Image');

imInvHolSep = imdilate(imerode(imBinInv,strel('disk',21)),strel('disk',23));
figure(3); imshow(imInvHolSep); title('Inverted Holes Separated');

imInHolSepBound = imInvHolSep & ~imerode(imInvHolSep,strel('disk',2));
figure(4); imshow(imInHolSepBound); title('Inverted Holes Boundaries');

imInvHolSepFill = imfill(imInHolSepBound,'holes');
figure(5); imshow(imInvHolSepFill); title('Inverted Holes Filled After Setting Boundaries');

imInvHolSepDist = imerode(imInvHolSepFill,strel('disk',1));
figure(6); imshow(imInvHolSepDist); title('Inverted Holes Eroded Just For The Case of Indistinct Hole');

imInvHolSepMinus = imInvHolSepDist & ~imBin;
figure(7); imshow(imInvHolSepMinus); title('Inverted Holes Minus The Inverted Binarized Image');

imInvHolSepSmooth = imdilate(imInvHolSepMinus,strel('disk',2));
figure(8); imshow(imInvHolSepSmooth); title('Final Approximated Inverted Holes Smoothed');

[~,numCC] = bwlabel(imInvHolSepSmooth);
fprintf('Number of holes equals:\t%d\n',numCC);

stats = regionprops(imInvHolSepSmooth);
centroid = zeros(length(stats),2);
area = zeros(length(stats),1);
for c1 = 1:length(stats)
    centroid(c1,:) = stats(c1).Centroid;
    area(c1) = stats(c1).Area;
    fprintf('Diameter of the hole with centroid coordinates [%.2f, %.2f] is:\t%.2f\n',centroid(c1,1),centroid(c1,2),sqrt(area(c1)/pi));
end

