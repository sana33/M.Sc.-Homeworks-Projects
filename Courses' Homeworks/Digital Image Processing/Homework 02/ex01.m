warning off;
%% Q01 - Part a
img01 = imread('inputs/wom.jpg');
figure(1);
subplot(1,2,1); imshow(img01); title('Q01-Part a; Original Image');
subplot(1,2,2); imhist(img01,256); title('Q01-Part a; Image Histogram');

%% Q01 - Part b
c = double(min(img01(:))); d = double(max(img01(:)));
b = 255; a = 0;
img01_strch01 = (double(img01) - c) * (b - a) / (d - c) + a;
img01_strch01 = cast(img01_strch01, 'like', img01);
figure(3); 
subplot(1,2,1); imshow(img01_strch01); title('Q01-Part b; Image after stretching contrast');
subplot(1,2,2); imhist(img01_strch01, 256); title('Q01-Part b; Image Histogram Stretched');
imwrite(img01_strch01, 'outputs\ex01_partB_wom_stretch.bmp');

%% Q01 - Part c
[img01Hist, ~] = imhist(img01, 256);
img01EDF = cumsum(img01Hist);
pixlesNo = numel(img01);
percLow = [.05 .15 .25];
percHigh = [.95 .85 .75];
c = zeros(1,3); d = zeros(1,3);
img01_strch02 = cell(1,3);
for l1 = 1:3 
    [~, c(l1)] = min(abs(img01EDF - percLow(l1) * pixlesNo)); c = double(c);
    [~, d(l1)] = min(abs(img01EDF - percHigh(l1) * pixlesNo)); d = double(d);
    imgTmp = (double(img01) - c(l1)) * (b - a) / (d(l1) - c(l1)) + a;
    imgTmp = cast(imgTmp, 'like', img01);
    img01_strch02(l1) = {imgTmp};
end
figure(5);
subplot(2,3,1); imshow(cell2mat(img01_strch02(1))); title('5th percentile - 95th percentile'); ...
    subplot(2,3,4); imhist(cell2mat(img01_strch02(1)),256);
subplot(2,3,2); imshow(cell2mat(img01_strch02(2))); title('15th percentile - 85th percentile'); ...
    subplot(2,3,5); imhist(cell2mat(img01_strch02(2)),256);
subplot(2,3,3); imshow(cell2mat(img01_strch02(3))); title('25th percentile - 75th percentile'); ...
    subplot(2,3,6); imhist(cell2mat(img01_strch02(3)),256);

%% Q01 - Part d
img01_fac3 = double(img01) * 3;
img01_fac3 = cast(img01_fac3, 'like', img01);
figure(6);
subplot(1,2,1); imshow(img01_fac3); title('Image intensity values multiplied by factor 3');
subplot(1,2,2); imhist(img01_fac3,256);

%% Q01 - Part e
img02 = imread('inputs\man.jpg');
figure(7); subplot(1,2,1); imshow(img02); subplot(1,2,2); imhist(img02, 256);

%% Q01 - Part f
r1 = double(max(img02(:)));
c1 = 255 ./ log(1 + r1);
img02_log = c1 .* log(1 + double(img02));
img02_log = im2uint8(mat2gray(img02_log));
figure(9);
subplot(1,2,1); imshow(img02_log);
subplot(1,2,2); imhist(img02_log,256);
imwrite(img02_log, 'outputs\ex01_partF_man_log.bmp');

%% Q01 - Part g
img03 = imread('inputs\svs.jpg');
r2 = double(max(img03(:))); 
c2 = 255 ./ log(1 + r2);
img03_log = c2 .* log(1 + double(img03));
img03_log = im2uint8(mat2gray(img03_log));
figure(10);
subplot(2,2,1); imshow(img03); subplot(2,2,3); imhist(img03,256);
subplot(2,2,2); imshow(img03_log); subplot(2,2,4); imhist(img03_log,256);
