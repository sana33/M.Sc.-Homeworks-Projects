function varargout = RBFNN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RBFNN_OpeningFcn, ...
                   'gui_OutputFcn',  @RBFNN_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function RBFNN_OpeningFcn(hObject, eventdata, handles, varargin)
    global loadDataStatus;
    loadDataStatus = 0;
    
    handles.output = hObject;

    selectedOption = get(handles.weight_update_method_buttonGroup, 'SelectedObject');
    if  ~strcmp(get(selectedOption, 'tag'), 'rls_method_radioButton')
        set(handles.lambda_editText, 'Enable', 'off')
    elseif strcmp(get(selectedOption, 'tag'), 'rls_method_radioButton')
        set(handles.lambda_editText, 'Enable', 'on')
    end

    if get(handles.beta_param_checkBox, 'value') == 0
        set(handles.beta1_param_editText, 'Enable', 'off');
        set(handles.beta2_param_editText, 'Enable', 'off');
        set(handles.beta3_param_editText, 'Enable', 'off');
    elseif get(handles.beta_param_checkBox, 'value') == 1
        set(handles.beta1_param_editText, 'Enable', 'on');
        set(handles.beta1_param_editText, 'Enable', 'on');
        set(handles.beta1_param_editText, 'Enable', 'on');        
    end
        
    if ~loadDataStatus
        set(handles.start_pushButton, 'Enable', 'off');
        set(handles.normalize_data_checkBox, 'Enable', 'off');
        set(handles.interval_top_editText, 'Enable', 'off');
        set(handles.interval_bottom_editText, 'Enable', 'off');
        set(handles.random_radioButton, 'Enable', 'off');
        set(handles.data_sample_radioButton, 'Enable', 'off');
        set(handles.k_means_radioButton, 'Enable', 'off');
        set(handles.centroids_no_editText, 'Enable', 'off');
        set(handles.train_size_perce_editText, 'Enable', 'off');
        set(handles.eval_size_perce_editText, 'Enable', 'off');
    end
    
    guidata(hObject, handles);

function varargout = RBFNN_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function interval_top_editText_Callback(hObject, eventdata, handles)
    if strcmp(get(handles.interval_top_editText, 'Enable'), 'on')
        normalize_data_checkBox_Callback(hObject, eventdata, handles);
    end

function interval_top_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function interval_bottom_editText_Callback(hObject, eventdata, handles)
    if strcmp(get(handles.interval_bottom_editText, 'Enable'), 'on')
        normalize_data_checkBox_Callback(hObject, eventdata, handles);
    end

function interval_bottom_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lambda_editText_Callback(hObject, eventdata, handles)

function lambda_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function train_size_perce_editText_Callback(hObject, eventdata, handles)
normalize_data_checkBox_Callback(hObject, eventdata, handles);

function train_size_perce_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eval_size_perce_editText_Callback(hObject, eventdata, handles)
normalize_data_checkBox_Callback(hObject, eventdata, handles);

function eval_size_perce_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function centroids_no_editText_Callback(hObject, eventdata, handles)
normalize_data_checkBox_Callback(hObject, eventdata, handles);

function centroids_no_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function beta1_param_editText_Callback(hObject, eventdata, handles)

function beta1_param_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function beta_param_checkBox_Callback(hObject, eventdata, handles)
    if get(handles.beta_param_checkBox, 'value') == 0
        set(handles.beta1_param_editText, 'Enable', 'off');
        set(handles.beta2_param_editText, 'Enable', 'off');
        set(handles.beta3_param_editText, 'Enable', 'off');
    elseif get(handles.beta_param_checkBox, 'value') == 1
        set(handles.beta1_param_editText, 'Enable', 'on');
        set(handles.beta2_param_editText, 'Enable', 'on');
        set(handles.beta3_param_editText, 'Enable', 'on');
    end
    guidata(hObject, handles);

