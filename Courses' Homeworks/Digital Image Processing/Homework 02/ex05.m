img01 = imread('inputs\pigeon.jpg');
img02 = imread('inputs\soldier.jpg');

figure(1);
subplot(2,3,1); imshow(img01); title('Original Img#1');
subplot(2,3,2); imshow(img02); title('Original Img#2');

subplot(2,3,4); imhist(img01,256); title('Histogram of original Img#1');
subplot(2,3,5); imhist(img02,256); title('Histogram of original Img#2');

img01EmpCDF = cumsum(imhist(img01,256)) ./ numel(img01);
img02EmpCDF = cumsum(imhist(img02,256)) ./ numel(img02);

img01LevelEqu = round(img01EmpCDF .* 255);
img02LevelEqu = round(img02EmpCDF .* 255);

finalInd = zeros(256,1);
for cc = 1:256
%     [~, index] = min(abs(img01EmpCDF(cc) - img02EmpCDF));
    [~, index] = min(abs(img01LevelEqu(cc) - img02LevelEqu));
    finalInd(cc) = index - 1;
end

img01EquTOimg02 = uint8(finalInd(img01+1));

subplot(2,3,3); imshow(img01EquTOimg02); title('Img#1 equalized to img#2');
subplot(2,3,6); imhist(img01EquTOimg02,256); title('Img#1 histogram equalized to that of img#2');

imwrite(img01EquTOimg02, 'outputs\ex05_pigeonEqu2soldier.bmp');
