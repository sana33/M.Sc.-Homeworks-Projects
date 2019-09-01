clear; close all; clc; warning off

%% Considering Synthetic dataset of 'synthDataset_GO.mat' containing some GLOBAL OUTLIERS
synthDS = load('synthDataset_GO.mat'); synthDS = synthDS.GOsynthDS;

clustVec = 4:10;
goProbTotSeuq = zeros(size(synthDS,1),length(clustVec));
goProbTotCosi = zeros(size(synthDS,1),length(clustVec));
for clustNo = 1:length(clustVec)
    [~, goProbTotSeuq(:,clustNo)] = GlobalOutlierFactProb(synthDS(:,1:end-2), clustVec(clustNo), 'sqeuclidean');
    [~, goProbTotCosi(:,clustNo)] = GlobalOutlierFactProb(synthDS(:,1:end-2), clustVec(clustNo), 'cosine');
end

goProbSeuqFinal = GO_CombBreadthFirst(goProbTotSeuq);
goProbCosiFinal = GO_CombBreadthFirst(goProbTotCosi);
% goProbSeuqFinal = mean(goProbTotSeuq,2);
% goProbCosiFinal = mean(goProbTotCosi,2);

[Xsq,Ysq,Tsq,AUCsq,OPTROCPTsq] = perfcurve(synthDS(:,end),goProbSeuqFinal,1);
[Xco,Yco,Tco,AUCco,OPTROCPTco] = perfcurve(synthDS(:,end),goProbCosiFinal,1);

figure;
plot(Xsq,Ysq,'b','LineWidth',1.2); grid on; hold on;
title('Global Outlier Detection Based on SquaredEuclidean Distance');
xlabel('False Positive Rate'); ylabel('True Positive Rate');
plot(OPTROCPTsq(1),OPTROCPTsq(2),'ro');

figure;
plot(Xco,Yco,'b','LineWidth',1.2); grid on; hold on;
title('Global Outlier Detection Based on Cosine Distance');
xlabel('False Positive Rate'); ylabel('True Positive Rate');
plot(OPTROCPTco(1),OPTROCPTco(2),'ro');