function rls_method_radioButton_Callback(hObject, eventdata, handles)

function weight_update_method_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles)
    selectedOptionWUM = get(handles.weight_update_method_buttonGroup, 'SelectedObject');
    if  ~strcmp(get(selectedOptionWUM, 'tag'), 'rls_method_radioButton')
        set(handles.lambda_editText, 'Enable', 'off')
    elseif strcmp(get(selectedOptionWUM, 'tag'), 'rls_method_radioButton')
        set(handles.lambda_editText, 'Enable', 'on')
    end
    guidata(hObject, handles);

function load_data_pushButton_Callback(hObject, eventdata, handles)
    [FileName,PathName] = uigetfile('*.txt', 'Select the Input File', 'Data.txt');
    if ~FileName 
        h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
    else
        handles.finalDataset = sortrows(load([PathName FileName]), 4);
        h = msgbox('File was loaded successfully!','Success');
        set(handles.start_pushButton, 'Enable', 'on');
        set(handles.normalize_data_checkBox, 'Enable', 'on');
        set(handles.interval_top_editText, 'Enable', 'on');
        set(handles.interval_bottom_editText, 'Enable', 'on');
        set(handles.random_radioButton, 'Enable', 'on');
        set(handles.data_sample_radioButton, 'Enable', 'on');
        set(handles.k_means_radioButton, 'Enable', 'on');
        set(handles.centroids_no_editText, 'Enable', 'on');
        set(handles.train_size_perce_editText, 'Enable', 'on');
        set(handles.eval_size_perce_editText, 'Enable', 'on');        
        normalize_data_checkBox_Callback(hObject, eventdata, handles);
    end
    guidata(hObject, handles);

