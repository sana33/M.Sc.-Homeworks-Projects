clear; close all; clc; warning off

%% Considering Segment datasets, according to Figure 9 of the
% paper
for d1 = 1:3
    SegmentI = load(sprintf('Segment%d.mat',d1));
    if d1==1; SegmentI = SegmentI.Segment1; end
    if d1==2; SegmentI = SegmentI.Segment2; end
    if d1==3; SegmentI = SegmentI.Segment3; end
    dsSize = size(SegmentI,1);
    olLabels = SegmentI(:,end);

    rocAucTot = zeros(2,3,3);
    olScoresLOF = zeros(dsSize,25,2);
    olScoresLoOP = zeros(dsSize,25,2);
    
    % Taking subsamples of dataset
    subSampleEns = zeros(25,floor(.1*dsSize));    
    for c1 = 1:25
        while true
            subSampleEns(c1,:) = randperm(dsSize,floor(.1*dsSize));
            if sum(SegmentI(subSampleEns(c1,:),end)) > 1
                break;
            end
        end
    end
    
    % Considering base methods for the whole dataset
    [base_lofValues, ~, ~] = LocalOutlierFactor(SegmentI(:,1:end-2), 20, 20, 1);
    [base_LoOPvalues, ~] = LocalOutlierProb(SegmentI(:,1:end-2), 20);
    [~, ~, ~, rocAucTot(1,1,d1)] = perfcurve(olLabels, base_lofValues, 1);
    [~, ~, ~, rocAucTot(2,1,d1)] = perfcurve(olLabels, base_LoOPvalues, 1);
    
    % Considering subsampling method for the whole dataset
    for c2 = 1:25
        [SUBlofValues, ~, ~] = LocalOutlierFactor(SegmentI(subSampleEns(c2,:),1:end-2), 20, 20, 1);
        [SUBLoOPvalues, ~] = LocalOutlierProb(SegmentI(subSampleEns(c2,:),1:end-2), 20);
        olScoresLOF(subSampleEns(c2,:),c2,1) = SUBlofValues;
        olScoresLoOP(subSampleEns(c2,:),c2,2) = SUBLoOPvalues;
    end
    olScoresLOFEns = sum(olScoresLOF(:,:,1),2) ./ sum(olScoresLOF(:,:,1)>0,2);
    olScoresLoOPEns = sum(olScoresLoOP(:,:,2),2) ./ sum(olScoresLoOP(:,:,2)>0,2);
    olScoresLOFEns(isnan(olScoresLOFEns) | isinf(olScoresLOFEns)) = 0;
    olScoresLoOPEns(isnan(olScoresLoOPEns) | isinf(olScoresLoOPEns)) = 0;
    [~, ~, ~, rocAucTot(1,2,d1)] = perfcurve(olLabels, olScoresLOFEns, 1);
    [~, ~, ~, rocAucTot(2,2,d1)] = perfcurve(olLabels, olScoresLoOPEns, 1);
    
    % Considering Feature Bagging Ensemble for the whole dataset and K=20
    [~, ~, ~, rocAucTot(1,3,d1)] = FeatureBagging(SegmentI(:,1:end-2), ...
        olLabels, 'LOF', 25, 'CumulativeSum', 20, 20, 1, 2);
    [~, ~, ~, rocAucTot(2,3,d1)] = FeatureBagging(SegmentI(:,1:end-2), ...
        olLabels, 'LoOP', 25, 'CumulativeSum', 20, 20, 1, 2);
end

% Plotting figures, according to Figure 9 of the paper
figure;
subplot(1,3,1);
b1 = bar(rocAucTot(:,:,3)); b1(1).FaceColor = 'red'; b1(2).FaceColor = 'green'; b1(3).FaceColor = 'blue';
ylabel('ROC AUC','FontSize',17,'FontWeight','bold');
title('segment-SKY','FontSize',17,'FontWeight','bold'); legend('Base','Subsampling','FB'); ylim([0 1]);

subplot(1,3,2);
b2 = bar(rocAucTot(:,:,2)); b2(1).FaceColor = 'red'; b2(2).FaceColor = 'green'; b2(3).FaceColor = 'blue';
title('segment-PATH','FontSize',17,'FontWeight','bold'); legend('Base','Subsampling','FB'); ylim([0 1]);

subplot(1,3,3);
b3 = bar(rocAucTot(:,:,1)); b3(1).FaceColor = 'red'; b3(2).FaceColor = 'green'; b3(3).FaceColor = 'blue';
title('segment-GRASS','FontSize',17,'FontWeight','bold'); legend('Base','Subsampling','FB'); ylim([0 1]);
