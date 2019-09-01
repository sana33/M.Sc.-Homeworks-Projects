function [kMeansTestError, somTestError] = kMeansVSsom(testSetData, testSetClass, SOMclusterIndicator, winnerDistType, hObject, handles)
% This function calculates the error rate gained by clustering data with
% k-means and som methods. Here we're using k-means toolbox of MATLAB and
% som method created by my own!
testSetNo = size(testSetData, 1);
testClassTypeResult = zeros(testSetNo, 1);
for dd = 1:testSetNo
    switch winnerDistType
            case 'euclidian_winDistType_radioButton'
                distMatrixTest = squareform(pdist([SOMclusterIndicator; testSetData(dd, :)]));
            case 'spherGeomDist_winDistType_radioButton'
                distMatrixTest = squareform(pdist([SOMclusterIndicator; testSetData(dd, :)], @sgDist));
    end
    [bmuDistTest, bmuIndexTest] = min(transpose(distMatrixTest(end, 1:end-1)));
    testClassTypeResult(dd) = bmuIndexTest;
end
% Calculating som error rate
somTestError = sum(testClassTypeResult ~= testSetClass) ./ testSetNo .* 100;
% Calculating kMeans error rate
% s = load('kMeansBestRNG.mat');
% s = load('kMeansBestRNG.m');
% rng(s);
[idx, C] = kmeans(testSetData, 3);
% idxTmp = idx;
% idxTmp(idx == 2) = 4;
% idxTmp(idx == 3) = 2;
% idxTmp(idx == 4) = 3;
% kMeansTestError = sum(idxTmp ~= testSetClass) ./ testSetNo .* 100;
kMeansTestError = sum(idx ~= testSetClass) ./ testSetNo .* 100;
% Puttig gained errors at the GUI
set(handles.kmeans_error_rate_editText, 'String', num2str(kMeansTestError));
set(handles.som_error_rate_editText, 'String', num2str(somTestError));

guidata(hObject, handles);