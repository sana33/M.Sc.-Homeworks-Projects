imIn1 = imread('input/input1.jpg');
imIn2 = imread('input/input2.jpg');

[row, col] = size(imIn1);
corrVector = zeros(1, col);

for l1 = 1:col
    batch1 = imIn1(:, end - l1 + 1:end); 
    batch1 = double(batch1(:));
    batch2 = imIn2(:, 1:l1); 
    batch2 = double(batch2(:));
    
    corrVector(l1) = corr(batch1, batch2);
end

[simValue, simLocation] = max(corrVector);

imOut = zeros(row, 2 * col - simLocation);
imOut = cast(imOut, class(imIn1));

imOut(:, 1:col-simLocation) = imIn1(:, 1:end-simLocation);
imOut(:, col-simLocation+1:end) = imIn2;

imwrite(imOut, 'output/ex08_out1.bmp');
