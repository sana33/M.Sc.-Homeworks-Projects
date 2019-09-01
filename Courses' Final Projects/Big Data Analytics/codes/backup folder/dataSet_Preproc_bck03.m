clc; warning off

%% Considering soybean-small dataset
soybeanSm = load('..\datasets\soybean dataset\soybean-small.data');
soybeanSm = soybeanSm(:,1:end-1);
soybeanSm = [soybeanSm [zeros(10,1); ones(10,1); zeros(27,1)]];

save('soybean-small.mat','soybeanSm');

%% Considering web-advertisement dataset
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
webAd = webAd_final(:,2:end);

save('webAd.mat','webAd');

%% Considering wisconsin-breast-cancer dataset
wbc = load('..\datasets\WBC dataset\breast-cancer-wisconsin.data');

wbc = wbc(:,2:end);

save('wbc.mat','wbc');

%% Considering wisconsin-breast-cancer dataset
fid = fopen('..\datasets\autos dataset\imports-85.data','r');
formatSpec = '%d %d %s %s %s %s %s %s %s %d %d %d %d %d %s %s %d %s %d %d %d %d %d %d %d %d';
autos = textscan(fid,formatSpec,'Delimiter',',');
fclose(fid);

autos_temp = zeros(length(autos{1,1}),length(autos));
for k1 = 1:length(autos{1,1})
    autos_temp(k1,1) = autos{1,1}(k1,1);
end
for k1 = 1:length(autos{1,2})
    autos_temp(k1,2) = autos{1,2}(k1,1);
end

for k1 = 1:length(autos{1,3})
    categItem = autos{1,3}{k1,1};
    switch categItem
        case 'alfa-romero'
            autos{1,3}{k1,1} = 1;
        case 'audi'
            autos{1,3}{k1,1} = 2;
        case 'bmw'
            autos{1,3}{k1,1} = 3;
        case 'chevrolet'
            autos{1,3}{k1,1} = 4;
        case 'dodge'
            autos{1,3}{k1,1} = 5;
        case 'honda'
            autos{1,3}{k1,1} = 6;
        case 'isuzu'
            autos{1,3}{k1,1} = 7;
        case 'jaguar'
            autos{1,3}{k1,1} = 8;
        case 'mazda'
            autos{1,3}{k1,1} = 9;
        case 'mercedes-benz'
            autos{1,3}{k1,1} = 10;
        case 'mercury'
            autos{1,3}{k1,1} = 11;
        case 'mitsubishi'
            autos{1,3}{k1,1} = 12;
        case 'nissan'
            autos{1,3}{k1,1} = 13;
        case 'peugot'
            autos{1,3}{k1,1} = 14;
        case 'plymouth'
            autos{1,3}{k1,1} = 15;
        case 'porsche'
            autos{1,3}{k1,1} = 16;
        case 'renault'
            autos{1,3}{k1,1} = 17;
        case 'saab'
            autos{1,3}{k1,1} = 18;
        case 'subaru'
            autos{1,3}{k1,1} = 19;
        case 'toyota'
            autos{1,3}{k1,1} = 20;
        case 'volkswagen'
            autos{1,3}{k1,1} = 21;
        case 'volvo'
            autos{1,3}{k1,1} = 22;
        case '-inf'
            autos{1,3}{k1,1} = -inf;
    end
end
for k1 = 1:length(autos{1,3})
    autos_temp(k1,3) = autos{1,3}{k1,1};
end

for k1 = 1:length(autos{1,4})
    categItem = autos{1,4}{k1,1};
    switch categItem
        case 'diesel'
            autos{1,4}{k1,1} = 1;
        case 'gas'
            autos{1,4}{k1,1} = 2;
        case '-inf'
            autos{1,4}{k1,1} = -inf;            
    end
end
for k1 = 1:length(autos{1,4})
    autos_temp(k1,4) = autos{1,4}{k1,1};
end

for k1 = 1:length(autos{1,5})
    categItem = autos{1,5}{k1,1};
    switch categItem
        case 'std'
            autos{1,5}{k1,1} = 1;
        case 'turbo'
            autos{1,5}{k1,1} = 2;
        case '-inf'
            autos{1,5}{k1,1} = -inf;            
    end
