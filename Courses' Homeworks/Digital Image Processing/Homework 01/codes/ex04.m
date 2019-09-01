imBird = imread('input/bird.jpg');
imBirdGray = rgb2gray(imBird);

for l1 = 1:7
    mask = 255 - 2 .^ l1 + 1;
    imOut = bitand(imBirdGray, mask);
    
    imwrite(imOut, sprintf('output/ex04_out%02d.bmp', 8 - l1));
end
