clc, clear all, close all
dataSet = load('Dataset2.data');
features = dataSet(:, 1:2);
class1 = features(1:50, :);
class2 = features(51:150, :);
targetValue = dataSet(:, 3);
threshold = rand(1);
% learningRate = 0.1;
maxEpoch = 10;
finalError = zeros(1, 3);
finalWeights = zeros(2, 3);
finalThreshold = zeros(1, 3);
error = zeros(maxEpoch, 150, 3);
errorMean = zeros(maxEpoch, 3);
minError = 1e-7;
x1 = 2:5;
figure(1);
plot(class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
hold on;
plot(class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
for n = 1: 3
    w = rand(2, 1)/length(features);
    for m = 1: maxEpoch
        for p = 1 : size(features, 1)
            featuresMagnitude = sqrt(dot(features(p, :), features(p, :)));
            learningRate = 1 / featuresMagnitude;
            outputValue = hardlim(features(p, :) * w - threshold);
            error(m, p, n) = targetValue(p) - outputValue;
            w = w + learningRate * error(m, p, n) * transpose(features(p, :));
            % w = w + error(m, p, n) * transpose(features(p, :));
            threshold = threshold + error(m, p, n);
            tempCoefficient = -w(1, 1)/w(2, 1);
            tempBias = threshold / w(2, 1);
            x2temp = tempCoefficient * x1 + tempBias;
            figure(1);
            colorMap = rand(size(features, 1), 3);
            plot(x1, x2temp, 'color', colorMap(p, :), 'LineWidth', 1, 'Line', '--');
            hold all;
        end
        errorMean(m, n) = mean(transpose(abs(error(m, :, n))));
        if errorMean(m, n) <= minError
            break;
        else
            continue;
        end
        figure(1);
        hold off
    end
    figure(2);
    plot(class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
    hold on;
    plot(class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
    finalError(n) = mean(abs(errorMean(:, n)));
    finalWeights(:, n) = w;
    finalThreshold(:, n) = threshold;
    finalCoefficient = -finalWeights(1, n) / finalWeights(2, n);
    finalBias = finalThreshold(1, n) / finalWeights(2, n);
    x2 = finalCoefficient * x1 + finalBias;
    figure(2);
    finalColorMap = [.7 .6 .5; .4 .5 .3; .8 .2 .7];
    plot(x1, x2, '-', 'color', finalColorMap(n, :), 'LineWidth', 1.7);
end