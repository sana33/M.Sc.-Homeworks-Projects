clear, close all; clc, warning off

% % considering 1-D normal distribution
% rng default  % For reproducibility
% mu1 = 12; sigma1 = 3; samplesNo1 = 1e2;
% dist1 = mu1+sigma1.*randn(samplesNo1,1);
% 
% % considering 2-D normal distribution
% mu2 = [2,3]; sigma2 = [1,1.5;1.5,3]; samplesNo2 = 1e4;
% dist2 = mvnrnd(mu2,sigma2,samplesNo2);

% considering 1-D & 2-D normal distribution
lambda1 = 2; exprv1 = load('exprv1'); expDim1 = exprv1.exprv1; exprv2 = load('exprv2'); expDim2 = exprv2.exprv2;
dist1 = expDim1; dist2 = [expDim1 expDim2];

% considering histogram estimation
[distEst1_Hist_c12] = histEst(dist1, 12);
[distEst2_Hist_c12] = histEst(dist2, 12);

[distEst1_Hist_c24] = histEst(dist1, 24);
[distEst2_Hist_c24] = histEst(dist2, 24);

% considering parzen window estimation
[distEst1_ParzW_rec_h01] = parzenWindEst(dist1, .1, .01, 'rectangular');
[distEst1_ParzW_gaus_h01] = parzenWindEst(dist1, .1, .01, 'gaussian');
[distEst1_ParzW_rec_h07] = parzenWindEst(dist1, .7, .01, 'rectangular');
[distEst1_ParzW_gaus_h07] = parzenWindEst(dist1, .7, .01, 'gaussian');
[distEst2_ParzW_rec_h1] = parzenWindEst(dist2, 1, .5, 'rectangular');
[distEst2_ParzW_gaus_h1] = parzenWindEst(dist2, 1, .2, 'gaussian');
[distEst2_ParzW_rec_h15] = parzenWindEst(dist2, 1.5, .5, 'rectangular');
[distEst2_ParzW_gaus_h15] = parzenWindEst(dist2, 1.5, .2, 'gaussian');

% considering K-NN estimation
[distEst1_3NN] = KNN_Est(dist1, 3, 1e-1);
[distEst2_3NN] = KNN_Est(dist2, 3, 1e-1);

[distEst1_6NN] = KNN_Est(dist1, 6, 1e-1);
[distEst2_6NN] = KNN_Est(dist2, 6, 1e-1);
