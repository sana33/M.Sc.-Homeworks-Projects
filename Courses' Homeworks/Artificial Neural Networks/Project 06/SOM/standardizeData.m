function [standardData] = standardizeData(dataSet)
% This function calculates the standardized features of the dataset, the
% columns are considered to be the features and the rows are the data
% samples; CAUTION: Instead of this function the MATLAB zscore function can
% be used! BUT I NOTICED THIS LATE!!
dataSetNo = size(dataSet,1);
dataSetMean = sum(dataSet) ./ dataSetNo;
dataSetVar = sum((dataSet - ones(dataSetNo, 1) * dataSetMean) .^ 2) ./ (dataSetNo - 1);
dataSetStd = sqrt(dataSetVar);
standardData = (dataSet - ones(dataSetNo, 1) * dataSetMean) ./ (ones(dataSetNo, 1) * dataSetStd);