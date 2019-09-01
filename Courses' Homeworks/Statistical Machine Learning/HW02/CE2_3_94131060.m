clc, clear all, close all;

mu = 5;
bootRepliNo = 100000;
normRndNumbers = normrnd(mu, 1, [100, 1]);

%% Part A
meanEst = mean(normRndNumbers);
thetaEst = exp(meanEst);

bootResults = bootstrp(bootRepliNo, @mean, normRndNumbers);
thetaBootEst = exp(bootResults);
thetaBootEstMean = mean(thetaBootEst);
thetaBootVar = sum((thetaBootEst - thetaBootEstMean) .^ 2) ./ bootRepliNo;
thetaBootSE = sqrt(thetaBootVar);

percentileA = prctile(thetaBootEst, 2.5);
percentileB = prctile(thetaBootEst, 97.5);

normalConfIntervalLow = thetaEst - 1.96 * thetaBootSE;
normalConfIntervalHigh = thetaEst + 1.96 * thetaBootSE;

pivotalConfIntervalLow = 2 * thetaEst - percentileB;
pivotalConfIntervalHigh = 2 * thetaEst - percentileA;

fprintf('The final results are:\n\t');
fprintf('Mean estimate: %.4f \t ThetaEstimate: %.4f \t Bootstrap Standard Error: %.4f\n',meanEst, thetaEst, thetaBootSE);
fprintf('BootStrap confidence intervals:\n\t');
fprintf('Normal Confidence Interval:\t\t(%.4f , %.4f)\n\tPivotal Confidence Interval:\t(%.4f , %.4f)\n\tPercentile Confidence Interval:\t(%.4f , %.4f)\n', ...
    normalConfIntervalLow, normalConfIntervalHigh, pivotalConfIntervalLow, pivotalConfIntervalHigh, percentileA, percentileB);
 

%% Part B
trueSamples = exp(mean(normrnd(mu, 1, [bootRepliNo, 100]), 2));
figure(1);
% Plot true samples
hist(trueSamples);
h = findobj(gca, 'Type', 'patch');
set(h,'FaceColor','r','EdgeColor','w','facealpha',0.5);
hold on
% Plot bootstrap results
hist(thetaBootEst);
h = findobj(gca, 'Type', 'patch');
set(h, 'FaceAlpha', .5);
xlabel('Distribution Bins');
ylabel('Distribution Counts');
legend('True Samples', 'Bootstrap Replications');
% Comparison between true results and bootstrap replications:
trueSamplesMean = mean(trueSamples);
trueSamplesVar = var(trueSamples);
bootResultsMean = mean(thetaBootEst);
bootResultsVar = var(thetaBootEst);
fprintf('The mean value of true samples is: %.4f\n\tThe variance of true samples is: %.4f\n', trueSamplesMean, trueSamplesVar);
fprintf('The mean value of bootstrap replications is: %.4f\n\tThe variance of bootstrap replications is: %.4f\n', bootResultsMean, bootResultsVar);
