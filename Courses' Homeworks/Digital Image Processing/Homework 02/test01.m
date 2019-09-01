% %% PART a -> Obtaining histogram wom
% wom = imread('inputs/wom.jpg');
% 
% % show the histogram
% figure; imhist(wom, 256);
% 
% %% PART b -> contrast streching 
% a = 0; b = 255; c = double(min(wom(:))); d = double(max(wom(:))); 
% wom_strech = uint8((double(wom) - c) * (b-a) / (d - c) + a);
% 
% figure; imhist(wom_strech, 256);
% figure; imshow(wom_strech);
% imwrite(wom_strech, 'outputs/wom_strech.bmp');
% 
% %% PART c -> contrast streching with noise
% 
% % we first calculate the cumulative histogram of input image (wom.jpg)
% womHist = cumsum(imhist(wom, 256));
% 
% % we set the desired lower and upper bounds to 0 and 255
% a = 0; b = 255; 
% 
% % to find the actual lower and upper bounds, we choose the lower bound as
% % the gray level in which %5 of the pixels has a value lower than that and
% % do the same with 95% for upper bound
% numberOfPixels = size(wom, 1) * size(wom, 2);
% [~, c] = min(abs(womHist - 0.05 * numberOfPixels));
% [~, d] = min(abs(womHist - 0.95 * numberOfPixels));
% 
% % instead of the above works we can use matlab build-in function for
% % choosing c and d as follow:
% % 
% % bounds = stretchlim(wom, [0.05, 0.95]);
% % c = bounds(1);
% % d = bounds(2);
% 
% wom_strech_2 = uint8((double(wom) - c) * (b-a) / (d - c) + a);
% 
% figure; imhist(wom_strech_2, 256);
% figure; imshow(wom_strech_2);
% 
% %% PART e -> Obtaining histogram man
% man = imread('inputs/man.jpg');
% 
% % show the histogram
% figure; imhist(man, 256);
% 
% %% PART f -> logarithm operator
% man_log = im2uint8( mat2gray( log ( 1 + double(man))));
% 
% figure; imshow(man_log);
% imwrite(man_log, 'outputs/man_log.bmp');
% 
% %% PART g -> logarithm operator 2
% svs = imread('inputs/svs.jpg');
% svs_log = im2uint8( mat2gray( log ( 1 + double(svs))));
% 
% figure; imshow(svs);
% figure; imhist(svs, 256);
% figure; imshow(svs_log);
% figure; imhist(svs_log, 256);

img01 = [0 0 0 0 0; 0 0 1 0 0; 0 1 2 1 0; 0 0 3 0 0; 0 0 0 0 0];
mask01 = [1 2 1; 2 4 2; 1 2 1];
img01Filt = imfilter(img01,mask01);

maskTT = [1/9 1/9 1/9; 1/9 1/9 1/9 ;1/9 1/9 1/9 ];

img03 = [
    10 11 9 25 22;
    8 10 9 26 28;
    9 8 9 24 25;
    11 11 12 23 22;
    10 11 9 22 25];
img03Filt = imfilter(img03,[0 -1 0; -1 5 -1; 0 -1 0]);


