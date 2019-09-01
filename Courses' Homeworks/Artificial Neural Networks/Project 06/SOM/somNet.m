function varargout = somNet(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @somNet_OpeningFcn, ...
                   'gui_OutputFcn',  @somNet_OutputFcn, ...
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

function somNet_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Setting Kohonen dimensions options at the first running
set(handles.one_dim_editText, 'Enable', 'on');
set(handles.two_dim_editText, 'Enable', 'off');
set(handles.three_dim_editText, 'Enable', 'off');
% Setting neighbourhood parameters at the first running
set(handles.zigma_zero_editText, 'Enable', 'off');
set(handles.t1_editText, 'Enable', 'off');
set(handles.eta_zero_editText, 'Enable', 'off');
set(handles.t2_editText, 'Enable', 'off');
guidata(hObject, handles);

function varargout = somNet_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function one_dim_editText_Callback(hObject, eventdata, handles)
neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
guidata(hObject, handles);

function one_dim_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function two_dim_editText_Callback(hObject, eventdata, handles)
neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
guidata(hObject, handles);

function two_dim_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function three_dim_editText_Callback(hObject, eventdata, handles)
neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
guidata(hObject, handles);

function three_dim_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function recognizable_neighb_radioButton_Callback(hObject, eventdata, handles)

function unRecognizable_neighb_radioButton_Callback(hObject, eventdata, handles)

function sigma_zero_editText_Callback(hObject, eventdata, handles)

function zigma_zero_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function t1_editText_Callback(hObject, eventdata, handles)

function t1_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eta_zero_editText_Callback(hObject, eventdata, handles)

function eta_zero_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function t2_editText_Callback(hObject, eventdata, handles)
neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
guidata(hObject, handles);

function t2_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function circle_recog_neighb_opt_radioButton_Callback(hObject, eventdata, handles)

function load_data_pushButton_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile('*.data', 'Select the Input File', 'wine.data');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    handles.somData = load([PathName FileName]);
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function start_pushButton_Callback(hObject, eventdata, handles)
isStandard = get(handles.is_standard_checkBox, 'Value');
trainSizePerc = str2num(get(handles.train_size_editText, 'String'));
testSizePerc = str2num(get(handles.test_size_editText, 'String'));
somData = handles.somData;
trainSetInd = randperm(size(somData, 1), floor(.01.*trainSizePerc.*size(somData, 1)));
testSetInd = randperm(size(somData, 1), floor(.01.*testSizePerc.*size(somData, 1)));
trainSet = somData(trainSetInd, :);
testSet = somData(testSetInd, :);
if isStandard
    trainSetFinal = [trainSet(:, 1) standardizeData(trainSet(:, 2:end))];
    testSetFinal = [testSet(:, 1) standardizeData(testSet(:, 2:end))];
else
    trainSetFinal = trainSet;
    testSetFinal = testSet;
end
handles.somDataSet = struct('trainSetFinal', trainSetFinal(:, 2:end), 'TrainSetClass', trainSetFinal(:, 1), ...
    'testSetFinal', testSetFinal(:, 2:end), 'testSetClass', testSetFinal(:, 1));
% Getting kohonen layer dimensions
kohonenDimOptSelectedObject = get(get(handles.kohonen_dim_buttonGroup, 'SelectedObject'), 'tag');
switch kohonenDimOptSelectedObject
    case 'one_dim_radioButton'
        dim1 = str2num(get(handles.one_dim_editText, 'String'));
        kohonenDims = [dim1];
    case 'two_dim_radioButton'
        dim1 = str2num(get(handles.one_dim_editText, 'String'));
        dim2 = str2num(get(handles.two_dim_editText, 'String'));
        kohonenDims = [dim1 dim2];
    case 'three_dim_radioButton'
        dim1 = str2num(get(handles.one_dim_editText, 'String'));
        dim2 = str2num(get(handles.two_dim_editText, 'String'));
        dim3 = str2num(get(handles.three_dim_editText, 'String'));        
        kohonenDims = [dim1 dim2 dim3];
