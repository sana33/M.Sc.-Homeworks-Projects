clear; close all; clc; warning off

%% Considering Satimage dataset, according to Figure 7 of the
% paper
Satimage = load('Satimage.mat'); Satimage = Satimage.Satimage;
dsSize = size(Satimage,1);
olLabels = Satimage(:,end);

rocAucTotLOF = zeros(25,11);
rocAucTotLoOP = zeros(25,11);
rocAucEnsLOF = zeros(1,11);
rocAucEnsLoOP = zeros(1,11);
olScoresLOF = zeros(dsSize,25,10);
olScoresLoOP = zeros(dsSize,25,10);

% Making boxplots contents on Satimage dataset, according to Figure 7 of
% the paper
for c1 = 1:10
    for c2 = 1:25
        while true
            subSampleInd = randperm(dsSize,floor(.1*c1*dsSize));
            if sum(Satimage(subSampleInd,end)) > 1
                break;
            end
        end
        SUBolLabels = Satimage(subSampleInd,end);
        [SUBlofValues, ~, ~] = LocalOutlierFactor(Satimage(subSampleInd,1:end-2), 50, 50, 1);
        [SUBLoOPvalues, ~] = LocalOutlierProb(Satimage(subSampleInd,1:end-2), 50);
        olScoresLOF(subSampleInd,c2,c1) = SUBlofValues;
        olScoresLoOP(subSampleInd,c2,c1) = SUBLoOPvalues;
        [~,~,~,rocAucTotLOF(c2,c1)] = perfcurve(SUBolLabels, SUBlofValues, 1);
        [~,~,~,rocAucTotLoOP(c2,c1)] = perfcurve(SUBolLabels, SUBLoOPvalues, 1);
    end
end

% Considering Feature Bagging Algorithm on Satimage dataset, according to
% Figure 7 of the paper
[~, ~, ~, aucTotLOF] = FeatureBagging(Satimage(:,1:end-2), olLabels, 'LOF', 25, 'CumulativeSum', 50, 50, 1, 2);
[~, ~, ~, aucTotLoOP] = FeatureBagging(Satimage(:,1:end-2), olLabels, 'LoOP', 25, 'CumulativeSum', 50, 50, 1, 2);

% Considering ROC-AUC for total ensembles on Satimage dataset, according to
% Figure 7 of the paper
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

% Plotting boxplots for the base methods, according to Figure 7 of the
% paper
figure;
boxplot(rocAucTotLOF,'labels',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','FB'}); hold on;
title('Satimage dataset; BaseMethod: LOF; k = 50');
xlabel('Sample fraction','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
ylim([0 1]);
plot(1:11,rocAucEnsLOF,'d','MarkerFaceColor','k');

figure;
boxplot(rocAucTotLoOP,'labels',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0','FB'}); hold on;
title('Satimage dataset; BaseMethod: LoOP; k = 50');
xlabel('Sample fraction','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
ylim([0 1]);
plot(1:11,rocAucEnsLoOP,'d','MarkerFaceColor','k');
