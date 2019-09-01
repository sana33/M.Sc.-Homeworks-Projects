%% Q03 - Part a
[FileName, PathName] = uigetfile('inputs/*.*', 'Select the desired image to be equalized');
if ~FileName
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    data = importdata([PathName FileName]);
    if isstruct(data)
        img = data.cdata;
        imgInf = imfinfo([PathName FileName]);
    else
        img = data;
        imgInf = imfinfo([PathName FileName]);
    end
    h = msgbox('Image file was loaded successfully!', 'Success');
    pause(2);
end

imgSize = imgInf.Height * imgInf.Width;

switch imgInf.ColorType
    case 'truecolor'
        imhistEmp = zeros(3,256);
        imhistEmpCDF = zeros(3,256);
        
        channelRed = img(:,:,1);
        for c1 = 1:256
            imhistEmp(1,c1) = sum(channelRed(:) == c1-1);
        end
        imhistEmpCDF(1,:) = cumsum(imhistEmp(1,:));
        
        channelGreen = img(:,:,2);
        for c1 = 1:256
            imhistEmp(2,c1) = sum(channelGreen(:) == c1-1);
        end
        imhistEmpCDF(2,:) = cumsum(imhistEmp(2,:));
        
        channelBlue = img(:,:,3);
        for c1 = 1:256
            imhistEmp(3,c1) = sum(channelBlue(:) == c1-1);
        end
        imhistEmpCDF(3,:) = cumsum(imhistEmp(3,:));
        
        imhistEmpCDF = imhistEmpCDF ./ imgSize;
        imLevelEqu = round(imhistEmpCDF .* 255);
        
        imgEquEmp = img;
        imgEquMat = img;
        for c2 = 1:3
            chOrig = imgEquEmp(:,:,c2);
            chEqu = imLevelEqu(c2,:);
            chOrig(:) = chEqu(chOrig(:)+1);
            imgEquEmp(:,:,c2) = chOrig;
            imgEquMat(:,:,c2) = histeq(img(:,:,c2),256);
        end
        
        figure(1);
        subplot(1,2,1); imshow(imgEquEmp); title('Histogram equalized empirically');
        subplot(1,2,2); imshow(imgEquMat); title('Histogram equalized with MATLAB function');
        
        [imgPathStr, imgName, imgExt] = fileparts(FileName);
        imwrite(imgEquEmp, sprintf('outputs/ex04_%s_RGB_equalEmpirical.bmp', imgName));
        imwrite(imgEquMat, sprintf('outputs/ex04_%s_RGB_equalMATLAB.bmp', imgName));
        
    otherwise
        imhistEmp = zeros(256,1);
        imhistEmpCDF = zeros(256,1);

        for c1 = 1:256
            imhistEmp(c1) = sum(img(:) == c1-1);
        end
        imhistEmpCDF = cumsum(imhistEmp) ./ imgSize;
        imLevelEqu = round(imhistEmpCDF .* 255);
        
        imgEquEmp = img;
        imgEquMat = img;
        
        imgEquEmp(:) = imLevelEqu(img(:)+1);
        [imgEquMat, T] = histeq(img,256);
        
        figure(1);
        subplot(1,2,1); imshow(imgEquEmp); title('Histogram equalized empirically');
        subplot(1,2,2); imshow(imgEquMat); title('Histogram equalized with MATLAB function');
        
        [imgPathStr, imgName, imgExt] = fileparts(FileName);
        imwrite(imgEquEmp, sprintf('outputs/ex04_%s_grayScale_equalEmpirical.bmp', imgName));
        imwrite(imgEquMat, sprintf('outputs/ex04_%s_grayScale_equalMATLAB.bmp', imgName));
end
