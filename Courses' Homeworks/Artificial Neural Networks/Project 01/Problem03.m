clc, clear all, close all
dataSet = load('Dataset3.data');
set0 = find(dataSet(:,3)==0);
set1 = find(dataSet(:,3)==1);
X = dataSet(:, 1:2);
class0 = X(set0, :);
class1 = X(set1, :);
features = [class0; class1];
quadraticFeatures = [features, features .^ 2];
targetValue = [zeros(53,1); ones(97,1)];
threshold = rand(1);
% learningRate = 0.1;
maxEpoch = 1;
minError = 1e-7;
minValues = min(features);
maxValues = max(features);
error = zeros(maxEpoch, 150);
errorMean = zeros(maxEpoch, 1);
figure(1);
plot(class0(:, 1), class0(:,2), 'line', 'none', 'marker', 's', 'color', [.56 .36 .37]);
hold on;
plot(class1(:, 1), class1(:,2), 'line', 'none', 'marker', 'o', 'color', [.27 .77 .66]);
w = rand(4, 1)/length(features);
for m = 1: maxEpoch
    for p = 1 : size(features, 1)
        % featuresMagnitude = sqrt(dot(features(p, :), features(p, :)));
        % learningRate = 1 / featuresMagnitude;
        netInput = quadraticFeatures(p, :)*w - threshold;
        outputValue = hardlim(netInput);
        error(m, p) = targetValue(p) - outputValue;
        % w = w + learningRate * error(p) * transpose(features(p, :));
        w = w + error(m, p) * transpose(quadraticFeatures(p, :));
        threshold = threshold + error(p);
        figure(1);
        hold on;
        h1 = ezplot(@(x,y)soPtFunc(w(1),w(2),w(3),w(4),x,y,threshold), ...
            [minValues(1)-10 maxValues(1)+10 minValues(2)-10 maxValues(2)+10]);
        set(h1, 'color', rand(1,3));
        drawnow;
    end
    errorMean(m) = mean(transpose(abs(error(m, :))));
    if errorMean(m) <= minError
        break;
    end
end
figure(2);
plot(class0(:, 1), class0(:,2), 'line', 'none', 'marker', 's', 'color', [.56 .36 .37]);
hold on;
plot(class1(:, 1), class1(:,2), 'line', 'none', 'marker', 'o', 'color', [.27 .77 .66]);
finalError = mean(errorMean);
finalWeights = w;
finalThreshold = threshold;
figure(2);
h2 = ezplot(@(x,y)soPtFunc(finalWeights(1),finalWeights(2),finalWeights(3), ...
    finalWeights(4),x,y,finalThreshold), ...
    [minValues(1)-10 maxValues(1)+10 minValues(2)-10 maxValues(2)+10]);
set(h2, 'color', 'blue');