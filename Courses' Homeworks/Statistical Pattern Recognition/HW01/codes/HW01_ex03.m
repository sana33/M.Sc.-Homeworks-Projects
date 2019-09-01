clear, clc, close all, warning off

samplesNo = 100;
mu1 = [1 0]; sigma1 = [5 0; 0 5];
mu2 = [2 0]; sigma2 = [5 0; 0 10];
mu3 = [-1 1]; sigma3 = [5 6; 6 10];

X1 = mvnrnd(mu1,sigma1,samplesNo);
X2 = mvnrnd(mu2,sigma2,samplesNo);
X3 = mvnrnd(mu3,sigma3,samplesNo);

figure; scatter(X1(:,1),X1(:,2)); title('mu=[1 0], sigma=[5 0; 0 5]');
figure; scatter(X2(:,1),X2(:,2)); title('mu=[2 0], sigma=[5 0; 0 10]');
figure; scatter(X3(:,1),X3(:,2)); title('mu=[-1 1], sigma=[5 6; 6 10]');
