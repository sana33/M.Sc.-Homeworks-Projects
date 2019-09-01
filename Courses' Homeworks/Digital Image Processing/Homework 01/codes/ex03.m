imBalloon = imread('input/balloon.bmp');
imPatch = imBalloon(101:200, 101:300);
imBalloonMod = imBalloon;
imBalloonMod(101:200, 101:300) = 0;

% Flipping vertically
patchVert = uint8(zeros(100, 200));
for r = 1:100
    patchVert(end-r+1, :) = imPatch(r, :);
end

% Flipping horizentally
patchHoriz = uint8(zeros(100, 200));
for c = 1:200
    patchHoriz(:, end-c+1) = imPatch(:, c);
end

imBalloonVert = imBalloon;
imBalloonVert(101:200, 101:300) = patchVert;
imBalloonHoriz = imBalloon;
imBalloonHoriz(101:200, 101:300) = patchHoriz;

imwrite(imBalloonVert, 'output/ex03_balloon_vert.bmp');
imwrite(imBalloonHoriz, 'output/ex03_balloon_horiz.bmp');
