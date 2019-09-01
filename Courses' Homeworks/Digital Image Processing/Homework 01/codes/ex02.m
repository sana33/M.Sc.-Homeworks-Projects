im01 = imread('input/rice.png');
im02 = imread('input/cameraman.jpg');

%% Q02-part a
im01Size = size(im01);
im02Size = size(im02);
im01Resized = imresize(im01, im02Size(1:2));
im02Resized = imresize(im02, im01Size(1:2));

imwrite(im01Resized, 'output/ex02_partA_riceResized.bmp');
imwrite(im02Resized, 'output/ex02_partA_cameramanResized.bmp');

%% Q02-part b
im02ResGray = rgb2gray(im02Resized);
imAdd01 = im01 + im02ResGray;
imAdd02 = imadd(im01, im02ResGray);

imwrite(imAdd01, 'output/ex02_partB_plusOp.bmp');
imwrite(imAdd02, 'output/ex02_partB_imaddOp.bmp');

%% Q02-part c
imSubt01 = im01 - im02ResGray;
imSubt02 = imsubtract(im01, im02ResGray);

imwrite(imSubt01, 'output/ex02_partC_minusOp.bmp');
imwrite(imSubt02, 'output/ex02_partC_imsubtractOp.bmp');

%% Q02-part d
im03 = imread('input/peppers.png');

imComp01 = imcomplement(im03);

imwrite(imComp01, 'output/ex02_partD_peppersComp.bmp');

%% Q02-part e
im04 = imread('input/mir.tif');
im05 = imread('input/spine.tif');
im06 = imread('input/AT3_1m4_09.tif');

imComp02 = imcomplement(im04);
imComp03 = imcomplement(im05);
imComp04 = imcomplement(im06);

imwrite(imComp02, 'output/ex02_partE_mirComp.bmp');
imwrite(imComp03, 'output/ex02_partE_spineComp.bmp');
imwrite(imComp04, 'output/ex02_partE_AT3_1m4_09_Comp.bmp');

%% Q02-part f
im07 = imread('input/AT3_1m4_01.tif');
im08 = imread('input/AT3_1m4_02.tif');
im09 = imread('input/AT3_1m4_09.tif');
im10 = imread('input/AT3_1m4_10.tif');

% fprintf('Question 02 part f parameters:\n');
% w1 = input('w1:\n'); w2 = input('w2:\n'); w3 = input('w3:\n'); w4 = input('w4:\n');
prompt = {'w1:', 'w2:', 'w3:', 'w4:'};
dlg_title = 'Needed weights:';
num_lines = 1;
def_answers = {'.3', '.2', '.4', '.1'};
options = 'on';
userInput = inputdlg(prompt, dlg_title, num_lines, def_answers, options);
finWeights = [str2num(userInput{1}) str2num(userInput{2}) str2num(userInput{3}) str2num(userInput{4})];
imBlend = finWeights(1) .* im07 + finWeights(2) .* im08 + finWeights(3) .* im09 + finWeights(4) .* im10;

imwrite(imBlend, 'output/ex02_partF_imBlend.bmp');
