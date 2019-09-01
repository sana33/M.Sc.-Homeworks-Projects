clear; close all; clc; warning off

%% Considering WBC (Wisconsin Breast Cancer) dataset, according to Figure 6 of the
% paper
WBC = load('WBC.mat'); WBC = WBC.WBC;
dsSize = size(WBC,1);
olLabels = WBC(:,end);

rocAucTotLOF = zeros(25,11);
rocAucTotLoOP = zeros(25,11);
rocAucEnsLOF = zeros(1,11);
rocAucEnsLoOP = zeros(1,11);
olScoresLOF = zeros(dsSize,25,10);
olScoresLoOP = zeros(dsSize,25,10);

% Making boxplots contents on WBC dataset, according to Figure 6 of the
% paper
for c1 = 1:10
    for c2 = 1:25
        while true
            subSampleInd = randperm(dsSize,floor(.1*c1*dsSize));
            if sum(WBC(subSampleInd,end)) > 1
                break;
            end
        end
        SUBolLabels = WBC(subSampleInd,end);
        [SUBlofValues, ~, ~] = LocalOutlierFactor(WBC(subSampleInd,1:end-2), 2, 2, 1);
        [SUBLoOPvalues, ~] = LocalOutlierProb(WBC(subSampleInd,1:end-2), 2);
        olScoresLOF(subSampleInd,c2,c1) = SUBlofValues;
        olScoresLoOP(subSampleInd,c2,c1) = SUBLoOPvalues;
        [~,~,~,rocAucTotLOF(c2,c1)] = perfcurve(SUBolLabels, SUBlofValues, 1);
        [~,~,~,rocAucTotLoOP(c2,c1)] = perfcurve(SUBolLabels, SUBLoOPvalues, 1);
    end
end

% Considering Feature Bagging Algorithm on WBC dataset, according to Figure
% 6 of the paper
[~, ~, ~, aucTotLOF] = FeatureBagging(WBC(:,1:end-2), olLabels, 'LOF', 25, 'CumulativeSum', 2, 2, 1, 2);
[~, ~, ~, aucTotLoOP] = FeatureBagging(WBC(:,1:end-2), olLabels, 'LoOP', 25, 'CumulativeSum', 2, 2, 1, 2);

% Considering ROC-AUC for total ensembles on WBC dataset, according to
% Figure 6 of the paper
olScoresLOFEns = squeeze(sum(olScoresLOF,2) ./ sum(olScoresLOF>0,2));
olScoresLoOPEns = squeeze(sum(olScoresLoOP,2) ./ sum(olScoresLoOP>0,2));
olScoresLOFEns(isnan(olScoresLOFEns) | isinf(olScoresLOFEns)) = 0;
olScoresLoOPEns(isnan(olScoresLoOPEns) | isinf(olScoresLoOPEns)) = 0;
for c1 = 1:10
   [~, ~, ~, rocAucEnsLOF(c1)] = perfcurve(olLabels, olScoresLOFEns(:,c1), 1);
   [~, ~, ~, rocAucEnsLoOP(c1)] = perfcurve(olLabels, olScoresLoOPEns(:,c1), 1);
end
rocAucEnsLOF(end) = aucTotLOF;
rocAucEnsLoOP(end) = aucTotLoOP;

% Plotting boxplots for the base methods, according to Figure 6 of the
% paper
figure;
boxplot(rocAucTotLOF,'labels',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','FB'}); hold on;
title('WBC dataset; BaseMethod: LOF; k = 2');
xlabel('Sample fraction','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
ylim([0 1]);
plot(1:11,rocAucEnsLOF,'d','MarkerFaceColor','k');

figure;
boxplot(rocAucTotLoOP,'labels',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','FB'}); hold on;
title('WBC dataset; BaseMethod: LoOP; k = 2');
xlabel('Sample fraction','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
ylim([0 1]);
plot(1:11,rocAucEnsLoOP,'d','MarkerFaceColor','k');
