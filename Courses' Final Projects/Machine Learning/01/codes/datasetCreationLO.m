clear; close all; clc; warning off

%% Create two independent sets of 30 synthetic datasets
LOsynthDS = cell(2,30);
for phase = 1:2
    for batch = 1:30
        dataSet = [];
        dim = randi([20,40]);
        clustNo = randi([2,10]);
        for c1 = 1:clustNo
            mu = rand(1,dim);
            mu = normalizeDataSet(mu,10,-10,0);
            A = rand(dim);
            covMat = A'*A;
            clustMemb = randi([600,1000]);
            clust = mvnrnd(mu,covMat,clustMemb);
            clust = [clust zeros(size(clust,1),2)];
            clust(:,dim+1) = c1;
            mahalDist = mahal(clust(:,1:end-2),clust(:,1:end-2));
            olBound = quantile(mahalDist,.975);
            clust(mahalDist>olBound,dim+2) = 1;
            dataSet = [dataSet; clust];
        end
        LOsynthDS(phase,batch) = {dataSet};
    end
end
save('synthDataset_LO','LOsynthDS');

%% Modifying real datasets for outlier task
% Considering Satimage dataset
SatimageTrain = load('datasets\satimage\sat.trn');
SatimageTest = load('datasets\satimage\sat.tst');
Satimage = [SatimageTrain; SatimageTest];
clear SatimageTrain SatimageTest
class2Ind = find(Satimage(:,end)==2);
Satimage = [Satimage zeros(size(Satimage,1),1)];
class2Clust = Satimage(class2Ind,:);
mahalDist = mahal(class2Clust(:,1:end-2),class2Clust(:,1:end-2));
olBound = quantile(mahalDist,.9);
class2Clust(mahalDist>olBound,end) = 1;
Satimage(class2Ind,end) = class2Clust(:,end);
save('Satimage','Satimage');

% Considering Segment dataset
Segment = load('datasets\segment\segment.dat');
Segment1 = Segment; Segment2 = Segment; Segment3 = Segment;
classGrassInd = find(Segment(:,end)==7);
classPathInd = find(Segment(:,end)==6);
classSkyInd = find(Segment(:,end)==2);
Segment1 = [Segment1 zeros(size(Segment1,1),1)];
Segment2 = [Segment2 zeros(size(Segment2,1),1)];
Segment3 = [Segment3 zeros(size(Segment3,1),1)];
classGrassClust = Segment1(classGrassInd,:);
classPathClust = Segment2(classPathInd,:);
classSkyClust = Segment3(classSkyInd,:);
mahalDist1 = mahal(classGrassClust(:,1:end-2),classGrassClust(:,1:end-2));
mahalDist2 = mahal(classPathClust(:,1:end-2),classPathClust(:,1:end-2));
mahalDist3 = mahal(classSkyClust(:,1:end-2),classSkyClust(:,1:end-2));
olBound1 = quantile(mahalDist1,.9);
olBound2 = quantile(mahalDist2,.9);
olBound3 = quantile(mahalDist3,.9);
classGrassClust(mahalDist1>olBound1,end) = 1;
classPathClust(mahalDist2>olBound2,end) = 1;
classSkyClust(mahalDist3>olBound3,end) = 1;
Segment1(classGrassInd,end) = classGrassClust(:,end);
Segment2(classPathInd,end) = classPathClust(:,end);
Segment3(classSkyInd,end) = classSkyClust(:,end);
save('Segment1','Segment1');
save('Segment2','Segment2');
save('Segment3','Segment3');

% Considering WBC dataset
WBC = load('datasets\WBC\breast-cancer-wisconsin.data');
maligInd = find(WBC(:,end)==4);
WBC = [WBC zeros(size(WBC,1),1)];
maligClust = WBC(maligInd,:);
mahalDist = mahal(maligClust(:,1:end-2),maligClust(:,1:end-2));
olBound = quantile(mahalDist,.9);
maligClust(mahalDist>olBound,end) = 1;
WBC(maligInd,end) = maligClust(:,end);
save('WBC','WBC');

% Considering Waveform dataset
Waveform = load('datasets\waveform\waveform.data');
class0Ind = find(Waveform(:,end)==0);
Waveform = [Waveform zeros(size(Waveform,1),1)];
class0Clust = Waveform(class0Ind,:);
mahalDist = mahal(class0Clust(:,1:end-2),class0Clust(:,1:end-2));
olBound = quantile(mahalDist,.9);
class0Clust(mahalDist>olBound,end) = 1;
Waveform(class0Ind,end) = class0Clust(:,end);
save('Waveform','Waveform');
