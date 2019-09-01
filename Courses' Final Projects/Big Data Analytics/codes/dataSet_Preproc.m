clc; warning off

%% Considering soybean-small dataset
ds = load('..\datasets\soybean dataset\soybean-small.data');
ds = ds(:,1:end-1);
ds = [ds [zeros(10,1); ones(10,1); zeros(27,1)]];

featUnqFreq = featFreqFunc(ds(:,1:end-1));
soybeanSm = cell(1,2);
soybeanSm{1,1} = ds; soybeanSm{1,2} = featUnqFreq;
save('soybean-small.mat','soybeanSm');

%% Considering web-advertisement dataset
ds = load('..\datasets\internet-advertisement dataset\ad.data');

n = size(ds,1);
seqVec = transpose(1:n);
ds = [seqVec ds];
misValIdx = find(ds(:,2)==-inf | ds(:,3)==-inf | ds(:,4)==-inf);
misValNOTidx = setdiff(seqVec,misValIdx);
ds_misVal = ds(misValIdx,:);
ds_temp = ds(misValNOTidx,:);

[Y1,~] = discretize(ds_temp(:,2),10);
[Y2,~] = discretize(ds_temp(:,3),10);
[Y3,~] = discretize(ds_temp(:,4),10);
ds_temp(:,2) = Y1;
ds_temp(:,3) = Y2;
ds_temp(:,4) = Y3;
mode1 = mode(Y1);
mode2 = mode(Y2);
mode3 = mode(Y3);
ds_misVal(:,2) = mode1;
ds_misVal(:,3) = mode2;
ds_misVal(:,4) = mode3;

ds_final = [ds_temp; ds_misVal];
ds_final = sortrows(ds_final,1);
ds = ds_final(:,2:end);

featUnqFreq = featFreqFunc(ds(:,1:end-1));
webAd = cell(1,2);
webAd{1,1} = ds; webAd{1,2} = featUnqFreq;
save('webAd.mat','webAd');

%% Considering wisconsin-breast-cancer dataset
ds = load('..\datasets\WBC dataset\breast-cancer-wisconsin.data');

ds = ds(:,2:end);

featUnqFreq = featFreqFunc(ds(:,1:end-1));
wbc = cell(1,2);
wbc{1,1} = ds; wbc{1,2} = featUnqFreq;
save('wbc.mat','wbc');

%% Considering autos dataset
fid = fopen('..\datasets\autos dataset\imports-85.data','r');
formatSpec = '%d %d %s %s %s %s %s %s %s %d %d %d %d %d %s %s %d %s %d %d %d %d %d %d %d %d';
ds = textscan(fid,formatSpec,'Delimiter',',');
fclose(fid);

ds_temp = zeros(length(ds{1,1}),length(ds));
for k1 = 1:length(ds{1,1})
    ds_temp(k1,1) = ds{1,1}(k1,1);
end
for k1 = 1:length(ds{1,2})
    ds_temp(k1,2) = ds{1,2}(k1,1);
end

for k1 = 1:length(ds{1,3})
    categItem = ds{1,3}{k1,1};
    switch categItem
        case 'alfa-romero'
            ds{1,3}{k1,1} = 1;
        case 'audi'
            ds{1,3}{k1,1} = 2;
        case 'bmw'
            ds{1,3}{k1,1} = 3;
        case 'chevrolet'
            ds{1,3}{k1,1} = 4;
        case 'dodge'
            ds{1,3}{k1,1} = 5;
        case 'honda'
            ds{1,3}{k1,1} = 6;
        case 'isuzu'
            ds{1,3}{k1,1} = 7;
        case 'jaguar'
            ds{1,3}{k1,1} = 8;
        case 'mazda'
            ds{1,3}{k1,1} = 9;
        case 'mercedes-benz'
            ds{1,3}{k1,1} = 10;
        case 'mercury'
            ds{1,3}{k1,1} = 11;
        case 'mitsubishi'
            ds{1,3}{k1,1} = 12;
        case 'nissan'
            ds{1,3}{k1,1} = 13;
        case 'peugot'
            ds{1,3}{k1,1} = 14;
        case 'plymouth'
            ds{1,3}{k1,1} = 15;
        case 'porsche'
            ds{1,3}{k1,1} = 16;
        case 'renault'
            ds{1,3}{k1,1} = 17;
        case 'saab'
            ds{1,3}{k1,1} = 18;
        case 'subaru'
            ds{1,3}{k1,1} = 19;
        case 'toyota'
            ds{1,3}{k1,1} = 20;
        case 'volkswagen'
            ds{1,3}{k1,1} = 21;
        case 'volvo'
            ds{1,3}{k1,1} = 22;
        case '-inf'
            ds{1,3}{k1,1} = -inf;
    end