function start_pushButton_Callback(hObject, eventdata, handles)
    global gCentroids;
    set(handles.total_samples_editText, 'String', '');
    set(handles.wrongly_classified_editText, 'String', '');
    set(handles.correctly_classified, 'String', '');
    set(handles.classification_error_perc, 'String', '');
    set(handles.classification_error_mse, 'String', '');
    set(handles.final_train_error_perc_editText, 'String', '');
    set(handles.final_eval_error_perc_editText, 'String', '');
    set(handles.final_train_error_mse_editText, 'String', '');
    set(handles.final_eval_error_mse_editText, 'String', '');
    set(handles.cost_func_value_editText, 'String', '');

    setHandlesOnOff(hObject, handles, 'off');
    
    dataSet = handles.finalDataset;
    sortedTags = dataSet(:, 4);

    targetValues = zeros(size(dataSet, 1), 4);
    targetValues((sortedTags == 0), 1) = 1;
    targetValues((sortedTags == 1), 2) = 1;
    targetValues((sortedTags == 2), 3) = 1;
    targetValues((sortedTags == 3), 4) = 1;
    
    handles.isNormalized = get(handles.normalize_data_checkBox, 'Value');
    intervalTop = str2double(get(handles.interval_top_editText, 'String'));
    intervalBottom = str2double(get(handles.interval_bottom_editText, 'String'));
    handles.intervalTop = intervalTop;
    handles.intervalBottom = intervalBottom;

    centroidsNo = str2num(get(handles.centroids_no_editText, 'String'));

    centroids = gCentroids;

    sigma = max(pdist(centroids)) ./ sqrt(2 .* size(centroids, 1));

    features = zeros(size(dataSet(:, 1:3), 1), size(dataSet(:, 1:3), 2), centroidsNo);
    centroidsMatrix = zeros(size(dataSet(:, 1:3), 1), size(dataSet(:, 1:3), 2), centroidsNo);
    for ii = 1:centroidsNo
        features(:, :, ii) = dataSet(:, 1:3);
        centroidsMatrix(:, :, ii) = ones(size(dataSet(:, 1:3), 1), 1) * centroids(ii, :);
    end

    isBeta = get(handles.beta_param_checkBox, 'value');
    handles.isBeta = isBeta;
    if isBeta
        beta1 = str2double(get(handles.beta1_param_editText, 'string'));
        beta2 = str2double(get(handles.beta2_param_editText, 'string'));
        beta3 = str2double(get(handles.beta3_param_editText, 'string'));
        if beta1 <= 0
            beta1 = 1.1;
        elseif beta2 <= 0
            beta2 = 1.2;
        elseif beta3 <= 0
            beta3 = 1.3;
        end
        handles.betaParams = [beta1 beta2 beta3];
        betaMat = ones(size(dataSet(:, 1:3), 1), 1) * [beta1 beta2 beta3];
        betaMatrix = zeros(size(dataSet(:, 1:3), 1), size(dataSet(:, 1:3), 2), centroidsNo);
        for ll = 1:centroidsNo
            betaMatrix(:, :, ll) = betaMat;
        end
        distMatrix = squeeze(sqrt(sum((((features - centroidsMatrix) ./ betaMatrix) .^ 2), 2)));
    else
        handles.betaParams = [1.1 1.2 1.3];
        distMatrix = squeeze(sqrt(sum(((features - centroidsMatrix) .^ 2), 2)));
    end

    phiType = get(get(handles.rbf_func_buttonGroup, 'SelectedObject'), 'tag');
    handles.RBFfuncType = phiType;
    handles.isBias = get(handles.is_bias_checkBox, 'Value');
    if handles.isBias == 1
        phiOutput = [phiFunc(distMatrix, sigma, phiType) ones(size(distMatrix, 1), 1)];
    else
        phiOutput = phiFunc(distMatrix, sigma, phiType);
    end

    trainPercentage = str2num(get(handles.train_size_perce_editText, 'String'));
    evalPercentage = str2num(get(handles.eval_size_perce_editText, 'String'));
    handles.trainSizePerc = trainPercentage;
    handles.evalSizePerc = evalPercentage;
    trainIndex = floor(.01 .* trainPercentage .* 800);
    evalIndex = trainIndex + floor(.01 * evalPercentage * 800);
    trainDataset = phiOutput([1:trainIndex 801:800+trainIndex 1601:1600+trainIndex 2401:2400+trainIndex], :);
    trainTags = targetValues([1:trainIndex 801:800+trainIndex 1601:1600+trainIndex 2401:2400+trainIndex], :);
    evalDataset = phiOutput([trainIndex+1:evalIndex trainIndex+801:evalIndex+800 trainIndex+1601:evalIndex+1600 ...
        trainIndex+2401:evalIndex+2400], :);
    evalTags = targetValues([trainIndex+1:evalIndex trainIndex+801:evalIndex+800 trainIndex+1601:evalIndex+1600 ...
        trainIndex+2401:evalIndex+2400], :);
    testDataset = phiOutput([evalIndex+1:800 evalIndex+801:1600 evalIndex+1601:2400 evalIndex+2401:3200], :);
    testTags = targetValues([evalIndex+1:800 evalIndex+801:1600 evalIndex+1601:2400 evalIndex+2401:3200], :);

    weightLearningMethod = get(get(handles.weight_update_method_buttonGroup, 'SelectedObject'), 'tag');
    handles.weightUpdateMethod = weightLearningMethod;
    switch weightLearningMethod
        case 'basic_rbf_method_radioButon'
            weightMatrix = pinv(trainDataset) * trainTags;
            [misClassified, correctlyClassified, classificationError] = rbfTest([evalDataset; testDataset], ...
                [evalTags; testTags], weightMatrix);
            handles.testClassificationResults = [misClassified + correctlyClassified, misClassified, correctlyClassified, transpose(classificationError)];
            set(handles.total_samples_editText, 'String', num2str(misClassified + correctlyClassified));
            set(handles.wrongly_classified_editText, 'String', num2str(misClassified));
            set(handles.correctly_classified, 'String', num2str(correctlyClassified));
            set(handles.classification_error_mse, 'String', num2str(classificationError(1)));
            set(handles.classification_error_perc, 'String', num2str(classificationError(2) .* 100));
            handles.finalWeightMatrix = weightMatrix;            
            handles.lambdaParam = .1;
            handles.RLSerrorTrain = zeros(2, 1);
            handles.RLSerrorEval = zeros(2, 1);
            set(handles.plot_weight_oscillation_pushButton, 'Enable', 'off');
        case 'rls_method_radioButton'
            lambda = str2double(get(handles.lambda_editText, 'String'));
            handles.lambdaParam = lambda;
            if lambda <= 0
                lambda = .1;
            end
            [weightMatrix, errorTrain, errorEval] = RLSalgorithm(trainDataset, evalDataset, trainTags, evalTags, lambda, hObject, handles);
            [misClassified, correctlyClassified, classificationError] = rbfTest(testDataset, testTags, weightMatrix(:, :, end));
            handles.testClassificationResults = [misClassified + correctlyClassified, misClassified, correctlyClassified, transpose(classificationError)];
            set(handles.total_samples_editText, 'String', num2str(misClassified + correctlyClassified));
            set(handles.wrongly_classified_editText, 'String', num2str(misClassified));
            set(handles.correctly_classified, 'String', num2str(correctlyClassified));
            set(handles.classification_error_mse, 'String', num2str(classificationError(1)));
            set(handles.classification_error_perc, 'String', num2str(classificationError(2) .* 100));
            set(handles.plot_weight_oscillation_pushButton, 'Enable', 'on');
            handles.finalWeightMatrix = weightMatrix;
            handles.RLSerrorTrain = errorTrain;
            handles.RLSerrorEval = errorEval;
    end
    setHandlesOnOff(hObject, handles, 'on');
    guidata(hObject, handles);

