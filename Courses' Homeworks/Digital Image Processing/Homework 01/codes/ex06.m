im = imread('input\girl.jpg');

imSize = size(im);
bSize = [4 8 16 32];
imOut = uint8(zeros(imSize));

for c1 = 1:length(bSize)
    for c2 = 1:imSize(1) / bSize(c1)
        for c3 = 1:imSize(2) / bSize(c1)
            imSqPart = im((c2-1)*bSize(c1)+1:c2*bSize(c1), (c3-1)*bSize(c1)+1:c3*bSize(c1));
            imSqPartMean = mean(imSqPart(:));
            imOut((c2-1)*bSize(c1)+1:c2*bSize(c1), (c3-1)*bSize(c1)+1:c3*bSize(c1)) = imSqPartMean;
        end
    end
    imwrite(imOut, sprintf('output/ex06_girl_%d.bmp', bSize(c1)));
end
