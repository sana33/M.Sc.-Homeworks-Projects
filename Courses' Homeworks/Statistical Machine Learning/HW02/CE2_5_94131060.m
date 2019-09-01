clc, clear all, close all;

samplesNo = 20;
lambdaZ = 1;
alpha = .05;
repetitionNo = 1e5;
poissSamples = poissrnd(lambdaZ, [repetitionNo, samplesNo]);
lambdaHat = mean(poissSamples, 2);
seHat = sqrt(lambdaHat ./ samplesNo);
% Computing the Wald test results for generated poisson samples
waldTestResults = abs((lambdaHat - lambdaZ) ./ seHat);
% Computing phiInv(1 - alpha/2) where alpha=.05; so 1-alpha/2=.975
z_alphaOver2 = norminv(1 - alpha ./ 2, 0, 1);
% Computing the number of type I errors at which the null hypothesis is
% true but we reject it
typeIerrorNo = sum(waldTestResults > z_alphaOver2);

fprintf('The final results are as follows:\n');
fprintf('The type I Rrorr Rate: %.4f\n', typeIerrorNo ./ repetitionNo);
