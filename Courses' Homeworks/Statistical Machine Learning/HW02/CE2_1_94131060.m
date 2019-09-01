clc, clear all, close all;

%% Calculating the 93% confidence interval for Exponential Distribution Parameter
samplesNo = 1000;
mean = .5 * ones(samplesNo, 1);
exponRndNumbers = exprnd(mean);
betaEst = sum(exponRndNumbers) / samplesNo;
seEst = betaEst ./ sqrt(samplesNo);
a = betaEst - 1.812 * seEst;
b = betaEst + 1.812 * seEst;
fprintf('The 93 percent confidence interval for parameter Beta of Exponential Distribution is:\n\t');
fprintf('( %.4f , %.4f ) \n', a, b);

%% Confidence test
confTstMean = .5 * ones(samplesNo, 1e4);
confTstExponRndNumbers = exprnd(confTstMean);
confTstBetaEst = sum(confTstExponRndNumbers) / samplesNo;
confTst_seEst = confTstBetaEst ./ sqrt(samplesNo);
confTst_Interval = zeros(2, 1e4);
confTst_Interval(1, :) = confTstBetaEst - 1.812 .* confTst_seEst;
confTst_Interval(2, :) = confTstBetaEst + 1.812 .* confTst_seEst;
lowIntervTst = confTst_Interval(1, :) <= .5;
highIntervTst = confTst_Interval(2, :) >= .5;
occurrence = sum(transpose((lowIntervTst + highIntervTst)) == 2);
fprintf('Number of times that the confidence interval contains the parameter: \n\t%.4f \n' ,occurrence / 1e4);