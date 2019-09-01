clc, clear all, close all;

TwainValues = [.225; .262; .217; .240; .230; .229; .235; .217];
TwainAvg = mean(TwainValues);
TwainSize = length(TwainValues);
SnodgrassValues = [.209, .205, .196, .210, .202, .207, .224, .223, .220, .201];
SnodgrassAvg = mean(SnodgrassValues);
SnodgrassSize = length(SnodgrassValues);
TwainVar = sum((TwainValues - TwainAvg) .^ 2) ./ TwainSize;
SnodgrassVar = sum((SnodgrassValues - SnodgrassAvg) .^ 2) ./ SnodgrassSize;
TwainSampleVar = TwainVar ./ TwainSize;
SnodgrassSampleVar = SnodgrassVar ./ SnodgrassSize;
meansDiff = TwainAvg - SnodgrassAvg;
meansDiffseHat = sqrt(TwainSampleVar + SnodgrassSampleVar);
% Computing W for the size alpha Wald test
WaldTest = (TwainAvg - SnodgrassAvg) ./ meansDiffseHat;
% Computing the p-value for the Wald test:
% p-value=P(|Z|>|W|)=2P(Z>-|W|)=2PHI(-|W|)
pValue = double(2 .* normcdf(-abs(WaldTest)));
% Computing phiInv(1 - alpha/2) where alpha=.03; so 1-alpha/2=.985
z_alphaOver2 = norminv(.985, 0, 1);
% Computing the 97% confidence interval for the difference of the means
confIntervLow = meansDiff - z_alphaOver2 .* meansDiffseHat;
confIntervHigh = meansDiff + z_alphaOver2 .* meansDiffseHat;

fprintf('The final results are as follows:\n');
fprintf('W = \t\t\t\t\t%.4f \np-value: \t\t\t\t%.4f \nConfidence Interval: \t( %.4f , %.4f )\n', ...
    WaldTest, pValue, confIntervLow, confIntervHigh);
