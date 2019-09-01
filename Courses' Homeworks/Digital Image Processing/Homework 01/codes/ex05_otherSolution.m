[FileName, PathName] = uigetfile('input/*.*', 'Select the desired image to be resized');
if ~FileName
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    data = importdata([PathName FileName]);
    if isstruct(data)
        imIn = data.cdata;
    else
%         imIn = rgb2gray(data);
        imIn = data;
    end
    h = msgbox('Image file was loaded successfully!', 'Success');
    pause(2);
end

imSize = size(imIn);

prompt = {'Output height:', 'Output width:'};
dlg_title = 'Output dimensions:';
num_lines = 1;
def_answers = {num2str(imSize(1)), num2str(imSize(2))};
options = 'on';
userInput = inputdlg(prompt, dlg_title, num_lines, def_answers, options);
outDims = [str2num(userInput{1}) str2num(userInput{2})];

imInRows = imSize(1);
imInCols = imSize(2);
imOutRows = outDims(1);
imOutCols = outDims(2);

rowRatio = imInRows / imOutRows;
colRatio = imInCols / imOutCols;

[cModif, rModif] = meshgrid(1 : imOutCols, 1 : imOutRows);

rModif = rModif * rowRatio;
cModif = cModif * colRatio;

rFloor = floor(rModif);
cFloor = floor(cModif);

rFloor(rFloor < 1) = 1;
cFloor(cFloor < 1) = 1;
rFloor(rFloor > imInRows - 1) = imInRows - 1;
cFloor(cFloor > imInCols - 1) = imInCols - 1;

deltaR = rModif - rFloor;
deltaC = cModif - cFloor;

in1Index = sub2ind([imInRows, imInCols], rFloor, cFloor);
in2Index = sub2ind([imInRows, imInCols], rFloor+1,cFloor);
in3Index = sub2ind([imInRows, imInCols], rFloor, cFloor+1);
in4Index = sub2ind([imInRows, imInCols], rFloor+1, cFloor+1);       

imOut = zeros(imOutRows, imOutCols, size(imIn, 3));
imOut = cast(imOut, class(imIn));

for imCh = 1 : size(imIn, 3)
    imChanel = double(imIn(:,:,imCh));
    imTemp = imChanel(in1Index).*(1 - deltaR).*(1 - deltaC) + ...
                   imChanel(in2Index).*(deltaR).*(1 - deltaC) + ...
                   imChanel(in3Index).*(1 - deltaR).*(deltaC) + ...
                   imChanel(in4Index).*(deltaR).*(deltaC);
    imOut(:,:,imCh) = cast(imTemp, class(imIn));
end

[imInPathStr, imInName, inInExt] = fileparts(FileName);
imwrite(imOut, sprintf('output/ex05_%s_resized.bmp', imInName));