%% Problem 1: classification of 150 samples of three classes with four dimensions
clc, clear all, close all
minError = 1e-3;
maxEpoch = 200;
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
threshold = rand(1, 2);
% disp(threshold);
outputValue = zeros(size(features, 1), 1);
finalError = zeros(1, 3, 2);
finalWeights = zeros(4, 3, 2);
finalThreshold = zeros(1, 2);
perceptronLearningRate = .001;
adalineLearningRate = .0001;
perceptronError = zeros(size(features, 1), maxEpoch, 3);
adalineError = zeros(size(features, 1), maxEpoch, 3);
perceptronErrorMean = zeros(maxEpoch, 3);
adalineErrorMean = zeros(maxEpoch, 3);

%% Perceptron learning rule
for n = 1: 3 % 1)Class 0 vs all; 2)Class 1 vs all; 3)Class 2 vs all; 
    pw = rand(4, 1)/length(features);
%     disp(pw);
    m = 0;
    while(m < maxEpoch)
        m = m + 1;
        outputValue = sign(features * pw - threshold(1));
        perceptronError(:, m, n) = targetValue(:, n) - outputValue;
        pw = pw + perceptronLearningRate * transpose(features) * perceptronError(:, m, n);
        perceptronPlotingWeights(:, m, n) = pw;
        threshold(1) = threshold(1) + mean(perceptronError(:, m, n));
        perceptronErrorMean(m, n) = mean(abs(perceptronError(:, m, n)));
        if perceptronErrorMean(m, n) <= minError
            break;
        end
    end
    finalError(1, n, 1) = mean(perceptronErrorMean(:, n));
    finalWeights(:, n, 1) = pw;
    finalThreshold(1) = threshold(1);
end % End of for loop

%% Adaline learning rule
for nn = 1: 3 % 1)Class 0 vs all; 2)Class 1 vs all; 3)Class 2 vs all; 
    aw = rand(4, 1)/length(features);
%     disp(aw);
    mm = 0;
    while(mm < maxEpoch)
        mm = mm + 1;
        outputValue = features * aw - threshold(2);
        adalineError(:, mm, nn) = targetValue(:, nn) - outputValue;
        aw = aw + adalineLearningRate * transpose(features) * adalineError(:, mm, nn);
        adalinePlotingWeights(:, m, n) = aw;
        threshold(2) = threshold(2) + mean(adalineError(:, mm, nn));
        adalineErrorMean(mm, nn) = mean(abs(adalineError(:, mm, nn)));
        if adalineErrorMean(mm, nn) <= minError
            break;
        end
    end
    finalError(1, nn, 2) = mean(adalineErrorMean(:, nn));
    finalWeights(:, nn, 2) = aw;
    finalThreshold(2) = threshold(2);
end % End of for loop

%% Perceptron learning rule figures
% Perceptron error figures
figure(1);
plot(perceptronErrorMean(:, 1), 'color', 'r');
title('Perceptron Learning Rule Error Oscillations');
hold all;
plot(perceptronErrorMean(:, 2), 'color', 'b');
plot(perceptronErrorMean(:, 3), 'color', 'k');
legend('Zero vs All','One vs All','Two vs All');
grid on;
% Perceptron weight figures
pwX = linspace(1,m,m);
figure(2);
plot(pwX, perceptronPlotingWeights(1, :,1), '-r', pwX, perceptronPlotingWeights(2, :,1), '-b', ...
    pwX, perceptronPlotingWeights(3, :,1), '-k', pwX, perceptronPlotingWeights(4, :,1), '-c');
legend('w1', 'w2', 'w3', 'w4');
title('Perceptron weight figures: Class zero vs all');
grid on;
figure(3);
plot(pwX, perceptronPlotingWeights(1, :,2), '-r', pwX, perceptronPlotingWeights(2, :,2), '-b', ...
    pwX, perceptronPlotingWeights(3, :,2), '-k', pwX, perceptronPlotingWeights(4, :,2), '-c');
legend('w1', 'w2', 'w3', 'w4');
title('Perceptron weight figures: Class one vs all');
grid on;
figure(4);
plot(pwX, perceptronPlotingWeights(1, :,3), '-r', pwX, perceptronPlotingWeights(2, :,3), '-b', ...
    pwX, perceptronPlotingWeights(3, :,3), '-k', pwX, perceptronPlotingWeights(4, :,3), '-c');
legend('w1', 'w2', 'w3', 'w4');
title('Perceptron weight figures: Class two vs all');
grid on;

%% Adaline learning rule figures
% Adaline error figures
figure(5);
plot(adalineErrorMean(:, 1), 'color', 'r');
title('Adaline Learning Rule Error Oscillations');
hold all;
plot(adalineErrorMean(:, 2), 'color', 'b');
plot(adalineErrorMean(:, 3), 'color', 'k');
legend('Zero vs All','One vs All','Two vs All');
grid on;
% Adaline weight figures
awX = linspace(1,mm,mm);
figure(6);
plot(awX, adalinePlotingWeights(1, :,1), '-r', awX, adalinePlotingWeights(2, :,1), '-b', ...
    awX, adalinePlotingWeights(3, :,1), '-k', awX, adalinePlotingWeights(4, :,1), '-c');
legend('w1', 'w2', 'w3', 'w4');
title('Adaline weight figures: Class zero vs all');
grid on;
figure(7);
plot(awX, adalinePlotingWeights(1, :,2), '-r', awX, adalinePlotingWeights(2, :,2), '-b', ...
    awX, adalinePlotingWeights(3, :,2), '-k', awX, adalinePlotingWeights(4, :,2), '-c');
legend('w1', 'w2', 'w3', 'w4');
title('Adaline weight figures: Class one vs all');
grid on;
figure(8);
plot(awX, adalinePlotingWeights(1, :,3), '-r', awX, adalinePlotingWeights(2, :,3), '-b', ...
    awX, adalinePlotingWeights(3, :,3), '-k', awX, adalinePlotingWeights(4, :,3), '-c');
legend('w1', 'w2', 'w3', 'w4');
title('Adaline weight figures: Class two vs all');
grid on;
