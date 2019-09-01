clc, clear all, close all

experimentsNo = 100000;
probVector = rand(experimentsNo, 1);
sampleNegOne = probVector < .25;
samplePosOne = probVector > .25;
sampleVector = -sampleNegOne;
sampleVector(samplePosOne) = 1;

observedMean = mean(sampleVector);
observedVariance = mean((sampleVector - observedMean) .^ 2);

xValues = [-1 1];
truePMF = [.25 .75];
trueMean = dot(xValues, truePMF);
trueVariance = dot((xValues - trueMean) .^ 2, truePMF);

fprintf('The observed and true mean are respectively: \t%.05f\t%0.5f\n\tThe observed and true variance are respectively: \t%0.5f\t%0.5f\n', observedMean, trueMean, observedVariance, trueVariance);