function normalize_data_checkBox_Callback(hObject, eventdata, handles)
    if get(handles.normalize_data_checkBox, 'Value') == 1
        set(handles.interval_top_editText, 'Enable', 'on');
        set(handles.interval_bottom_editText, 'Enable', 'on');        
        dataSet = handles.finalDataset;
        sortedDataSet = sortrows(dataSet, 4);
        sortedTags = sortedDataSet(:, 4);        
        intervalTop = str2double(get(handles.interval_top_editText, 'String'));
        intervalBottom = str2double(get(handles.interval_bottom_editText, 'String'));
        normSortedDataSet = normalizeDataSet(sortedDataSet(:, 1:3), intervalTop, intervalBottom, 1);
        handles.finalDataset = [normSortedDataSet sortedTags];
        centroid_select_meth_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles, 1);
    else
        set(handles.interval_top_editText, 'Enable', 'off');
        set(handles.interval_bottom_editText, 'Enable', 'off');
        centroid_select_meth_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);        
    end
    guidata(hObject, handles);

function norm_interval_panel_CreateFcn(hObject, eventdata, handles)

function cost_func_value_editText_CreateFcn(hObject, eventdata, handles)

function centroid_select_meth_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles, tmpArg)
    global gCentroids;
    finalDataset = handles.finalDataset;
    intervalTop = str2double(get(handles.interval_top_editText, 'String'));
    intervalBottom = str2double(get(handles.interval_bottom_editText, 'String'));    
    centroidsNo = str2num(get(handles.centroids_no_editText, 'String'));
    centroidsSelectionType = get(get(handles.centroid_select_meth_buttonGroup, 'SelectedObject'), 'tag');
    handles.centroidSelectMethod = centroidsSelectionType;
    switch centroidsSelectionType
        case 'random_radioButton'
            if get(handles.normalize_data_checkBox, 'value') == 1 && nargin > 3
                gCentroids = normalizeDataSet(rand(centroidsNo, 3), intervalTop, intervalBottom, 1);
            elseif nargin < 4
                gCentroids = normalizeDataSet(rand(centroidsNo, 3), max(max(finalDataset(:, 1:3))), ...
                    min(min(finalDataset(:, 1:3))), 1);
            end
            plotDataCentroids(finalDataset, gCentroids, 1, hObject, handles);
            handles.kMeansCostFunc = zeros(1);
        case 'data_sample_radioButton'
            gCentroids = datasample(finalDataset(:, 1:3), centroidsNo);
            plotDataCentroids(finalDataset, gCentroids, 1, hObject, handles);
            handles.kMeansCostFunc = zeros(1);
        case 'k_means_radioButton'
            set(handles.start_pushButton, 'Enable', 'off');
            trainPercentage = str2num(get(handles.train_size_perce_editText, 'String'));
            trainIndex = floor(.01 .* trainPercentage .* 800);
            [kMeansCentroids, costFunc, iterNo] = kMeans(finalDataset([1:trainIndex 801:800+trainIndex 1601:1600+trainIndex 2401:2400+trainIndex], ...
                1:3), centroidsNo, hObject, handles);
            handles.kMeansCostFunc = costFunc(1:iterNo);
            gCentroids = kMeansCentroids(:, :, iterNo);
            plotDataCentroids(finalDataset, kMeansCentroids(:, :, 1:iterNo), iterNo, hObject, handles);
            set(handles.start_pushButton, 'Enable', 'on');            
    end
    guidata(hObject, handles);

