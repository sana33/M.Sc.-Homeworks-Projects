%% Q03 - Part a
% Using a grayscale image with color-depth of 256
% img = imread('inputs\man.jpg');
% imgInf = imfinfo('inputs\man.jpg');

% img = imread('inputs\wom.jpg');
% imgInf = imfinfo('inputs\wom.jpg');

% Using a truecolor image with color-depth of 256
img = imread('inputs\peppers.png');
imgInf = imfinfo('inputs\peppers.png');

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
        
        figure(1); imshow(imgEquEmp);
        figure(2); imshow(imgEquMat);
        
%         figure(11);
%         subplot(1,3,1); stem(0:255, imhistEmpCDF(1,:), 'Marker', '.', 'MarkerSize', .5, 'Color', 'r'); ...
%             xlim([0 255]); ylim auto; grid on;
%         subplot(1,3,2); stem(0:255, imhistEmpCDF(2,:), 'Marker', '.', 'MarkerSize', .5, 'Color', 'g'); ...
%             xlim([0 255]); ylim auto; grid on;
%         subplot(1,3,3); stem(0:255, imhistEmpCDF(3,:), 'Marker', '.', 'MarkerSize', .5, 'Color', 'b'); ...
%             xlim([0 255]); ylim auto; grid on;
        
        figure(12); plot(0:255, imLevelEqu(1,:), 'r', 0:255, imLevelEqu(3,:), 'g', 0:255, imLevelEqu(2,:), 'b'); grid on;
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
        
        figure(1); imshow(imgEquEmp);
        figure(2); imshow(imgEquMat);
end
