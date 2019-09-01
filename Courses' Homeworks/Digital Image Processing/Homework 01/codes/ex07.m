imIn = imread('input\cameraman.jpg');

imSize = size(imIn);
rows = imSize(1);
cols = imSize(2);
page = imSize(3);

xCenter = rows / 2;
yCenter = cols / 2;

prompt = {'Xshear:', 'Yshear:'};
dlg_title = 'Xshear and Yshear values:';
num_lines = 1;
def_answers = {'.2', '.4'};
options = 'on';
userInput = inputdlg(prompt, dlg_title, num_lines, def_answers, options);
xyShear = [str2num(userInput{1}) str2num(userInput{2})];
xShear = xyShear(1);
yShear = xyShear(2);

shearMat = [1, xShear; yShear, 1];
shearMatInv = [1, xShear; yShear, 1] ^ -1;

shearedImage = zeros(rows ,cols, page);
shearedImage = cast(shearedImage, class(imIn));

for r = 1:rows
    for c = 1:cols
        sourcePos = shearMatInv * ([r; c] - [xCenter; yCenter]) + [xCenter; yCenter];
        sourcePos = round(sourcePos);
        if( sourcePos(1) < 1 || sourcePos(1) > rows || sourcePos(2) < 1 || sourcePos(2) > cols)
            continue;
        end
        shearedImage(r, c, :) = imIn(sourcePos(1), sourcePos(2), :);
    end
end

imwrite(shearedImage, sprintf('output/ex07_cameramanSheared_xSh%.2f_ySh%.2f.bmp', xShear, yShear));
