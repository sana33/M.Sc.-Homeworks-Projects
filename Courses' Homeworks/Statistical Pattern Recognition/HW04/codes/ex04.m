clear, close all; clc, warning off

heartDS = load('heart.dat'); DSlength = size(heartDS,1);
trPrc = 80; tsPrc = 20;
trainSet = heartDS(1:floor(trPrc*DSlength/100),1:end-1);
trainLabel = heartDS(1:floor(trPrc*DSlength/100),end);
testSet = heartDS(floor(trPrc*DSlength/100)+1:end,1:end-1);
testLabel = heartDS(floor(trPrc*DSlength/100)+1:end,end);
label2Pred = unique(heartDS(:,end));

%% Part a
kVals = 1:10;
predMat = zeros(size(trainSet,1),length(kVals));
distMatTr = pdist2(trainSet,trainSet);
[~, sDistIndTR] = sort(distMatTr,2);
for c1 = 1:length(kVals)
    KNN_label = trainLabel(sDistIndTR(:,2:kVals(c1)+1));
    labelCount = zeros(size(KNN_label,1),length(label2Pred));
    for c2 = 1:length(label2Pred)
        labelCount(:,c2) = sum(KNN_label==label2Pred(c2),2);
    end
    [~,maxLblInd] = max(labelCount,[],2);
    predMat(:,c1) = label2Pred(maxLblInd);
end

cvLOOerrAvg = sum(predMat~=repmat(trainLabel,1,length(kVals)))./length(trainLabel);
[~,bestKind] = sort(cvLOOerrAvg);
bestK = kVals(bestKind(1));
fprintf('The best value for K is:\t%d\n',bestK);

%% Part b
% This part has the same procedure as part a

%% Part c
distMatTs = pdist2(testSet,trainSet);
[~, sDistIndTs] = sort(distMatTs,2);
KNN_label = trainLabel(sDistIndTs(:,1:bestK));
labelCount = zeros(size(KNN_label,1),length(label2Pred));
for c2 = 1:length(label2Pred)
    labelCount(:,c2) = sum(KNN_label==label2Pred(c2),2);
end
[~,maxLblInd] = max(labelCount,[],2);
predVec = label2Pred(maxLblInd);
errTest = sum(predVec~=testLabel)/length(testLabel);
fprintf('The error rate for test dataset with the best value of K = %d, gained by Leave-One-Out CV is:\t%0.2f %%\n',bestK,errTest*100);
[X,Y,~,AUCts] = perfcurve(testLabel,predVec,2);
figure; plot(X,Y,'b','LineWidth',1.3); grid on;
xlabel('False Positive Rate'); ylabel('True Positive Rate');
title(['ROC for Test dataset Prediction with AUC = ',num2str(AUCts)]);

