clear, clc, close all, warning off

samplesNo = 100;
mu1 = [1 0]; sigma1 = [5 0; 0 5];
mu2 = [2 0]; sigma2 = [5 0; 0 10];
mu3 = [-1 1]; sigma3 = [5 6; 6 10];

X1 = mvnrnd(mu1,sigma1,samplesNo);
X2 = mvnrnd(mu2,sigma2,samplesNo);
X3 = mvnrnd(mu3,sigma3,samplesNo);

sMean1 = [mean(X1(:,1)) mean(X1(:,2))];
sMean2 = [mean(X2(:,1)) mean(X2(:,2))];
sMean3 = [mean(X3(:,1)) mean(X3(:,2))];

sSigma1 = cov(X1);
sSigma2 = cov(X2);
sSigma3 = cov(X3);