function beta2_param_editText_Callback(hObject, eventdata, handles)

function beta2_param_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function beta3_param_editText_Callback(hObject, eventdata, handles)

function beta3_param_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_Callback(hObject, eventdata, handles)

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit13_Callback(hObject, eventdata, handles)

function total_samples_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)

function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_Callback(hObject, eventdata, handles)

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_Callback(hObject, eventdata, handles)

function wrongly_classified_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_Callback(hObject, eventdata, handles)

function correctly_classified_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit18_Callback(hObject, eventdata, handles)

function classification_error_perc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function centroids_no_editText_KeyPressFcn(hObject, eventdata, handles)

function save_net_pushButton_Callback(hObject, eventdata, handles)
global gCentroids;
sourceDataset = handles.finalDataset;
centroidsForSave = gCentroids;
isNormalized = handles.isNormalized;
intervalTop = handles.intervalTop;
intervalBottom = handles.intervalBottom;
centroidSelectMethod = handles.centroidSelectMethod;
RBFfuncType = handles.RBFfuncType;
weightUpdateMethod = handles.weightUpdateMethod;
isBias = handles.isBias;
lambdaParam = handles.lambdaParam;
trainSizePerc = handles.trainSizePerc;
evalSizePerc = handles.evalSizePerc;
centroidsNo = size(centroidsForSave, 1);
isBeta = handles.isBeta;
betaParams = handles.betaParams;
weightMatrix = handles.finalWeightMatrix;
RLSerrorTrain = handles.RLSerrorTrain;
RLSerrorEval = handles.RLSerrorEval;
kMeansCostFunc = handles.kMeansCostFunc;
testClassificationResults = handles.testClassificationResults;
uisave({'sourceDataset', 'centroidsForSave', 'isNormalized', 'intervalTop', 'intervalBottom', 'centroidSelectMethod', 'RBFfuncType', ...
    'weightUpdateMethod', 'isBias', 'lambdaParam', 'trainSizePerc', 'evalSizePerc', 'centroidsNo', 'isBeta', 'betaParams', ...
    'weightMatrix', 'RLSerrorTrain', 'RLSerrorEval', 'kMeansCostFunc', 'testClassificationResults'}, 'oldNet.mat');
guidata(hObject, handles);

