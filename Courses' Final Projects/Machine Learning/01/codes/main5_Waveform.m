clear; close all; clc; warning off

%% Considering Waveform dataset, according to Figure 8 of the
% paper
Waveform = load('Waveform.mat'); Waveform = Waveform.Waveform;
dsSize = size(Waveform,1);
olLabels = Waveform(:,end);

rocAucTotLOF = zeros(3,50);
rocAucTotLoOP = zeros(3,50);
olScoresLOF = zeros(dsSize,25,50);
olScoresLoOP = zeros(dsSize,25,50);

% Taking subsamples of dataset
subSampleEns = zeros(25,floor(.1*dsSize));
for c1 = 1:25
    while true
        subSampleEns(c1,:) = randperm(dsSize,floor(.1*dsSize));
        if sum(Waveform(subSampleEns(c1,:),end)) > 1
            break;
        end
    end
end
subSamInd_FB_BM = subSampleEns(1,:);

% subSampleEns = load('subSampleEns.mat'); subSampleEns = subSampleEns.subSampleEns;
% subSamInd_FB_BM = subSampleEns(1,:);

for k = 1:50
    % Considering total ensembles for sampleSize=10% and K=k
    for c3 = 1:25
        [SUBlofValues, ~, ~] = LocalOutlierFactor(Waveform(subSampleEns(c3,:),1:end-2), k, k, 1);
        [SUBLoOPvalues, ~] = LocalOutlierProb(Waveform(subSampleEns(c3,:),1:end-2), k);
        olScoresLOF(subSampleEns(c3,:),c3,k) = SUBlofValues;
        olScoresLoOP(subSampleEns(c3,:),c3,k) = SUBLoOPvalues;
    end
    olScoresLOFEns = sum(olScoresLOF(:,:,k),2) ./ sum(olScoresLOF(:,:,k)>0,2);
    olScoresLoOPEns = sum(olScoresLoOP(:,:,k),2) ./ sum(olScoresLoOP(:,:,k)>0,2);
    olScoresLOFEns(isnan(olScoresLOFEns) | isinf(olScoresLOFEns)) = 0;
    olScoresLoOPEns(isnan(olScoresLoOPEns) | isinf(olScoresLoOPEns)) = 0;
    [~, ~, ~, rocAucTotLOF(1,k)] = perfcurve(olLabels, olScoresLOFEns, 1);
    [~, ~, ~, rocAucTotLoOP(1,k)] = perfcurve(olLabels, olScoresLoOPEns, 1);

    % Considering Base Methods for sampleSize=10% and K=k
    [base_lofValues, ~, ~] = LocalOutlierFactor(Waveform(subSamInd_FB_BM,1:end-2), ...
        k, k, 1);
    [base_LoOPvalues, ~] = LocalOutlierProb(Waveform(subSamInd_FB_BM,1:end-2), k);
    [~, ~, ~, rocAucTotLOF(2,k)] = perfcurve(olLabels(subSamInd_FB_BM), base_lofValues, 1);
    [~, ~, ~, rocAucTotLoOP(2,k)] = perfcurve(olLabels(subSamInd_FB_BM), base_LoOPvalues, 1);
    
    % Considering Feature Bagging Ensemble for sampleSize=10% and K=k
    [~, ~, ~, rocAucTotLOF(3,k)] = FeatureBagging(Waveform(subSamInd_FB_BM,1:end-2), ...
        olLabels(subSamInd_FB_BM), 'LOF', 25, 'CumulativeSum', k, k, 1, 2);
    [~, ~, ~, rocAucTotLoOP(3,k)] = FeatureBagging(Waveform(subSamInd_FB_BM,1:end-2), ...
        olLabels(subSamInd_FB_BM), 'LoOP', 25, 'CumulativeSum', k, k, 1, 2);
end

% Plotting figures for the base methods, according to Figure 8 of the paper
figure;
plot(1:50,rocAucTotLOF(1,:),'dr',1:50,rocAucTotLOF(2,:),'xb',1:50,rocAucTotLOF(3,:),'^k','MarkerSize',10);
title('Waveform dataset; BaseMethod: LOF; sampleSize = 10%');
legend('Subsampling Ensemble','LOF','Feature Bagging Ensemble');
xlabel('K Values','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
xlim([0 50]); ylim([.4 1]);

figure;
plot(1:50,rocAucTotLoOP(1,:),'dr',1:50,rocAucTotLoOP(2,:),'xb',1:50,rocAucTotLoOP(3,:),'^k','MarkerSize',10);
title('Waveform dataset; BaseMethod: LoOP; sampleSize = 10%');
legend('Subsampling Ensemble','LoOP','Feature Bagging Ensemble');
xlabel('K Values','FontWeight','bold');
ylabel('ROC AUC','FontSize',12,'FontWeight','bold');
xlim([0 50]); ylim([.4 1]);
