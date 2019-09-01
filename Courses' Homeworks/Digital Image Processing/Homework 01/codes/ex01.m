im = zeros(512);

%% Q01-part a
figure(1);
imshow(im);
imwrite(im, 'output/ex01_partA_image.bmp');

%% Q01-part b
imSize = size(im);
imReshaped = reshape(im, prod(imSize), []);

circle200_200 = pixNeighbors(200, 200, 512, 512, 16);
circle232_200 = pixNeighbors(232, 200, 512, 512, 16);
circle200_300 = pixNeighbors(200, 300, 512, 512, 16);
circle248_300 = pixNeighbors(248, 300, 512, 512, 16);
circle200_400 = pixNeighbors(200, 400, 512, 512, 16);
circle264_400 = pixNeighbors(264, 400, 512, 512, 16);
circles = [circle200_200; circle232_200; circle200_300; circle248_300; circle200_400; circle264_400];

linearIndex = sub2ind(size(im), circles(:,1), circles(:,2));
imReshaped(linearIndex) = 1;
im = reshape(imReshaped, imSize);
imwrite(im, 'output/ex01_partB_image.bmp');

figure(2);
imshow(im);