function load_net_pushButton_Callback(hObject, eventdata, handles)
    global gCentroids;
    [FileName,PathName] = uigetfile('*.mat', 'Select the saved network', 'oldNet.mat');
    if ~FileName 
        h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
    else
        oldNet = importdata([PathName FileName]);
        
        sourceDataset = oldNet.sourceDataset;
        handles.finalDataset = sourceDataset;
        centroidsForSave = oldNet.centroidsForSave;
        gCentroids = centroidsForSave;
        handles.isNormalized = oldNet.isNormalized;
        intervalTop = oldNet.intervalTop;
        handles.intervalTop = intervalTop;
        intervalBottom = oldNet.intervalBottom;
        handles.intervalBottom = intervalBottom;
        centroidSelectMethod = oldNet.centroidSelectMethod;
        RBFfuncType = oldNet.RBFfuncType;
        handles.RBFfuncType = RBFfuncType;
        weightUpdateMethod = oldNet.weightUpdateMethod;
        isBias = oldNet.isBias;
        handles.isBias = isBias;
        lambdaParam = oldNet.lambdaParam;
        trainSizePerc = oldNet.trainSizePerc;
        evalSizePerc = oldNet.evalSizePerc;
        centroidsNo = size(centroidsForSave, 1);
        isBeta = oldNet.isBeta;
        handles.isBeta = isBeta;
        betaParams = oldNet.betaParams;
        handles.betaParams = betaParams;
        handles.finalWeightMatrix = oldNet.weightMatrix;
        RLSerrorTrain = oldNet.RLSerrorTrain;
        RLSerrorEval = oldNet.RLSerrorEval;
        kMeansCostFunc = oldNet.kMeansCostFunc;
        testClassificationResults = oldNet.testClassificationResults;
        
        plotDataCentroids(sourceDataset, centroidsForSave, 1, hObject, handles);
        if handles.isNormalized
            set(handles.normalize_data_checkBox, 'Value', 1);
            set(handles.interval_top_editText, 'String', num2str(intervalTop));
            set(handles.interval_bottom_editText, 'String', num2str(intervalBottom));
        else
            set(handles.normalize_data_checkBox, 'Value', 0);
            set(handles.interval_top_editText, 'Enable', 'off');
            set(handles.interval_bottom_editText, 'Enable', 'off');
        end
        switch centroidSelectMethod
            case 'random_radioButton'
                set(handles.random_radioButton, 'Value', 1);
            case 'data_sample_radioButton'
                set(handles.data_sample_radioButton, 'Value', 1);
            case 'k_means_radioButton'
                set(handles.k_means_radioButton, 'Value', 1);
        end
        switch RBFfuncType
            case 'multiquad_radioButton'
                set(handles.multiquad_radioButton, 'Value', 1);
            case 'inv_multiquad_radioButton'
                set(handles.inv_multiquad_radioButton, 'Value', 1);
            case 'gaussian_func_radioButton'
                set(handles.gaussian_func_radioButton, 'Value', 1);
            case 'logarithm_func_radioButton'
                set(handles.logarithm_func_radioButton, 'Value', 1);
        end
        switch weightUpdateMethod
            case 'basic_rbf_method_radioButon'
                set(handles.basic_rbf_method_radioButon, 'Value', 1);
                cla(handles.axes2);
                cla(handles.axes3);
                cla(handles.axes4);
                set(handles.final_train_error_perc_editText, 'String', '');
                set(handles.final_eval_error_perc_editText, 'String', '');
                set(handles.cost_func_value_editText, 'String', '');
                set(handles.plot_weight_oscillation_pushButton, 'Enable', 'off');
            case 'rls_method_radioButton'
                set(handles.plot_weight_oscillation_pushButton, 'Enable', 'on');
                set(handles.rls_method_radioButton, 'Value', 1);
                set(handles.lambda_editText, 'String', num2str(lambdaParam));
                cla(handles.axes3);
                cla(handles.axes4);
                axes(handles.axes3);
                plot(RLSerrorTrain(1, 1:end), 'r');
                hold on;
                plot(RLSerrorTrain(2, 1:end) .* 100, 'g');
                plot(RLSerrorEval(1, 1:end), 'b');
                plot(RLSerrorEval(2, 1:end) * 100, 'k');
                legend('TrainError(%)', 'TrainError(MSE)', 'EvalError(%)', 'EvalError(MSE)');
                grid on;
                hold off;
        end
        if isBias
            set(handles.is_bias_checkBox, 'Value', 1);
        else
            set(handles.is_bias_checkBox, 'Value', 0);
        end
        set(handles.train_size_perce_editText, 'String', num2str(trainSizePerc));
        set(handles.eval_size_perce_editText, 'String', num2str(evalSizePerc));
        set(handles.centroids_no_editText, 'String', num2str(centroidsNo));
        if isBeta
            set(handles.beta_param_checkBox, 'Value', 1);
            set(handles.beta1_param_editText, 'String', num2str(betaParams(1)));
            set(handles.beta2_param_editText, 'String', num2str(betaParams(2)));
            set(handles.beta3_param_editText, 'String', num2str(betaParams(3)));
        else
            set(handles.beta_param_checkBox, 'Value', 0);
            set(handles.beta1_param_editText, 'Enable', 'off');
            set(handles.beta2_param_editText, 'Enable', 'off');
            set(handles.beta3_param_editText, 'Enable', 'off');
        end
        axes(handles.axes4);
        plot(kMeansCostFunc(1:end), '-r');
        grid on;
        set(handles.final_train_error_mse_editText, 'String', num2str(RLSerrorTrain(1, end)));
        set(handles.final_train_error_perc_editText, 'String', num2str(RLSerrorTrain(2, end) .* 100));
        set(handles.final_eval_error_mse_editText, 'String', num2str(RLSerrorEval(1, end)));
        set(handles.final_eval_error_perc_editText, 'String', num2str(RLSerrorEval(2, end) .* 100));
        set(handles.cost_func_value_editText, 'String', num2str(kMeansCostFunc(end)));
        set(handles.total_samples_editText, 'String', num2str(testClassificationResults(1)));
        set(handles.wrongly_classified_editText, 'String', num2str(testClassificationResults(2)));
        set(handles.correctly_classified, 'String', num2str(testClassificationResults(3)));
        set(handles.classification_error_mse, 'String', num2str(testClassificationResults(4)));
        set(handles.classification_error_perc, 'String', num2str(testClassificationResults(5) .* 100));
        
        h = msgbox('File was loaded successfully!','Success');
    end
    guidata(hObject, handles);

