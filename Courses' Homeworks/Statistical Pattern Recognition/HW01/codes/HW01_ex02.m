clear, clc, close all, warning off

samplesNo = 100;
mu = 1;
sigma = [.5^2 1^2 2^2];

X1 = mvnrnd(mu,sigma(1),samplesNo);
X2 = mvnrnd(mu,sigma(2),samplesNo);
X3 = mvnrnd(mu,sigma(3),samplesNo);

figure;
subplot(3,1,1); histogram(X1); title('mu=1, sigma=.5');
subplot(3,1,2); histogram(X2); title('mu=1, sigma=1');
subplot(3,1,3); histogram(X3); title('mu=1, sigma=2');
