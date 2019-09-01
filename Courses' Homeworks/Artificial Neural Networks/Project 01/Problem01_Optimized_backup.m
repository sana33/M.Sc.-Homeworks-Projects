clc, clear all, close all
minError = 1e-7;
maxEpoch = 30000;
dataSet = load('Dataset1.data');
dataSet = sortrows(dataSet, 5);
features = dataSet(:, 1:4);
set0 = find(dataSet(:, 5)==0);
set1 = find(dataSet(:, 5)==1);
set2 = find(dataSet(:, 5)==2);
class0 = features(set0, :);
class1 = features(set1, :);
class2 = features(set2, :);
targetValue = zeros(size(features, 1), 3);
targetValue(:, 1) = [ones(length(class0), 1); -ones(length(features)-length(class0), 1)];
targetValue(:, 2) = [-ones(length(class0), 1); ones(length(class1), 1); -ones(length(class2), 1)];
targetValue(:, 3) = [-ones(length(features)-length(class2), 1); ones(length(class2), 1)];
threshold = rand(1, 3);
outputValue = zeros(size(features, 1), 1);
finalError = zeros(1, 3);
finalWeights = zeros(4, 3);
finalThreshold = zeros(1, 3);
perceptronLearningRate = .01;
adalineLearningRate = .01;
error = zeros(size(features, 1), maxEpoch, 3);
errorMean = zeros(maxEpoch, 3);
for n = 1: 3 % 1)Class 0 vs all; 2)Class 1 vs all; 3)Class 2 vs all; 
    w = rand(4, 1)/length(features);
    m = 0;
    while(m < maxEpoch)
        m = m + 1;
        outputValue = sign(features * w - threshold(n));
        error(:, m, n) = targetValue(:, n) - outputValue;
        w = w + perceptronLearningRate * transpose(features) * error(:, m, n);
        threshold(n) = threshold(n) + mean(error(:, m, n));
        errorMean(m, n) = mean(abs(error(:, m, n)));
        if errorMean(m, n) <= minError
            break;
        end
    end
    finalError(n) = mean(errorMean(:, n));
    finalWeights(:, n) = w;
    finalThreshold(:, n) = threshold(n);
end % End of for loop

figure(1);
plot(errorMean(:, 1), 'color', 'r');
hold all;
plot(errorMean(:, 2), 'color', 'b');
plot(errorMean(:, 3), 'color', 'k');
legend('Zero vs All','One vs All','Two vs All');
grid on;