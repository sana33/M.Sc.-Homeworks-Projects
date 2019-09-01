clear; close all; clc; warning off

%% Considering batch1 of Synthetic dataset, according to Figure 4 of the
% paper
LOsynthDS = load('synthDataset_LO.mat'); LOsynthDS = LOsynthDS.synthDS;
batch1 = LOsynthDS(1,:);
rocAucTotLOF = zeros(25,11);
rocAucTotLoOP = zeros(25,11);
rocAucTotFB = zeros(25,length(batch1),2);

% Making boxplots contents on batch1 of Synthetic dataset, according to
% Figure 4 of the paper
for c1 = 1:10
    for c2 = 1:25
        olLabels = [];
        olScoresLOF = [];
        olScoresLoOP = [];
        for c3 = 1:length(batch1)
            ds = batch1{c3}(:,1:end-2);
            dsSize = size(batch1{c3},1);
            while true
                subSampleInd = randperm(dsSize,floor(.1*c1*dsSize));
                if sum(ds(subSampleInd,end))>1
                    break;
                end
            end
            olLabels = [olLabels; batch1{c3}(subSampleInd,end)];
            [SUBlofValues, ~, ~] = LocalOutlierFactor(ds(subSampleInd,:), 3, 3, 1);
            [SUBLoOPvalues, ~] = LocalOutlierProb(ds(subSampleInd,:), 3);
            olScoresLOF = [olScoresLOF; SUBlofValues];
            olScoresLoOP = [olScoresLoOP; SUBLoOPvalues];
        end
        [~,~,~,rocAucTotLOF(c2,c1)] = perfcurve(olLabels, olScoresLOF, 1);
        [~,~,~,rocAucTotLoOP(c2,c1)] = perfcurve(olLabels, olScoresLoOP, 1);
    end
end

% Considering Feature Bagging Algorithm on batch1 of Synthetic dataset,
% according to Figure 4 of the paper
for c1 = 1:length(batch1)
    [~, ~, rocAucTotFB(:,c1,1), ~] = FeatureBagging(batch1{c1}(:,1:end-2), batch1{c1}(:,end), ...
        'LOF', 25, 'CumulativeSum', 3, 3, 1, 2);
    [~, ~, rocAucTotFB(:,c1,2), ~] = FeatureBagging(batch1{c1}(:,1:end-2), batch1{c1}(:,end), ...
        'LoOP', 25, 'CumulativeSum', 3, 3, 1, 2);
end
rocAucTotFB = mean(rocAucTotFB,2);
rocAucTotFB = squeeze(rocAucTotFB);
rocAucTotLOF(:,end) = rocAucTotFB(:,1);
rocAucTotLoOP(:,end) = rocAucTotFB(:,2);

% Plotting boxplots for the base methods, according to Figure 4 of the
% paper
figure;
boxplot(rocAucTotLOF,'labels',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','FB'}); hold on;
title('30 synthetic datasets of batch1; BaseMethod: LOF; k = 3');
xlabel('Sample fraction','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
ylim([0 1]);

figure;
boxplot(rocAucTotLoOP,'labels',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','FB'}); hold on;
title('30 synthetic datasets of batch1; BaseMethod: LoOP; k = 3');
xlabel('Sample fraction','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
ylim([0 1]);
