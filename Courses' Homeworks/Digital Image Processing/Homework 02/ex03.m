%% Q03 - Part a
% Using a grayscale image with color-depth of 256
img = imread('inputs\man.jpg');
imgInf = imfinfo('inputs\man.jpg');

% Using a truecolor image with color-depth of 256
img = imread('inputs\peppers.png');
imgInf = imfinfo('inputs\peppers.png');

switch imgInf.ColorType
    case 'truecolor'
        imhistEmp = zeros(3,256);
        imhistMat = zeros(3,256);
        
        channelRed = img(:,:,1);
        [imhistMat(1,:), ~] = imhist(channelRed, 256);
        for c1 = 1:256
            imhistEmp(1,c1) = sum(channelRed(:) == c1-1);
        end
        
        channelGreen = img(:,:,2);
        [imhistMat(2,:), ~] = imhist(channelGreen, 256);
        for c1 = 1:256
            imhistEmp(2,c1) = sum(channelGreen(:) == c1-1);
        end
        
        channelBlue = img(:,:,3);
        [imhistMat(3,:), ~] = imhist(channelBlue, 256);
        for c1 = 1:256
            imhistEmp(3,c1) = sum(channelBlue(:) == c1-1);
        end
        
        figure(1);
        % Empirical histograms of the image
        subplot(2,3,1); stem(0:255, imhistEmp(1,:), 'Marker', '.', 'MarkerSize', .5, 'Color', 'r'); ...
            xlim([0 255]); ylim auto; grid on; title('Channel Red Empirical Histogram');
        subplot(2,3,2); stem(0:255, imhistEmp(2,:), 'Marker', '.', 'MarkerSize', .5, 'Color', 'g'); ...
            xlim([0 255]); ylim auto; grid on; title('Channel Green Empirical Histogram');
        subplot(2,3,3); stem(0:255, imhistEmp(3,:), 'Marker', '.', 'MarkerSize', .5, 'Color', 'b'); ...
            xlim([0 255]); ylim auto; grid on; title('Channel Blue Empirical Histogram');
        % MATLAB imhist() function histograms of the image
        subplot(2,3,4); imhist(channelRed, 256); ylim auto; grid on; title('MATLAB imhist() Histogram for Channel Red');
        subplot(2,3,5); imhist(channelGreen, 256); ylim auto; grid on; title('MATLAB imhist() Histogram for Channel Green');
        subplot(2,3,6); imhist(channelBlue, 256); ylim auto; grid on; title('MATLAB imhist() Histogram for Channel Blue');
    otherwise
        imhistEmp = zeros(256,1);
        imhistMat = zeros(256,1);
        
        [imhistMat, ~] = imhist(img, 256);
        for c1 = 1:256
            imhistEmp(c1) = sum(img(:) == c1-1);
        end
        figure(1);
        subplot(1,3,1); imshow(img);
        subplot(1,3,2); stem(0:255, imhistEmp, 'Marker', '.', 'MarkerSize', .5, 'Color', 'k'); xlim([0 255]); ylim auto; ...
            grid on; title('Empirical Histogram');
        subplot(1,3,3); imhist(img, 256); ylim auto; grid on; title('MATLAB imhist() function Histogram');
end

%% Q03 - Part c
% Comparing empirical results with MATLAB built-in imhist() function
% results
if isequal(imhistEmp, imhistMat)
    h = msgbox(sprintf('Congratulations!\n\tThe empirical results are equal with MATLAB built-in imhist() function results!'),'Success');    
else
    h = msgbox(sprintf('Unfortunately!\n\tThe empirical results are NOT equal with MATLAB built-in imhist() function results!'), 'Failure', 'error');
end
