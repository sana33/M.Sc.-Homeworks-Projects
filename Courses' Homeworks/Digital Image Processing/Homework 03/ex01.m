clear; close all; clc

row = 100; col = 100;
l1 = floor(row/2) + 1; l2 = floor(col/2) + 1;

%% Pattern a
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 6) = 2500;
Fmat(l1 , l2 + 6) = 2500; 
sinPatt = uint8(255 * real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_a.bmp');
imwrite(fourPatt, 'output/ex01_patt_a.bmp');

%% Pattern b
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 10) = 2500;
Fmat(l1 , l2 + 10) = 2500; 
sinPatt = uint8(255 * real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_b.bmp');
imwrite(fourPatt, 'output/ex01_patt_b.bmp');

%% Pattern c
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 14) = 2500;
Fmat(l1 , l2 + 14) = 2500; 
sinPatt = uint8(255 * real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_c.bmp');
imwrite(fourPatt, 'output/ex01_patt_c.bmp');

%% Pattern d
Fmat = zeros(row,col);
Fmat(l1, l2) = 2500;
Fmat(l1 , l2 - 2) = 1250;
Fmat(l1 , l2 + 2) = 1250; 
sinPatt = uint8(255 * real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_d.bmp');
imwrite(fourPatt, 'output/ex01_patt_d.bmp');

%% Pattern e
Fmat = zeros(row,col);
Fmat(l1, l2) = 3750;
Fmat(l1 , l2 - 2) = 1875;
Fmat(l1 , l2 + 2) = 1875; 
sinPatt = uint8(255 * real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_e.bmp');
imwrite(fourPatt, 'output/ex01_patt_e.bmp');

%% Pattern f
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 2) = 2500;
Fmat(l1 , l2 + 2) = 2500; 
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_f.bmp');
imwrite(fourPatt, 'output/ex01_patt_f.bmp');

%% Pattern g
Fmat = zeros(row,col);
Fmat(l1, l2) = 0;
Fmat(l1 , l2 - 2) = -5000;
Fmat(l1 , l2 + 2) = -5000; 
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_g.bmp');
imwrite(fourPatt, 'output/ex01_patt_g.bmp');

%% Pattern h
Fmat = zeros(row,col);
Fmat(l1, l2) = 0;
Fmat(l1 , l2 - 2) = -3750;
Fmat(l1 , l2 + 2) = -3750; 
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_h.bmp');
imwrite(fourPatt, 'output/ex01_patt_h.bmp');

%% Pattern i
Fmat = zeros(row,col);
Fmat(l1, l2) = 0;
Fmat(l1 , l2 - 2) = -2500;
Fmat(l1 , l2 + 2) = -2500; 
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_i.bmp');
imwrite(fourPatt, 'output/ex01_patt_i.bmp');

%% Pattern j
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 10) = 1250;
Fmat(l1 , l2 + 10) = 1250; 
Fmat(l1 - 10, l2) = 1250;
Fmat(l1 + 10, l2) = 1250;
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_j.bmp');
imwrite(fourPatt, 'output/ex01_patt_j.bmp');

%% Pattern k
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 5) = 1250;
Fmat(l1 , l2 + 5) = 1250; 
Fmat(l1 - 5, l2) = 1250;
Fmat(l1 + 5, l2) = 1250;
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_k.bmp');
imwrite(fourPatt, 'output/ex01_patt_k.bmp');

%% Pattern l
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 2) = 1250;
Fmat(l1 , l2 + 2) = 1250; 
Fmat(l1 - 2, l2) = 1250;
Fmat(l1 + 2, l2) = 1250;
sinPatt = uint8(255 * real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_l.bmp');
imwrite(fourPatt, 'output/ex01_patt_l.bmp');

%% Pattern m
Fmat = zeros(row,col);
Fmat(l1, l2) = 0;
Fmat(l1 , l2 - 2) = 255;
Fmat(l1 , l2 + 2) = 255; 
Fmat(l1, l2 + 6) = 255;
Fmat(l1, l2 + 10) = 255;
Fmat(l1, l2 + 14) = 255;
sinPatt = uint8(255* mat2gray(real(ifft2(fftshift(Fmat)))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_m.bmp');
imwrite(fourPatt, 'output/ex01_patt_m.bmp');

%% Pattern n
Fmat = zeros(row,col);
Fmat(l1, l2) = 0;
Fmat(l1 , l2 - 2) = 255;
Fmat(l1 , l2 + 6) = 255; 
Fmat(l1, l2 + 10) = 255;
sinPatt = uint8(255*mat2gray(real(ifft2(fftshift(Fmat)))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_n.bmp');
imwrite(fourPatt, 'output/ex01_patt_n.bmp');

%% Pattern o
Fmat = zeros(row,col);
Fmat(l1, l2) = 0;
Fmat(l1 , l2 - 2) = 255;
Fmat(l1 , l2 + 6) = 255; 
sinPatt = uint8(255*mat2gray(real(ifft2(fftshift(Fmat)))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_o.bmp');
imwrite(fourPatt, 'output/ex01_patt_o.bmp');

%% Pattern p
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 - 5, l2 + 1) = 2500;
Fmat(l1 + 5, l2 - 1) = 2500; 
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_p.bmp');
imwrite(fourPatt, 'output/ex01_patt_p.bmp');

%% Pattern q
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 + 4, l2 - 4) = 2500;
Fmat(l1 - 4, l2 + 4) = 2500; 
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_q.bmp');
imwrite(fourPatt, 'output/ex01_patt_q.bmp');

%% Pattern r
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 , l2 - 1) = 1.6667e+03;
Fmat(l1 , l2 + 1) = 1.6667e+03; 
Fmat(l1 + 9, l2 - 9) = 416.6667;
Fmat(l1 - 9, l2 + 9) = 416.6667; 
Fmat(l1 + 9, l2 + 9) = 416.6667;
Fmat(l1 - 9, l2 - 9) = 416.6667;
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_r.bmp');
imwrite(fourPatt, 'output/ex01_patt_r.bmp');

%% Pattern s
Fmat = zeros(row,col);
Fmat(l1, l2) = 5000;
Fmat(l1 + 9, l2 - 9) = 1250;
Fmat(l1 - 9, l2 + 9) = 1250; 
Fmat(l1 + 1, l2 + 1) = 1250;
Fmat(l1 - 1, l2 - 1) = 1250;
sinPatt = uint8(255*real(ifft2(fftshift(Fmat))));
fourPatt = im2uint8(mat2gray(Fmat));
imwrite(sinPatt, 'output/ex01_sin_patt_s.bmp');
imwrite(fourPatt, 'output/ex01_patt_s.bmp');

