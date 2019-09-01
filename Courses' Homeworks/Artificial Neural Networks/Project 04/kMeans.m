function [finalCentroids, costFunc, kk]=kMeans(dataSet,centroidsNo, hObject, handles)
    kk = 1;
    finalCentroids = zeros(centroidsNo, size(dataSet, 2), 100);
    finalCentroids(:, :, kk) = datasample(dataSet, centroidsNo);
    centroidsTemp = zeros(centroidsNo, size(dataSet, 2));
    features = zeros(size(dataSet, 1), size(dataSet, 2), centroidsNo);
    centroidsMatrix = zeros(size(dataSet, 1), size(dataSet, 2), centroidsNo);
    costFunc = zeros(1, 100);

    while(kk < 100)
        costFunc(kk) = 0; 

        for ii = 1:centroidsNo
            features(:, :, ii) = dataSet;
            centroidsMatrix(:, :, ii) = ones(size(dataSet, 1), 1) * finalCentroids(ii, :, kk);
        end
        distMatrix = squeeze(sqrt(sum(((features - centroidsMatrix) .^ 2), 2)));

        [minDist2Cent, centroidIndex] = min(distMatrix, [], 2);
        
        for jj = 1:centroidsNo
            if (~any(centroidIndex == jj))
                centroidsTemp(jj, :) = finalCentroids(jj, :, kk);
            else
                members = dataSet((centroidIndex == jj), :);
                centroidsTemp(jj, :) = mean(members);
            end
            costFunc(kk) = costFunc(kk) + sum(minDist2Cent(centroidIndex == jj)) + ...
                sum(pdist(dataSet(centroidIndex == jj, :)));
        end
        %% Plot cost function for K-Means algorithm
        axes(handles.axes4);
        plot(costFunc(1:kk), '-r');
        grid on;
        set(handles.cost_func_value_editText, 'String', num2str(costFunc(kk)));
        pause(.0005);    

        %% Check for update and stoping condition
        stopCond = sum(sum(~(finalCentroids(:, :, kk) == centroidsTemp)));
        if stopCond ~= 0
            finalCentroids(:, :, kk + 1) = centroidsTemp;
        else
            break
        end
        %% Increasing the counter value
        kk = kk+1;
    end % End of while
    guidata(hObject, handles);