end
neighbParamsSelectedObject = get(get(handles.neighb_params_buttonGroup, 'SelectedObject'), 'tag');
recognizableOpt = get(get(handles.recognizable_neighb_buttonGroup, 'SelectedObject'), 'tag');
zigma_zero = str2double(get(handles.zigma_zero_editText, 'String'));
t1 = str2double(get(handles.t1_editText, 'String'));
eta_zero = str2double(get(handles.eta_zero_editText, 'String'));
t2 = str2double(get(handles.t2_editText, 'String'));
unRecognizableOpt = struct('zigma_zero', zigma_zero, 't1', t1, 'eta_zero', eta_zero, 't2', t2);
winnerDistType = get(get(handles.winner_dist_type_buttonGroup, 'SelectedObject'), 'tag');
clusterMeasure = str2num(get(handles.cluster_measure_editText, 'String'));
isDesino = get(handles.is_desino_checkBox, 'Value');
desinoBeta = str2double(get(handles.beta_desino_editText, 'String'));
desinoGamma = str2double(get(handles.gamma_desino_editText, 'String'));
desinoParams = struct('isDesino', isDesino, 'desinoBeta', desinoBeta, 'desinoGamma', desinoGamma);
if get(handles.unRecognizable_neighb_radioButton, 'Value') ~= 1
    EPOCH1 = str2num(get(handles.epoch1_editText, 'String'));
else
    EPOCH1 = t2;
end
EPOCH2 = str2num(get(handles.epoch2_editText, 'String'));
kohonenSet = struct('kohonenDims', kohonenDims, 'neighbParamsSelectedObject', neighbParamsSelectedObject, ...
    'recognizableOpt', recognizableOpt, 'unRecognizableOpt', unRecognizableOpt, 'winnerDistType', winnerDistType, ...
    'clusterMeasure', clusterMeasure, 'desinoParams', desinoParams, 'trainSizePerc', trainSizePerc, 'testSizePerc', testSizePerc, ...
    'isStandard', isStandard, 'EPOCH1', EPOCH1, 'EPOCH2', EPOCH2, 'somData', somData);
handles.kohonenOutputs = somTrain(handles.somDataSet, kohonenSet, hObject, handles);
h = msgbox('The training procedure was carried out successfully!', 'Success');
guidata(hObject, handles);

function test_set_size_editText_Callback(hObject, eventdata, handles)

function test_set_size_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function train_set_size_editText_Callback(hObject, eventdata, handles)

function train_set_size_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function one_dim_radioButton_Callback(hObject, eventdata, handles)

function kohonen_dim_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles)
kohonenDimOptSelectedObject = get(get(handles.kohonen_dim_buttonGroup, 'SelectedObject'), 'tag');
switch kohonenDimOptSelectedObject
    case 'one_dim_radioButton'
        set(handles.one_dim_editText, 'Enable', 'on');
        set(handles.two_dim_editText, 'Enable', 'off');
        set(handles.three_dim_editText, 'Enable', 'off');
        neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
    case 'two_dim_radioButton'
        set(handles.one_dim_editText, 'Enable', 'on');
        set(handles.two_dim_editText, 'Enable', 'on');
        set(handles.three_dim_editText, 'Enable', 'off');
        neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
    case 'three_dim_radioButton'
        set(handles.one_dim_editText, 'Enable', 'on');
        set(handles.two_dim_editText, 'Enable', 'on');
        set(handles.three_dim_editText, 'Enable', 'on');
        neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
end
guidata(hObject, handles);

function neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles)
neighbParamsSelectedObject = get(get(handles.neighb_params_buttonGroup, 'SelectedObject'), 'tag');
if ~get(handles.is_desino_checkBox, 'Value')
    switch neighbParamsSelectedObject
        case 'recognizable_neighb_radioButton'
            set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'on');
            set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'on');
            set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'on');        
            set(handles.zigma_zero_editText, 'Enable', 'off');
            set(handles.t1_editText, 'Enable', 'off');
            set(handles.eta_zero_editText, 'Enable', 'off');
            set(handles.t2_editText, 'Enable', 'off');
        case 'unRecognizable_neighb_radioButton'
            set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'off');
            set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'off');
            set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'off');
            set(handles.zigma_zero_editText, 'Enable', 'on');
            set(handles.t1_editText, 'Enable', 'on');
            set(handles.eta_zero_editText, 'Enable', 'on');
            set(handles.t2_editText, 'Enable', 'on');
            kohonenDimOptSelectedObject = get(get(handles.kohonen_dim_buttonGroup, 'SelectedObject'), 'tag');
            switch kohonenDimOptSelectedObject
                case 'one_dim_radioButton'
                    first_dim = str2num(get(handles.one_dim_editText, 'String'));
                    zigma_zero = first_dim ./ 2;
                    set(handles.zigma_zero_editText, 'String', num2str(zigma_zero));
                case 'two_dim_radioButton'
                    first_dim = str2num(get(handles.one_dim_editText, 'String'));
                    second_dim = str2num(get(handles.two_dim_editText, 'String'));
                    zigma_zero = max([first_dim, second_dim]) ./ 2;
                    set(handles.zigma_zero_editText, 'String', num2str(zigma_zero));
                case 'three_dim_radioButton'
                    first_dim = str2num(get(handles.one_dim_editText, 'String'));
                    second_dim = str2num(get(handles.two_dim_editText, 'String'));
                    third_dim = str2num(get(handles.three_dim_editText, 'String'));
                    zigma_zero = max([first_dim, second_dim, third_dim]) ./ 2;
                    set(handles.zigma_zero_editText, 'String', zigma_zero);
            end
            t2 = str2num(get(handles.t2_editText, 'String'));
            set(handles.epoch1_editText, 'String', num2str(t2));
            set(handles.t1_editText, 'String', num2str(ceil(t2 ./ log(zigma_zero))));
    end
end
guidata(hObject, handles);

function kmeans_error_rate_editText_CreateFcn(hObject, eventdata, handles)

function som_error_rate_editText_CreateFcn(hObject, eventdata, handles)

function compare_kmeansVSsom_pushButton_Callback(hObject, eventdata, handles)

function gamma_desino_editText_Callback(hObject, eventdata, handles)

function gamma_desino_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function beta_desino_editText_Callback(hObject, eventdata, handles)

function beta_desino_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function is_desino_checkBox_Callback(hObject, eventdata, handles)
if get(handles.is_desino_checkBox, 'Value')
    set(handles.recognizable_neighb_radioButton, 'Enable', 'off');
    set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'off');
    set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'off');
    set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'off');
    set(handles.unRecognizable_neighb_radioButton, 'Enable', 'off');
    set(handles.zigma_zero_editText, 'Enable', 'off');
    set(handles.t1_editText, 'Enable', 'off');
    set(handles.eta_zero_editText, 'Enable', 'off');
    set(handles.t2_editText, 'Enable', 'off');
else
    set(handles.recognizable_neighb_radioButton, 'Enable', 'on');
    set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'on');
    set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'on');
    set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'on');
    set(handles.unRecognizable_neighb_radioButton, 'Enable', 'on');
    set(handles.zigma_zero_editText, 'Enable', 'on');
    set(handles.t1_editText, 'Enable', 'on');
    set(handles.eta_zero_editText, 'Enable', 'on');
    set(handles.t2_editText, 'Enable', 'on');
    neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
end
guidata(hObject, handles);

function edit14_Callback(hObject, eventdata, handles)

function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit15_Callback(hObject, eventdata, handles)% hObject    handle to edit15 (see GCBO)

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function save_net_pushButton_Callback(hObject, eventdata, handles)
kohonenOutputs = handles.kohonenOutputs;
uisave({'kohonenOutputs'}, 'kohonenOutputs01.mat');
guidata(hObject, handles);

function load_net_pushButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the saved network', 'kohonenOutputs01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    handles.kohonenOutputs = importdata([PathName FileName]);
    setParams(hObject, handles, handles.kohonenOutputs);
    % Considering a test after loading old net
    handles.somData = handles.kohonenOutputs.kohonenSet.somData;
    testSetInd = randperm(size(handles.somData, 1), floor(.5.*size(handles.somData, 1)));
    testSetData = handles.somData(testSetInd, 2:end);
    testSetClass = handles.somData(testSetInd, 1);
    if handles.kohonenOutputs.kohonenSet.isStandard
        testSetData = standardizeData(testSetData);
    end
    kMeansVSsom(testSetData, testSetClass, handles.kohonenOutputs.clusterIndicator, handles.kohonenOutputs.kohonenSet.winnerDistType, ...
        hObject, handles);
    h = msgbox('File was loaded successfully and a test has been applied!','Success');
