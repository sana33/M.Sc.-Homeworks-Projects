function [] = plotDataCentroids(dataSet, centroids, iterNo, hObject, handles)
    dataSet = sortrows(dataSet, 4);
    cl0 = find(dataSet(:, 4) == 0);
    cl1 = find(dataSet(:, 4) == 1);
    cl2 = find(dataSet(:, 4) == 2);
    cl3 = find(dataSet(:, 4) == 3);

    Dxx = dataSet(:, 1);
    Dyy = dataSet(:, 2);
    Dzz = dataSet(:, 3);
    DcolorMap = [repmat([1 1 0], numel(cl0), 1); repmat([1 0 0], numel(cl1), 1); ...
        repmat([0 1 0], numel(cl2), 1); repmat([0 0 1], numel(cl3), 1)];    

    axes(handles.axes1);

    if iterNo > 1
        scatter3(Dxx, Dyy, Dzz, 12, DcolorMap);
        hold on;            
        plot3(transpose(squeeze(centroids(:, 1, 1:iterNo))), transpose(squeeze(centroids(:, 2, 1:iterNo))), ...
            transpose(squeeze(centroids(:, 3, 1:iterNo))), 'k');
        scatter3(centroids(:, 1, iterNo), centroids(:, 2, iterNo), centroids(:, 3, iterNo), 25, 'k', 'filled');
        hold off;
    else
        scatter3(Dxx, Dyy, Dzz, 12, DcolorMap);
        hold on;
        Cxx = centroids(:, 1);
        Cyy = centroids(:, 2);
        Czz = centroids(:, 3);
        scatter3(Cxx, Cyy, Czz, 25, 'k', 'filled');
        hold off;
    end
    guidata(hObject, handles);
    