function source_node_editText_Callback(hObject, eventdata, handles)

function source_node_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dest_node_editText_Callback(hObject, eventdata, handles)

function dest_node_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function plot_weight_oscillation_pushButton_Callback(hObject, eventdata, handles)
weightMatrix = handles.finalWeightMatrix;
sourceNode = str2num(get(handles.source_node_editText, 'String'));
destNode = str2num(get(handles.dest_node_editText, 'String'));
axes(handles.axes2);
plot(squeeze(weightMatrix(sourceNode, destNode, :)), 'color', rand(1, 3));
hold on;
grid on;
guidata(hObject, handles);

function is_bias_checkBox_Callback(hObject, eventdata, handles)

function clear_weight_axes_pushButton_Callback(hObject, eventdata, handles)
axes(handles.axes2);
cla(handles.axes2);
guidata(hObject, handles);

function test_net_pushButton_Callback(hObject, eventdata, handles)
global gCentroids;
[testFileName, testPathName] = uigetfile('*.txt', 'Select the test dataset', 'Data.txt');
if ~testFileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    testDataset = sortrows(load([testPathName testFileName]), 4);
    h = msgbox('File was loaded successfully!','Success');
    isNormalized = handles.isNormalized;
    intervalTop = handles.intervalTop;
    intervalBottom = handles.intervalBottom;
    RBFfuncType = handles.RBFfuncType;
    isBias = handles.isBias;
    isBeta = handles.isBeta;
    betaParams = handles.betaParams;
    cetroidsForTest = gCentroids;
    weightMatrix = handles.finalWeightMatrix;
    
    testSortedTags = testDataset(:, 4);

    testTargetValues = zeros(size(testDataset, 1), 4);
    testTargetValues((testSortedTags == 0), 1) = 1;
    testTargetValues((testSortedTags == 1), 2) = 1;
    testTargetValues((testSortedTags == 2), 3) = 1;
    testTargetValues((testSortedTags == 3), 4) = 1;
    
    if isNormalized
        normalizeDataSet(testDataset(:, 1:3), intervalTop, intervalBottom, 1);
    end
    
    centroidsNo = size(cetroidsForTest, 1);

    sigma = max(pdist(cetroidsForTest)) ./ sqrt(2 .* centroidsNo);

    testFeatures = zeros(size(testDataset(:, 1:3), 1), size(testDataset(:, 1:3), 2), centroidsNo);
    testCentroidsMatrix = zeros(size(testDataset(:, 1:3), 1), size(testDataset(:, 1:3), 2), centroidsNo);
    for ii = 1:centroidsNo
        testFeatures(:, :, ii) = testDataset(:, 1:3);
        testCentroidsMatrix(:, :, ii) = ones(size(testDataset(:, 1:3), 1), 1) * cetroidsForTest(ii, :);
    end

    if isBeta
        beta1 = betaParams(1);
        beta2 = betaParams(2);
        beta3 = betaParams(3);
        betaMat = ones(size(testDataset(:, 1:3), 1), 1) * [beta1 beta2 beta3];
        betaMatrix = zeros(size(testDataset(:, 1:3), 1), size(testDataset(:, 1:3), 2), centroidsNo);
        for ll = 1:centroidsNo
            betaMatrix(:, :, ll) = betaMat;
        end
        testDistMatrix = squeeze(sqrt(sum((((testFeatures - testCentroidsMatrix) ./ betaMatrix) .^ 2), 2)));
    else
        testDistMatrix = squeeze(sqrt(sum(((testFeatures - testCentroidsMatrix) .^ 2), 2)));
    end

    if isBias == 1
        testPhiOutput = [phiFunc(testDistMatrix, sigma, RBFfuncType) ones(size(testDistMatrix, 1), 1)];
    else
        testPhiOutput = phiFunc(testDistMatrix, sigma, RBFfuncType);
    end
    
    [testMisClassified, testCorrectlyClassified, testClassificationError] = rbfTest(testPhiOutput, testTargetValues, ...
        weightMatrix(:, :, end));
    handles.testClassificationResults = [testMisClassified + testCorrectlyClassified, testMisClassified, testCorrectlyClassified, transpose(testClassificationError)];
    set(handles.total_samples_editText, 'String', num2str(testMisClassified + testCorrectlyClassified));
    set(handles.wrongly_classified_editText, 'String', num2str(testMisClassified));
    set(handles.correctly_classified, 'String', num2str(testCorrectlyClassified));
    set(handles.classification_error_mse, 'String', num2str(testClassificationError(1)));
    set(handles.classification_error_perc, 'String', num2str(testClassificationError(2) .* 100));
end
guidata(hObject, handles);

function load_data_pushButton_KeyPressFcn(hObject, eventdata, handles)

function classification_error_mse_CreateFcn(hObject, eventdata, handles)

% function save_fig_pushButton_Callback(hObject, eventdata, handles)
% [figName, figPath] = uiputfile('*.jpg','Save RLS Errors', 'rlsErrors.jpg');
% if ~FileName 
%     h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
% else
%     h = msgbox('File was loaded successfully!','Success');
%     rlsErrors = getframe(handles.axes4);
%     rlsErrorsImage = frame2im(rlsErrors);
%     imwrite(rlsErrorsImage, [figPath figName]);
% end
% guidata(hObject, handles);