end
guidata(hObject, handles);

function is_standard_checkBox_Callback(hObject, eventdata, handles)

function winner_neurons_table_CellSelectionCallback(hObject, eventdata, handles)

function epoch1_editText_Callback(hObject, eventdata, handles)
epoch1 = str2num(get(handles.epoch1_editText, 'String'));
set(handles.t2_editText, 'String', num2str(epoch1));
neighb_params_buttonGroup_SelectionChangedFcn(hObject, eventdata, handles);
guidata(hObject, handles);

function epoch1_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function epoch2_editText_Callback(hObject, eventdata, handles)

function epoch2_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function save_umatrix_pushButton_Callback(hObject, eventdata, handles)
U_Matrix = handles.kohonenOutputs.U_Matrix;
uisave({'U_Matrix'}, 'U_Matrix01.mat');
guidata(hObject, handles);

function load_umatrix_pushButon_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the saved u-matrix file', 'U_Matrix01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    U_Matrix = importdata([PathName FileName]);
    axes(handles.axes7);
    imagesc(normalizeDataSet(U_Matrix, 1, 0, 0), 'CDataMapping', 'scaled'); colorbar;
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function save_clust_inf_pushButton_Callback(hObject, eventdata, handles)
groups = handles.kohonenOutputs.groups;
clustersNo = handles.kohonenOutputs.clustersNo;
uisave({'groups', 'clustersNo'}, 'clust_inf01.mat');
guidata(hObject, handles);

function load_clust_inf_pushButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the saved clusters-info file', 'clust_inf01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    clust_inf = importdata([PathName FileName]);
    groups = clust_inf.groups;
    clustersNo = clust_inf.clustersNo;
    axes(handles.axes3);
    bar(groups);
    grid on;
    axes(handles.axes4);
    plot(clustersNo);
    grid on;
    legend(handles.axes3, 'Clusters Bar');
    legend(handles.axes4, 'Clusters Count');
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function save_errDead_pushButton_Callback(hObject, eventdata, handles)
errorMean = handles.kohonenOutputs.errorMean;
deadNeuron = handles.kohonenOutputs.deadNeuron;
uisave({'errorMean', 'deadNeuron'}, 'errDead01.mat');
guidata(hObject, handles);

function load_errDead_pushButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the saved error-deadNeurons file', 'errDead01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    errDead = importdata([PathName FileName]);
    errorMean = errDead.errorMean;
    deadNeuron = errDead.deadNeuron;
    axes(handles.axes1);
    plot(errorMean, '-r');
    grid on;
    axes(handles.axes2);
    plot(deadNeuron, '-k');
    grid on;
    legend(handles.axes1, 'Updating Error Rate');
    legend(handles.axes2, 'Dead Neurons No.');
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function save_winners_pushButton_Callback(hObject, eventdata, handles)
winCounter = handles.kohonenOutputs.winCounter;
uisave({'winCounter'}, 'winCounter01.mat');
guidata(hObject, handles);

function load_winners_pushButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the saved winner-counter table', 'winCounter01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    winCounter = importdata([PathName FileName]);
    set(handles.winner_neurons_table, 'Data', reshape(winCounter, size(winCounter, 1), []));
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function save_weights_pushButton_Callback(hObject, eventdata, handles)
kohonenWeights = handles.kohonenOutputs.kohonenWeights;
uisave({'kohonenWeights'}, 'kohonenWeights01.mat');
guidata(hObject, handles);

function load_weights_pushButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the saved kohonenWeights file', 'kohonenWeights01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    kohonenWeights = importdata([PathName FileName]);
    kohonenWeightsSize = size(kohonenWeights);
    kWeightsReshaped = reshape(kohonenWeights, prod(kohonenWeightsSize(1:end-1)), []);
    inputNo = size(kWeightsReshaped, 1);
    inputLength = size(kWeightsReshaped, 2);
    plotKWeightsDims(hObject, handles, kWeightsReshaped, ...
        inputNo, inputLength);
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function two_dim_radioButton_Callback(hObject, eventdata, handles)
