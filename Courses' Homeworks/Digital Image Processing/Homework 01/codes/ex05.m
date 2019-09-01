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

imSize = [size(imIn,1) size(imIn,2) size(imIn,3)];

prompt = {'Output height:', 'Output width:'};
dlg_title = 'Output dimensions (smaller than the input image):';
num_lines = 1;
def_answers = {num2str(ceil(imSize(1)/2)), num2str(ceil(imSize(2)/2))};
options = 'on';
userInput = inputdlg(prompt, dlg_title, num_lines, def_answers, options);
outDims = [str2num(userInput{1}) str2num(userInput{2})];

rowRatio = imSize(1) / outDims(1);
colRatio = imSize(2) / outDims(2);

imOut = zeros(outDims(1), outDims(2), imSize(3));
imOut = cast(imOut, class(imIn));

for c1 = 1:imSize(3)
    for c2 = 1:outDims(1)
        for c3 = 1:outDims(2)
            imSqPart = imIn(ceil((c2-1)*rowRatio)+1:ceil(c2*rowRatio), ceil((c3-1)*colRatio)+1:ceil(c3*colRatio), c1);
            imOut(c2, c3, c1) = mean(imSqPart(:));
        end
    end
end

[imInPathStr, imInName, inInExt] = fileparts(FileName);
imwrite(imOut, sprintf('output/ex05_%s_resized.bmp', imInName));