end
for k1 = 1:length(ds{1,3})
    ds_temp(k1,3) = ds{1,3}{k1,1};
end

for k1 = 1:length(ds{1,4})
    categItem = ds{1,4}{k1,1};
    switch categItem
        case 'diesel'
            ds{1,4}{k1,1} = 1;
        case 'gas'
            ds{1,4}{k1,1} = 2;
        case '-inf'
            ds{1,4}{k1,1} = -inf;            
    end
end
for k1 = 1:length(ds{1,4})
    ds_temp(k1,4) = ds{1,4}{k1,1};
end

for k1 = 1:length(ds{1,5})
    categItem = ds{1,5}{k1,1};
    switch categItem
        case 'std'
            ds{1,5}{k1,1} = 1;
        case 'turbo'
            ds{1,5}{k1,1} = 2;
        case '-inf'
            ds{1,5}{k1,1} = -inf;            
    end
end
for k1 = 1:length(ds{1,5})
    ds_temp(k1,5) = ds{1,5}{k1,1};
end

for k1 = 1:length(ds{1,6})
    categItem = ds{1,6}{k1,1};
    switch categItem
        case 'four'
            ds{1,6}{k1,1} = 1;
        case 'two'
            ds{1,6}{k1,1} = 2;
        case '-inf'
            ds{1,6}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,6})
    ds_temp(k1,6) = ds{1,6}{k1,1};
end

for k1 = 1:length(ds{1,7})
    categItem = ds{1,7}{k1,1};
    switch categItem
        case 'hardtop'
            ds{1,7}{k1,1} = 1;
        case 'wagon'
            ds{1,7}{k1,1} = 2;
        case 'sedan'
            ds{1,7}{k1,1} = 3;
        case 'hatchback'
            ds{1,7}{k1,1} = 4;
        case 'convertible'
            ds{1,7}{k1,1} = 5;
        case '-inf'
            ds{1,7}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,7})
    ds_temp(k1,7) = ds{1,7}{k1,1};
end

for k1 = 1:length(ds{1,8})
    categItem = ds{1,8}{k1,1};
    switch categItem
        case '4wd'
            ds{1,8}{k1,1} = 1;
        case 'fwd'
            ds{1,8}{k1,1} = 2;
        case 'rwd'
            ds{1,8}{k1,1} = 3;
        case '-inf'
            ds{1,8}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,8})
    ds_temp(k1,8) = ds{1,8}{k1,1};
end

for k1 = 1:length(ds{1,9})
    categItem = ds{1,9}{k1,1};
    switch categItem
        case 'front'
            ds{1,9}{k1,1} = 1;
        case 'rear'
            ds{1,9}{k1,1} = 2;
        case '-inf'
            ds{1,9}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,9})
    ds_temp(k1,9) = ds{1,9}{k1,1};
end

for k1 = 1:length(ds{1,10})
    ds_temp(k1,10) = ds{1,10}(k1,1);
end
for k1 = 1:length(ds{1,11})
    ds_temp(k1,11) = ds{1,11}(k1,1);
end
for k1 = 1:length(ds{1,12})
    ds_temp(k1,12) = ds{1,12}(k1,1);
end
for k1 = 1:length(ds{1,13})
    ds_temp(k1,13) = ds{1,13}(k1,1);
end
for k1 = 1:length(ds{1,14})
    ds_temp(k1,14) = ds{1,14}(k1,1);
end

for k1 = 1:length(ds{1,15})
    categItem = ds{1,15}{k1,1};
    switch categItem
        case 'dohc'
            ds{1,15}{k1,1} = 1;
        case 'dohcv'
            ds{1,15}{k1,1} = 2;
        case 'l'
            ds{1,15}{k1,1} = 3;
        case 'ohc'
            ds{1,15}{k1,1} = 4;
        case 'ohcf'
            ds{1,15}{k1,1} = 5;
        case 'ohcv'
            ds{1,15}{k1,1} = 6;
        case 'rotor'
            ds{1,15}{k1,1} = 7;
        case '-inf'
            ds{1,15}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,15})
    ds_temp(k1,15) = ds{1,15}{k1,1};
end

for k1 = 1:length(ds{1,16})
    categItem = ds{1,16}{k1,1};
    switch categItem
        case 'eight'
            ds{1,16}{k1,1} = 1;
        case 'five'
            ds{1,16}{k1,1} = 2;
        case 'four'
            ds{1,16}{k1,1} = 3;
        case 'six'
            ds{1,16}{k1,1} = 4;
        case 'three'
            ds{1,16}{k1,1} = 5;
        case 'twelve'
            ds{1,16}{k1,1} = 6;
        case 'two'
            ds{1,16}{k1,1} = 7;
        case '-inf'
            ds{1,16}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,16})
    ds_temp(k1,16) = ds{1,16}{k1,1};
