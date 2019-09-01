warning('off');
face1 = imread('inputs/face1.pgm');
eye1 = imread('inputs\eye1.pgm');
mouth1 = imread('inputs\mouth1.pgm');
nose1 = imread('inputs\nose1.pgm');

face2 = imread('inputs/face2.pgm');
eye2 = imread('inputs\eye2.pgm');
mouth2 = imread('inputs\mouth2.pgm');
nose2 = imread('inputs\nose2.pgm');

%% Q07 - Part a (i)
%% Considering face1
[r1,c1] = size(face1);
%% Trying to find eye1
[er1,ec1] = size(eye1);
corrMat = zeros(r1,c1);
investMat = padarray(face1, [er1-1 ec1-1], 'post');
for l1 = 1:r1
    for l2 = 1:c1
        batch = investMat(l1:l1+er1-1,l2:l2+ec1-1);
        corrMat(l1,l2) = corr2(eye1,batch);
    end
end
[rPeak, cPeak] = find(corrMat==max(corrMat(:)));
% Detection with my own method!
figure('Name', 'Question 7 - Part a (i): eye1 detection - My own method!', 'Color', 'yellow');
subplot(1,4,1); imshowpair(face1,eye1,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
hAx = axes;
subplot(1,4,3,hAx);
imshow(face1, 'Parent', hAx); 
imrect(hAx, [cPeak, rPeak, ec1, er1]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r1,c1); binaryMap(rPeak:rPeak+er1-1, cPeak:cPeak+ec1-1) = 1;
imshow(binaryMap); title('Template Detection #2');
% Detection with MATLAB normxcorr2() method!
figure('Name', 'Question 7 - Part a (i): eye1 detection - MATLAB normxcorr2() method!', 'Color', 'yellow');
corrMat = normxcorr2(eye1,face1);
subplot(1,4,1); imshowpair(face1,eye1,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
[ypeak, xpeak] = find(corrMat==max(corrMat(:)));
yoffSet = ypeak-er1;
xoffSet = xpeak-ec1; 
hAx = axes; 
subplot(1,4,3,hAx);
imshow(face1, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, ec1, er1]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r1,c1); binaryMap(yoffSet:yoffSet+er1-1, xoffSet:xoffSet+ec1-1) = 1;
imshow(binaryMap); title('Template Detection #2');

%% Trying to find mouth1
[mr1,mc1] = size(mouth1);
corrMat = zeros(r1,c1);
investMat = padarray(face1, [mr1-1 mc1-1], 'post');
for l1 = 1:r1
    for l2 = 1:c1
        batch = investMat(l1:l1+mr1-1,l2:l2+mc1-1);
        corrMat(l1,l2) = corr2(mouth1,batch);
    end
end
[rPeak, cPeak] = find(corrMat==max(corrMat(:)));
% Detection with my own method!
figure('Name', 'Question 7 - Part a (i): mouth1 detection - My own method!', 'Color', 'yellow');
subplot(1,4,1); imshowpair(face1,mouth1,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
hAx = axes;
subplot(1,4,3,hAx);
imshow(face1, 'Parent', hAx); 
imrect(hAx, [cPeak, rPeak, mc1, mr1]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r1,c1); binaryMap(rPeak:rPeak+mr1-1, cPeak:cPeak+mc1-1) = 1;
imshow(binaryMap); title('Template Detection #2');
% Detection with MATLAB normxcorr2() method!
figure('Name', 'Question 7 - Part a (i): mouth1 detection - MATLAB normxcorr2() method!', 'Color', 'yellow');
corrMat = normxcorr2(mouth1,face1);
subplot(1,4,1); imshowpair(face1,mouth1,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
[ypeak, xpeak] = find(corrMat==max(corrMat(:)));
yoffSet = ypeak-mr1;
xoffSet = xpeak-mc1; 
hAx = axes; 
subplot(1,4,3,hAx);
imshow(face1, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, mc1, mr1]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r1,c1); binaryMap(yoffSet:yoffSet+mr1-1, xoffSet:xoffSet+mc1-1) = 1;
imshow(binaryMap); title('Template Detection #2');

%% Trying to find nose1
[nr1,nc1] = size(nose1);
corrMat = zeros(r1,c1);
investMat = padarray(face1, [nr1-1 nc1-1], 'post');
for l1 = 1:r1
    for l2 = 1:c1
        batch = investMat(l1:l1+nr1-1,l2:l2+nc1-1);
        corrMat(l1,l2) = corr2(nose1,batch);
    end
end
[rPeak, cPeak] = find(corrMat==max(corrMat(:)));
% Detection with my own method!
figure('Name', 'Question 7 - Part a (i): nose1 detection - My own method!', 'Color', 'yellow');
subplot(1,4,1); imshowpair(face1,nose1,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
hAx = axes;
subplot(1,4,3,hAx);
imshow(face1, 'Parent', hAx); 
imrect(hAx, [cPeak, rPeak, nc1, nr1]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r1,c1); binaryMap(rPeak:rPeak+nr1-1, cPeak:cPeak+nc1-1) = 1;
imshow(binaryMap); title('Template Detection #2');
% Detection with MATLAB normxcorr2() method!
figure('Name', 'Question 7 - Part a (i): nose1 detection - MATLAB normxcorr2() method!', 'Color', 'yellow');
corrMat = normxcorr2(nose1,face1);
subplot(1,4,1); imshowpair(face1,nose1,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
[ypeak, xpeak] = find(corrMat==max(corrMat(:)));
yoffSet = ypeak-nr1;
xoffSet = xpeak-nc1; 
hAx = axes; 
subplot(1,4,3,hAx);
imshow(face1, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, nc1, nr1]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r1,c1); binaryMap(yoffSet:yoffSet+nr1-1, xoffSet:xoffSet+nc1-1) = 1;
imshow(binaryMap); title('Template Detection #2');


%% Q07 - Part a (ii)
%% Considering face2
[r2,c2] = size(face2);
%% Trying to find eye2
[er2,ec2] = size(eye2);
corrMat = zeros(r2,c2);
investMat = padarray(face2, [er2-1 ec2-1], 'post');
for l1 = 1:r2
    for l2 = 1:c2
        batch = investMat(l1:l1+er2-1,l2:l2+ec2-1);
        corrMat(l1,l2) = corr2(eye2,batch);
    end
end
[rPeak, cPeak] = find(corrMat==max(corrMat(:)));
% Detection with my own method!
figure('Name', 'Question 7 - Part a (ii): eye2 detection - My own method!', 'Color', 'yellow');
subplot(1,4,1); imshowpair(face2,eye2,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
hAx = axes;
subplot(1,4,3,hAx);
imshow(face2, 'Parent', hAx); 
imrect(hAx, [cPeak, rPeak, ec2, er2]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r2,c2); binaryMap(rPeak:rPeak+er2-1, cPeak:cPeak+ec2-1) = 1;
imshow(binaryMap); title('Template Detection #2');
% Detection with MATLAB normxcorr2() method!
figure('Name', 'Question 7 - Part a (ii): eye2 detection - MATLAB normxcorr2() method!', 'Color', 'yellow');
corrMat = normxcorr2(eye2,face2);
subplot(1,4,1); imshowpair(face2,eye2,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
[ypeak, xpeak] = find(corrMat==max(corrMat(:)));
yoffSet = ypeak-er2;
xoffSet = xpeak-ec2; 
hAx = axes; 
subplot(1,4,3,hAx);
imshow(face2, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, ec2, er2]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r2,c2); binaryMap(yoffSet:yoffSet+er2-1, xoffSet:xoffSet+ec2-1) = 1;
imshow(binaryMap); title('Template Detection #2');

%% Trying to find mouth2
[mr2,mc2] = size(mouth2);
corrMat = zeros(r2,c2);
investMat = padarray(face2, [mr2-1 mc2-1], 'post');
for l1 = 1:r2
    for l2 = 1:c2
        batch = investMat(l1:l1+mr2-1,l2:l2+mc2-1);
        corrMat(l1,l2) = corr2(mouth2,batch);
    end
end
[rPeak, cPeak] = find(corrMat==max(corrMat(:)));
% Detection with my own method!
figure('Name', 'Question 7 - Part a (ii): mouth2 detection - My own method!', 'Color', 'yellow');
subplot(1,4,1); imshowpair(face2,mouth2,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
hAx = axes;
subplot(1,4,3,hAx);
imshow(face2, 'Parent', hAx); 
imrect(hAx, [cPeak, rPeak, mc2, mr2]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r2,c2); binaryMap(rPeak:rPeak+mr2-1, cPeak:cPeak+mc2-1) = 1;
imshow(binaryMap); title('Template Detection #2');
% Detection with MATLAB normxcorr2() method!
figure('Name', 'Question 7 - Part a (ii): mouth2 detection - MATLAB normxcorr2() method!', 'Color', 'yellow');
corrMat = normxcorr2(mouth2,face2);
subplot(1,4,1); imshowpair(face2,mouth2,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
[ypeak, xpeak] = find(corrMat==max(corrMat(:)));
yoffSet = ypeak-mr2;
xoffSet = xpeak-mc2; 
hAx = axes; 
subplot(1,4,3,hAx);
imshow(face2, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, mc2, mr2]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r2,c2); binaryMap(yoffSet:yoffSet+mr2-1, xoffSet:xoffSet+mc2-1) = 1;
imshow(binaryMap); title('Template Detection #2');

%% Trying to find nose2
[nr2,nc2] = size(nose2);
corrMat = zeros(r2,c2);
investMat = padarray(face2, [nr2-1 nc2-1], 'post');
for l1 = 1:r2
    for l2 = 1:c2
        batch = investMat(l1:l1+nr2-1,l2:l2+nc2-1);
        corrMat(l1,l2) = corr2(nose2,batch);
    end
end
[rPeak, cPeak] = find(corrMat==max(corrMat(:)));
% Detection with my own method!
figure('Name', 'Question 7 - Part a (ii): nose2 detection - My own method!', 'Color', 'yellow');
subplot(1,4,1); imshowpair(face2,nose2,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
hAx = axes;
subplot(1,4,3,hAx);
imshow(face2, 'Parent', hAx); 
imrect(hAx, [cPeak, rPeak, nc2, nr2]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r2,c2); binaryMap(rPeak:rPeak+nr2-1, cPeak:cPeak+nc2-1) = 1;
imshow(binaryMap); title('Template Detection #2');
% Detection with MATLAB normxcorr2() method!
figure('Name', 'Question 7 - Part a (ii): nose2 detection - MATLAB normxcorr2() method!', 'Color', 'yellow');
corrMat = normxcorr2(nose2,face2);
subplot(1,4,1); imshowpair(face2,nose2,'montage'); title('Original & Template Montage');
subplot(1,4,2); surf(corrMat); shading flat; title('Correlation Coefficients Surfing');
[ypeak, xpeak] = find(corrMat==max(corrMat(:)));
yoffSet = ypeak-nr2;
xoffSet = xpeak-nc2; 
hAx = axes; 
subplot(1,4,3,hAx);
imshow(face2, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, nc2, nr2]); title('Template Detection #1');
subplot(1,4,4);
binaryMap = zeros(r2,c2); binaryMap(yoffSet:yoffSet+nr2-1, xoffSet:xoffSet+nc2-1) = 1;
imshow(binaryMap); title('Template Detection #2');