end
for k1 = 1:length(autos{1,5})
    autos_temp(k1,5) = autos{1,5}{k1,1};
end

for k1 = 1:length(autos{1,6})
    categItem = autos{1,6}{k1,1};
    switch categItem
        case 'four'
            autos{1,6}{k1,1} = 1;
        case 'two'
            autos{1,6}{k1,1} = 2;
        case '-inf'
            autos{1,6}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,6})
    autos_temp(k1,6) = autos{1,6}{k1,1};
end

for k1 = 1:length(autos{1,7})
    categItem = autos{1,7}{k1,1};
    switch categItem
        case 'hardtop'
            autos{1,7}{k1,1} = 1;
        case 'wagon'
            autos{1,7}{k1,1} = 2;
        case 'sedan'
            autos{1,7}{k1,1} = 3;
        case 'hatchback'
            autos{1,7}{k1,1} = 4;
        case 'convertible'
            autos{1,7}{k1,1} = 5;
        case '-inf'
            autos{1,7}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,7})
    autos_temp(k1,7) = autos{1,7}{k1,1};
end

for k1 = 1:length(autos{1,8})
    categItem = autos{1,8}{k1,1};
    switch categItem
        case '4wd'
            autos{1,8}{k1,1} = 1;
        case 'fwd'
            autos{1,8}{k1,1} = 2;
        case 'rwd'
            autos{1,8}{k1,1} = 3;
        case '-inf'
            autos{1,8}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,8})
    autos_temp(k1,8) = autos{1,8}{k1,1};
end

for k1 = 1:length(autos{1,9})
    categItem = autos{1,9}{k1,1};
    switch categItem
        case 'front'
            autos{1,9}{k1,1} = 1;
        case 'rear'
            autos{1,9}{k1,1} = 2;
        case '-inf'
            autos{1,9}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,9})
    autos_temp(k1,9) = autos{1,9}{k1,1};
end

for k1 = 1:length(autos{1,10})
    autos_temp(k1,10) = autos{1,10}(k1,1);
end
for k1 = 1:length(autos{1,11})
    autos_temp(k1,11) = autos{1,11}(k1,1);
end
for k1 = 1:length(autos{1,12})
    autos_temp(k1,12) = autos{1,12}(k1,1);
end
for k1 = 1:length(autos{1,13})
    autos_temp(k1,13) = autos{1,13}(k1,1);
end
for k1 = 1:length(autos{1,14})
    autos_temp(k1,14) = autos{1,14}(k1,1);
end

for k1 = 1:length(autos{1,15})
    categItem = autos{1,15}{k1,1};
    switch categItem
        case 'dohc'
            autos{1,15}{k1,1} = 1;
        case 'dohcv'
            autos{1,15}{k1,1} = 2;
        case 'l'
            autos{1,15}{k1,1} = 3;
        case 'ohc'
            autos{1,15}{k1,1} = 4;
        case 'ohcf'
            autos{1,15}{k1,1} = 5;
        case 'ohcv'
            autos{1,15}{k1,1} = 6;
        case 'rotor'
            autos{1,15}{k1,1} = 7;
        case '-inf'
            autos{1,15}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,15})
    autos_temp(k1,15) = autos{1,15}{k1,1};
end

for k1 = 1:length(autos{1,16})
    categItem = autos{1,16}{k1,1};
    switch categItem
        case 'eight'
            autos{1,16}{k1,1} = 1;
        case 'five'
            autos{1,16}{k1,1} = 2;
        case 'four'
            autos{1,16}{k1,1} = 3;
        case 'six'
            autos{1,16}{k1,1} = 4;
        case 'three'
            autos{1,16}{k1,1} = 5;
        case 'twelve'
            autos{1,16}{k1,1} = 6;
        case 'two'
            autos{1,16}{k1,1} = 7;
        case '-inf'
            autos{1,16}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,16})
    autos_temp(k1,16) = autos{1,16}{k1,1};
end

for k1 = 1:length(autos{1,17})
    autos_temp(k1,17) = autos{1,17}(k1,1);
end

