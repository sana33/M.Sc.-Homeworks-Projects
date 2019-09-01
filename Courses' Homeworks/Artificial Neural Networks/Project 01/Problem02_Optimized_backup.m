clc, clear all, close all
dataSet = load('Dataset2.data');
dataSet = sortrows(dataSet, 3);
features = dataSet(:, 1:2);
class1 = features(1:50, :);
class2 = features(51:end, :);
targetValue = [ones(length(class1), 1); -ones(length(class2), 1)];
threshold = rand(1);
% disp(threshold);
finalError = zeros(1, 3);
finalWeights = zeros(2, 3);
finalThreshold = zeros(1, 3);
minValues = min(features);
maxValues = max(features);
minError = 1e-7;
maxEpoch = 10;
x1 = 2:5;
learningRate = .1;
plotingWeights = zeros(2, maxEpoch, 3);
error = zeros(size(features, 1), maxEpoch, 3);
errorMean = zeros(maxEpoch, 3);
for n = 1: 3
    w = rand(2, 1)/length(features);
%     disp(w);
    m = 0;
    while(m < maxEpoch)
        m = m + 1;
        outputValue = sign(features * w - threshold);
        error(:, m, n) = targetValue - outputValue;
        w = w + learningRate * transpose(features) * error(:, m, n);
        plotingWeights(:, m, n) = w;
%         w = w + transpose(features) * error(:, m, n); % Updating weights without applying learning rate
        threshold = threshold + mean(error(:, m, n));
        figure(1);
        h1 = plot(class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
        hold on;
        h2 = plot(class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
        h3 = ezplot(@(x,y)foPtFunc(w(1),w(2),x,y,threshold), [minValues(1)-3 maxValues(1)+3 minValues(2)-3 maxValues(2)+3]);
        title('First Order Classification Problem With Perceptron - Evolutionary Plots');
        set(h3, 'color', rand(1, 3));
        grid on;
        drawnow;
        errorMean(m, n) = mean(abs(error(:, m, n)));
        if errorMean(m, n) <= minError
            break;
        end
    end
    finalError(n) = mean(abs(errorMean(:, n)));
    finalWeights(:, n) = w;
    finalThreshold(:, n) = threshold;
    finalCoefficient = -finalWeights(1, n) / finalWeights(2, n);
    finalBias = finalThreshold(1, n) / finalWeights(2, n);
    x2 = finalCoefficient * x1 + finalBias;
    figure(2);
    fh1 = plot(class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
    hold on;
    fh2 = plot(class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
    finalColorMap = [.7 .6 .5; .4 .5 .3; .8 .2 .7];
    fh3 = plot(x1, x2, '-', 'color', finalColorMap(n, :), 'LineWidth', 1.7);
    title('First Order Classification Problem With Perceptron - 3 Final Plots');
    drawnow;
    grid on;
end
eX = linspace(1,maxEpoch,maxEpoch);
figure(3);
eh1 = plot(eX, errorMean(:, 1), '-pr', eX, errorMean(:, 2), '-.ob', eX, errorMean(:, 3) ,'--+k');
legend('1st Perceptron Application', '2nd Perceptron Application', '3rd Perceptron Application');
title('Error Mean Diagram for Three Perceptron Applications');
grid on;
figure(4);
wh1 = plot(eX, plotingWeights(1, :, 1), '-pr', eX, plotingWeights(2, :, 1), '-.b');
legend('1st w1', '1st w2');
title('1st Perceptron Application Weight Diagram');
grid on;
figure(5);
wh2 = plot(eX, plotingWeights(1, :, 2), '-pr', eX, plotingWeights(2, :, 2), '-.b');
legend('2nd w1', '2nd w2');
title('2nd Perceptron Application Weight Diagram');
grid on;
figure(6);
wh3 = plot(eX, plotingWeights(1, :, 3), '-pr', eX, plotingWeights(2, :, 3), '-.b');
legend('3rd w1', '3rd w2');
title('3rd Perceptron Application Weight Diagram');
grid on;