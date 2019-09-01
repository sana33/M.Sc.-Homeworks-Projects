clear; close all; clc; warning off

im = imread('input\circle_and_lines.jpg'); % loading input image 'circle_and_lines.jpg'
level = graythresh(im); % setting a threshold value for converting the graylevel image to a rational binary one
imBin = im2bw(im,level); % converting input image to binary
figure(1); imshow(imBin); title('Original image of Circles and Lines'); hold on; % exhibiting binary image

%% Separating circles
se1 = strel('disk',6); % making a structuring element
imCircles = imopen(imBin,se1); % applying opening on binary image with se1 to separate circles out
figure(2); imshow(imCircles); title('Image of Circles Separated'); hold on; % exhibiting image of circles separated
s = regionprops(imCircles); % using function of regionprops to find out no. of connected components and thier properties
centroidsCirPos = cat(1,s.Centroid); centroidsCirCol = rand(length(s),3); % setting centroids of connected components to show them specifically
for c1 = 1:length(s); plot(centroidsCirPos(c1,1),centroidsCirPos(c1,2),'o','Color',centroidsCirCol(c1,:),'LineWidth',3); end
[labelCircle,numCircles] = bwlabel(imCircles,8); % using function of bwlabel to count no. of connected components
fprintf('Number of circles equals:\t%d\n',numCircles);

%% Separating lines
centroidsLinPos = []; lineCount = 0; % initialization for centroids of lines
linDeg0 = imopen(imBin,strel('line',60,0)); % applying opening with appropriate se to find lines with slope of 0 degrees
s = regionprops(linDeg0); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine0,numLines0] = bwlabel(linDeg0,8); % using function of bwlabel to count no. of connected components

linDeg10 = imopen(imBin,strel('line',60,10)); % applying opening with appropriate se to find lines with slope of 10 degrees
s = regionprops(linDeg10); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine10,numLines10] = bwlabel(linDeg10,8); % using function of bwlabel to count no. of connected components

linDeg20 = imopen(imBin,strel('line',60,20)); % applying opening with appropriate se to find lines with slope of 20 degrees
s = regionprops(linDeg20); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine20,numLines20] = bwlabel(linDeg20,8); % using function of bwlabel to count no. of connected components

linDeg75 = imopen(imBin,strel('line',60,75)); linDeg75 = imclose(linDeg75,strel('line',60,75)); % applying opening and closing successively with appropriate se to find lines with slope of 75 degrees
s = regionprops(linDeg75); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine75,numLines75] = bwlabel(linDeg75,8); % using function of bwlabel to count no. of connected components

linDeg95 = imopen(imBin,strel('line',40,95)); linDeg95 = imdilate(linDeg95,strel('disk',1)); % applying opening and dilating with appropriate se to find lines with slope of 95 degrees
s = regionprops(linDeg95); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine95,numLines95] = bwlabel(linDeg95,8); % using function of bwlabel to count no. of connected components

linDeg135 = imopen(imBin,strel('line',60,135)); linDeg135 = imdilate(linDeg135,strel('disk',1)); % applying opening and dilating with appropriate se to find lines with slope of 135 degrees
s = regionprops(linDeg135); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine135,numLines135] = bwlabel(linDeg135,8); % using function of bwlabel to count no. of connected components

linDeg170 = imopen(imBin,strel('line',60,170)); % applying opening with appropriate se to find lines with slope of 170 degrees
s = regionprops(linDeg170); % using function of regionprops to find out no. of connected components and thier properties
centroidsLinPos = [centroidsLinPos; cat(1,s.Centroid)]; lineCount = lineCount + length(s);
[labelLine170,numLines170] = bwlabel(linDeg170,8); % using function of bwlabel to count no. of connected components

imLines = linDeg0 | linDeg10 | linDeg20 | linDeg75 | linDeg95 | linDeg135 | linDeg170; % applying logical OR operation to combine results of multiple lines with multiple slopes
figure(3); imshow(imLines); title('Image of Lines Separated'); hold on;
centroidsLinCol = rand(lineCount,3);
for c1 = 1:lineCount; plot(centroidsLinPos(c1,1),centroidsLinPos(c1,2),'s','Color',centroidsLinCol(c1,:),'LineWidth',3); end % setting centroids of connected components to show them specifically
fprintf('Number of lines equals:\t%d\n',numLines0+numLines10+numLines20+numLines75+numLines95+numLines135+numLines170);

centroidsFinalPos = [centroidsCirPos; centroidsLinPos]; centroidsFinalCol = rand(length(centroidsFinalPos),3); % setting centroids of all objects to show them totally
figure(1);
for c1 = 1:length(centroidsFinalPos); plot(centroidsFinalPos(c1,1),centroidsFinalPos(c1,2),'*','Color',centroidsFinalCol(c1,:),'LineWidth',3); end
title('Image of Circles and Lines Each Marked By a Distinct Color');