for k1 = 1:length(autos{1,18})
    categItem = autos{1,18}{k1,1};
    switch categItem
        case '1bbl'
            autos{1,18}{k1,1} = 1;
        case '2bbl'
            autos{1,18}{k1,1} = 2;
        case '4bbl'
            autos{1,18}{k1,1} = 3;
        case 'idi'
            autos{1,18}{k1,1} = 4;
        case 'mfi'
            autos{1,18}{k1,1} = 5;
        case 'mpfi'
            autos{1,18}{k1,1} = 6;
        case 'spdi'
            autos{1,18}{k1,1} = 7;
        case 'spfi'
            autos{1,18}{k1,1} = 8;
        case '-inf'
            autos{1,18}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(autos{1,18})
    autos_temp(k1,18) = autos{1,18}{k1,1};
end

for k1 = 1:length(autos{1,19})
    autos_temp(k1,19) = autos{1,19}(k1,1);
end
for k1 = 1:length(autos{1,20})
    autos_temp(k1,20) = autos{1,20}(k1,1);
end
for k1 = 1:length(autos{1,21})
    autos_temp(k1,21) = autos{1,21}(k1,1);
end
for k1 = 1:length(autos{1,22})
    autos_temp(k1,22) = autos{1,22}(k1,1);
end
for k1 = 1:length(autos{1,23})
    autos_temp(k1,23) = autos{1,23}(k1,1);
end
for k1 = 1:length(autos{1,24})
    autos_temp(k1,24) = autos{1,24}(k1,1);
end
for k1 = 1:length(autos{1,25})
    autos_temp(k1,25) = autos{1,25}(k1,1);
end
for k1 = 1:length(autos{1,26})
    autos_temp(k1,26) = autos{1,26}(k1,1);
end

autos_temp(autos_temp==-2.147483648000000e+09)=-inf;
autos_temp(isnan(autos_temp)) = -inf;

n = size(autos_temp,1);
seqVec = transpose(1:n);
autos_temp = [seqVec autos_temp];
misValIdx = find(autos_temp(:,3)==-inf | autos_temp(:,7)==-inf | autos_temp(:,20)==-inf | ...
    autos_temp(:,21)==-inf | autos_temp(:,23)==-inf | autos_temp(:,24)==-inf | autos_temp(:,27)==-inf);
misValNOTidx = setdiff(seqVec,misValIdx);
autosTemp_misVal = autos_temp(misValIdx,:);
autosTemp_NOTmisVal = autos_temp(misValNOTidx,:);

[Y2,~] = discretize(autosTemp_NOTmisVal(:,3),10);
[Y6,~] = discretize(autosTemp_NOTmisVal(:,7),10);
[Y19,~] = discretize(autosTemp_NOTmisVal(:,20),10);
[Y20,~] = discretize(autosTemp_NOTmisVal(:,21),10);
[Y22,~] = discretize(autosTemp_NOTmisVal(:,23),10);
[Y23,~] = discretize(autosTemp_NOTmisVal(:,24),10);
[Y26,~] = discretize(autosTemp_NOTmisVal(:,27),10);
autosTemp_NOTmisVal(:,3) = Y2;
autosTemp_NOTmisVal(:,7) = Y6;
autosTemp_NOTmisVal(:,20) = Y19;
autosTemp_NOTmisVal(:,21) = Y20;
autosTemp_NOTmisVal(:,23) = Y22;
autosTemp_NOTmisVal(:,24) = Y23;
autosTemp_NOTmisVal(:,27) = Y26;
mode2 = mode(Y2);
mode6 = mode(Y6);
mode19 = mode(Y19);
mode20 = mode(Y20);
mode22 = mode(Y22);
mode23 = mode(Y23);
mode26 = mode(Y26);
autosTemp_misVal(:,3) = mode2;
autosTemp_misVal(:,7) = mode6;
autosTemp_misVal(:,20) = mode19;
autosTemp_misVal(:,21) = mode20;
autosTemp_misVal(:,23) = mode22;
autosTemp_misVal(:,24) = mode23;
autosTemp_misVal(:,27) = mode26;

autos_final = [autosTemp_NOTmisVal; autosTemp_misVal];
autos_final = sortrows(autos_final,1);
autos = autos_final(:,2:end);

save('autos.mat','autos');

