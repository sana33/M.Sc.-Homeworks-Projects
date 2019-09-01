function [] = plotKWeightsDims(hObject, handles, kWeightsReshaped, inputNo, inputLength)
    kWeightsReshaped = normalizeDataSet(kWeightsReshaped, 1, 0, 0);
    
    if mod(sqrt(inputNo), 1) ~= 0
        kohonenWeightsDims = [kWeightsReshaped; zeros((floor(sqrt(inputNo))+1).^2-inputNo, inputLength)];
        squareSize = floor(sqrt(inputNo))+1;
    else
        kohonenWeightsDims = kWeightsReshaped;
        squareSize = sqrt(inputNo);
    end
    
    axes(handles.axes8); imagesc(reshape(kohonenWeightsDims(:, 1), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes9); imagesc(reshape(kohonenWeightsDims(:, 2), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes10); imagesc(reshape(kohonenWeightsDims(:, 3), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes11); imagesc(reshape(kohonenWeightsDims(:, 4), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes12); imagesc(reshape(kohonenWeightsDims(:, 5), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes13); imagesc(reshape(kohonenWeightsDims(:, 6), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes14); imagesc(reshape(kohonenWeightsDims(:, 7), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes15); imagesc(reshape(kohonenWeightsDims(:, 8), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes16); imagesc(reshape(kohonenWeightsDims(:, 9), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes17); imagesc(reshape(kohonenWeightsDims(:, 10), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes18); imagesc(reshape(kohonenWeightsDims(:, 11), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes19); imagesc(reshape(kohonenWeightsDims(:, 12), squareSize, squareSize, []), 'CDataMapping', 'scaled');
    axes(handles.axes20); imagesc(reshape(kohonenWeightsDims(:, 13), squareSize, squareSize, []), 'CDataMapping', 'scaled'); colorbar;

    guidata(hObject, handles);
end