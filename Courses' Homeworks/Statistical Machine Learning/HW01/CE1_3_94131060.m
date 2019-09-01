clc, clear all, close all

%% NOTICE:
% We're deliberately using the standard normal distribution notated as Z
% here with mu equal to 0 and standard deviation equal to 1 to implement
% the answer because of MATLAB 2012's lack of having th Q-Func!

%% Question03-A Answer
samplesNo = 10000;
x = randn(samplesNo, 1);
mu = input('Please enter th mu of samples:\n');
variance = input('Please enter th variance of samples:\n');
standardDeviation = sqrt(variance);
realX = mu + standardDeviation * x;
rxMean = mean(realX);
rxStandardDeviation = std(realX);
rxVariance = var(realX);
fprintf('Mean value is: %0.5f\n\tStandard deviation is: %0.5f\n\t\tVariance is: %0.5f\n', rxMean, rxStandardDeviation, rxVariance);

xInterval = 0.01;
histAxisX = mu - 10:xInterval:mu + 10;
histResults = hist(realX, histAxisX);
normHistResults = histResults / sum(histResults) / xInterval;

figure(1);
bar(histAxisX, normHistResults);
xlabel('x');
ylabel('Observed PDF');
title('Question 3: Normal Distribution');
grid on;

xLtOne = realX(realX < 1);
histAxisXLtOne = mu - 10:xInterval:1;
histResultsLtOne = hist(xLtOne, histAxisXLtOne);
normHistResultsLtOne = histResultsLtOne / sum(histResults);
pXLtOne = sum(normHistResultsLtOne);
fprintf('____________________________\nQuestion 3 part A:\n____________________________\n');
probabilityLessThanOne = sprintf('Probability less than one is: %0.5f\n', pXLtOne);
disp(probabilityLessThanOne);

xBetwOneTwo = realX(realX < 2);
xBetwOneTwo = xBetwOneTwo(1 < xBetwOneTwo);
histAxisXBetwOneTwo = 1:xInterval:2;
histResultsBetwOneTwo = hist(xBetwOneTwo, histAxisXBetwOneTwo);
normHistResultsBetwOneTwo = histResultsBetwOneTwo / sum(histResults);
pXBetwOneTwo = sum(normHistResultsBetwOneTwo);
probabilityBetwOneTwo = sprintf('Probability between one and two is: %0.5f\n', pXBetwOneTwo);
disp(probabilityBetwOneTwo);

xGtTwo = realX(2 < realX);
histAxisXGtTwo = 2:xInterval:mu + 10;
histResultsGtTwo = hist(xGtTwo, histAxisXGtTwo);
normHistResultsGtTwo = histResultsGtTwo / sum(histResults);
pXGtTwo = sum(normHistResultsGtTwo);
probabilityGtTwo = sprintf('Probability greater than two is: %0.5f\n', pXGtTwo);
disp(probabilityGtTwo);

%% Question03-B Answer
fprintf('____________________________\nQuestion 3 part B:\n____________________________\n');
totalProb = pXLtOne + pXBetwOneTwo + pXGtTwo;
fprintf('Sum of above probabilities is equal to: %0.5f\n', totalProb);