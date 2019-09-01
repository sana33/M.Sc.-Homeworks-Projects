
clc; clear; close all;
dataSet = load('Dataset3.data');
set0 = find(dataSet(:,3)==0);
set1 = find(dataSet(:,3)==1);
X = dataSet(:, 1:2);
class0 = X(set0, :);
class1 = X(set1, :);
features = [class0; class1];
xmean = mean(features(:,1));
ymean = mean(features(:,2));
features(:,1) = features(:,1) - xmean;
features(:,2) = features(:,2) - ymean;
quadraticFeatures = [features, features .^ 2];
targetValue = [ones(length(set0),1); -ones(length(set1),1)];
threshold = 10;
minError = 1e-7;
maxEpoch = 300;
minValues = min(features);
maxValues = max(features);
w = rand(4, 1);
disp(w);
% plotingWeights = zeros(4, maxEpoch);
% error = zeros(length(features), maxEpoch);
% errorMean = zeros(maxEpoch);
m = 0;
learningRate = .1;
while(m < maxEpoch)
    m = m+1;
    netInput = quadraticFeatures*w - threshold;
    outputValue = sign(netInput);
    error(:,m) = targetValue - outputValue;
    w = w + learningRate*transpose(quadraticFeatures)*error(:,m);
    plotingWeights(:, m) = w;
    threshold = threshold + learningRate*mean(error(:,m));
    figure(1);
    h1 = plot(features(1:length(set0), 1)+xmean, features(1:length(set0),2)+ymean, 'linestyle', 'none', ...
     'marker', 's', 'color', [.56 .36 .37]);
    hold on;
    h2 = plot(features(length(set0)+1:end, 1)+xmean, features(length(set0)+1:end,2)+ymean, 'linestyle', ...
     'none', 'marker', 'o', 'color', [.27 .77 .66]);
    h3 = ezplot(@(x,y)soPtFunc(w(1),w(2),w(3),w(4),x-xmean,y-ymean,threshold),[xmean-3, xmean+3, ymean-3, ymean+3]);
    title('Second Order Classification Problem With Perceptron - Evolutionary Plots');
    set(h3,'color','b');
    drawnow;
    hold off;
    errorMean(m) = mean(abs(error(:, m)));
    if errorMean(m) <= minError
        break;
    end
end
noOfPoints = size(plotingWeights, 2);
eX = linspace(1, noOfPoints, noOfPoints);
figure(2);
eh1 = plot(eX, errorMean, '-or', 'LineWidth', 2);
title('Second Order Perceptron - Error Mean Diagram');
grid on;
figure(3);
wh = plot(eX, plotingWeights(1, :), '-pr', eX, plotingWeights(2, :), '-ob', eX, ...
    plotingWeights(3, :), '-*m', eX, plotingWeights(4, :), '-sk');
legend('w1', 'w2', 'w3', 'w4');
title('Second Order Perceptron - Weight Diagram');
grid on;
drawnow;