end

for k1 = 1:length(ds{1,17})
    ds_temp(k1,17) = ds{1,17}(k1,1);
end

for k1 = 1:length(ds{1,18})
    categItem = ds{1,18}{k1,1};
    switch categItem
        case '1bbl'
            ds{1,18}{k1,1} = 1;
        case '2bbl'
            ds{1,18}{k1,1} = 2;
        case '4bbl'
            ds{1,18}{k1,1} = 3;
        case 'idi'
            ds{1,18}{k1,1} = 4;
        case 'mfi'
            ds{1,18}{k1,1} = 5;
        case 'mpfi'
            ds{1,18}{k1,1} = 6;
        case 'spdi'
            ds{1,18}{k1,1} = 7;
        case 'spfi'
            ds{1,18}{k1,1} = 8;
        case '-inf'
            ds{1,18}{k1,1} = -inf;                        
    end
end
for k1 = 1:length(ds{1,18})
    ds_temp(k1,18) = ds{1,18}{k1,1};
end

for k1 = 1:length(ds{1,19})
    ds_temp(k1,19) = ds{1,19}(k1,1);
end
for k1 = 1:length(ds{1,20})
    ds_temp(k1,20) = ds{1,20}(k1,1);
end
for k1 = 1:length(ds{1,21})
    ds_temp(k1,21) = ds{1,21}(k1,1);
end
for k1 = 1:length(ds{1,22})
    ds_temp(k1,22) = ds{1,22}(k1,1);
end
for k1 = 1:length(ds{1,23})
    ds_temp(k1,23) = ds{1,23}(k1,1);
end
for k1 = 1:length(ds{1,24})
    ds_temp(k1,24) = ds{1,24}(k1,1);
end
for k1 = 1:length(ds{1,25})
    ds_temp(k1,25) = ds{1,25}(k1,1);
end
for k1 = 1:length(ds{1,26})
    ds_temp(k1,26) = ds{1,26}(k1,1);
end

ds_temp(ds_temp==-2.147483648000000e+09)=-inf;
ds_temp(isnan(ds_temp)) = -inf;

n = size(ds_temp,1);
seqVec = transpose(1:n);
ds_temp = [seqVec ds_temp];
misValIdx = find(ds_temp(:,3)==-inf | ds_temp(:,7)==-inf | ds_temp(:,20)==-inf | ...
    ds_temp(:,21)==-inf | ds_temp(:,23)==-inf | ds_temp(:,24)==-inf | ds_temp(:,27)==-inf);
misValNOTidx = setdiff(seqVec,misValIdx);
dsTemp_misVal = ds_temp(misValIdx,:);
dsTemp_NOTmisVal = ds_temp(misValNOTidx,:);

[Y2,~] = discretize(dsTemp_NOTmisVal(:,3),10);
[Y6,~] = discretize(dsTemp_NOTmisVal(:,7),10);
[Y19,~] = discretize(dsTemp_NOTmisVal(:,20),10);
[Y20,~] = discretize(dsTemp_NOTmisVal(:,21),10);
[Y22,~] = discretize(dsTemp_NOTmisVal(:,23),10);
[Y23,~] = discretize(dsTemp_NOTmisVal(:,24),10);
[Y26,~] = discretize(dsTemp_NOTmisVal(:,27),10);
dsTemp_NOTmisVal(:,3) = Y2;
dsTemp_NOTmisVal(:,7) = Y6;
dsTemp_NOTmisVal(:,20) = Y19;
dsTemp_NOTmisVal(:,21) = Y20;
dsTemp_NOTmisVal(:,23) = Y22;
dsTemp_NOTmisVal(:,24) = Y23;
dsTemp_NOTmisVal(:,27) = Y26;
mode2 = mode(Y2);
mode6 = mode(Y6);
mode19 = mode(Y19);
mode20 = mode(Y20);
mode22 = mode(Y22);
mode23 = mode(Y23);
mode26 = mode(Y26);
dsTemp_misVal(:,3) = mode2;
dsTemp_misVal(:,7) = mode6;
dsTemp_misVal(:,20) = mode19;
dsTemp_misVal(:,21) = mode20;
dsTemp_misVal(:,23) = mode22;
dsTemp_misVal(:,24) = mode23;
dsTemp_misVal(:,27) = mode26;

ds_final = [dsTemp_NOTmisVal; dsTemp_misVal];
ds_final = sortrows(ds_final,1);
ds = ds_final(:,2:end);
ds = [ds(:,[1:3 5:end]) ds(:,4)];

featUnqFreq = featFreqFunc(ds(:,1:end-1));
autos = cell(1,2);
autos{1,1} = ds; autos{1,2} = featUnqFreq;

save('autos.mat','autos');
