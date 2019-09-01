clc; warning off

% Considering web-advertisement dataset
webAd = load('..\datasets\internet-advertisement dataset\ad.data');

n = size(webAd,1);
seqVec = transpose(1:n);
webAd = [seqVec webAd];
misValIdx = find(webAd(:,2)==-inf | webAd(:,3)==-inf | webAd(:,4)==-inf);
misValNOTidx = setdiff(seqVec,misValIdx);
webAd_misVal = webAd(misValIdx,:);
webAd_temp = webAd(misValNOTidx,:);

[Y1,~] = discretize(webAd_temp(:,2),10);
[Y2,~] = discretize(webAd_temp(:,3),10);
[Y3,~] = discretize(webAd_temp(:,4),10);
webAd_temp(:,2) = Y1;
webAd_temp(:,3) = Y2;
webAd_temp(:,4) = Y3;
mode1 = mode(Y1);
mode2 = mode(Y2);
mode3 = mode(Y3);
webAd_misVal(:,2) = mode1;
webAd_misVal(:,3) = mode2;
webAd_misVal(:,4) = mode3;

webAd_final = [webAd_temp; webAd_misVal];
webAd_final = sortrows(webAd_final,1);
webAd_final = webAd_final(:,2:end);

save('webAd.mat','webAd_final');

% Considering wisconsin-breast-cancer dataset
wbc = load('..\datasets\WBC dataset\breast-cancer-wisconsin.data');

wbc = wbc(:,2:end);

% Considering wisconsin-breast-cancer dataset
autos = load('..\datasets\autos dataset\imports-85.data');
% fid = fopen('..\datasets\autos dataset\imports-85.data','r');
% formatSpec = '%d %d %s %s %s %s %s %s %s %d %d %d %d %d %s %s %d %s %d %d %d %d %d %d %d %d';
% autos = textscan(fid,formatSpec,'Delimiter',',');
% fclose(fid);





