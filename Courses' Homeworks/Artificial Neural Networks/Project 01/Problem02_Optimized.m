function [] = Problem02_Optimized(maxEp, minErr, netInput)
    dataSet = netInput;
    dataSet = sortrows(dataSet, 3);
    features = dataSet(:, 1:2);
    class1 = features(1:50, :);
    class2 = features(51:150, :);
    targetValue = [ones(length(class1), 1); -ones(length(class2), 1)];
    threshold = rand(1);
    finalError = zeros(1, 3);
    finalWeights = zeros(2, 3);
    finalThreshold = zeros(1, 3);
    minValues = min(features);
    maxValues = max(features);
    minError = minErr;
    maxEpoch = maxEp;
    x1 = 2:5;
    learningRate = .1;
    plotingWeights = zeros(2, maxEpoch, 3);
    error = zeros(150, maxEpoch, 3);
    errorMean = zeros(maxEpoch, 3);
    for n = 1: 3
        w = rand(2, 1)/length(features);
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
            h1 = plot(handles.axes1, class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
            hold on;
            h2 = plot(handles.axes1, class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
            h3 = ezplot(handles.axes1, @(x,y)foPtFunc(w(1),w(2),x,y,threshold), [minValues(1)-3 maxValues(1)+3 minValues(2)-3 maxValues(2)+3]);
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
        fh1 = plot(handles.axes2, class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
        hold on;
        fh2 = plot(handles.axes2, class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
        finalColorMap = [.7 .6 .5; .4 .5 .3; .8 .2 .7];
        fh3 = plot(handles.axes2, x1, x2, '-', 'color', finalColorMap(n, :), 'LineWidth', 1.7);
        drawnow;
        grid on;
    end
    eX = linspace(1,maxEpoch,maxEpoch);
    figure(3);
    eh1 = plot(handles.axes6, eX, errorMean(:, 1));
    grid on;
    figure(4);
    eh2 = plot(handles.axes7, eX, errorMean(:, 2));
    grid on;
    figure(5);
    eh3 = plot(handles.axes8, eX, errorMean(:, 3));
    grid on;
    figure(6);
    wh1 = plot(handles.axes3, plotingWeights(1, :, 1), plotingWeights(2, :, 1));
    grid on;
    figure(7);
    wh2 = plot(handles.axes4, plotingWeights(1, :, 2), plotingWeights(2, :, 2));
    grid on;
    figure(8);
    wh3 = plot(handles.axes5, plotingWeights(1, :, 3), plotingWeights(2, :, 3));
    grid on;
end