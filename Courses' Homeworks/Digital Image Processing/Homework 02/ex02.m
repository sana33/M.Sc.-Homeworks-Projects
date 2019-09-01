warning off;
%% Q02
img01 = [
    6 4 4 4 4 4 4 0;
    6 5 5 5 5 5 4 0;
    6 5 7 7 6 5 4 0;
    6 5 7 7 6 5 4 0;
    6 5 7 7 6 5 4 0;
    6 5 5 5 5 5 4 4;
    6 4 4 5 4 4 4 4;
    6 4 4 5 4 4 4 4;
    ];
img01_m2g = mat2gray(img01);
img01_rs = imresize(img01_m2g,40,'nearest');
figure(1); imshow(img01_rs);
