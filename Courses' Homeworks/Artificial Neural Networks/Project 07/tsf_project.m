function varargout = tsf_project(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tsf_project_OpeningFcn, ...
                   'gui_OutputFcn',  @tsf_project_OutputFcn, ...
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

function tsf_project_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

hiddenLayerUnitNo = str2num(get(handles.hidden_layer_unitNo_editText, 'String'));
archType = strcat('1+', num2str(hiddenLayerUnitNo), '--', num2str(hiddenLayerUnitNo), '--1');
set(handles.arch_type_staticText, 'String', archType);

guidata(hObject, handles);

function varargout = tsf_project_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function load_data_pushButton_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile('*.*', 'Select the Input File', 'synthetic');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    tsfData = load([PathName FileName]);
    handles.tsfData = tsfData(2:end, :);
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);

function start_pushButton_Callback(hObject, eventdata, handles)
tsfData = handles.tsfData;
hiddenLayerUnitNo = str2num(get(handles.hidden_layer_unitNo_editText, 'String'));
weightingFactor = str2num(get(handles.weighting_factor_editText, 'String'));
eta1 = str2num(get(handles.eta1_editText, 'String'));
eta2 = str2num(get(handles.eta2_editText, 'String'));
batchSize = str2num(get(handles.batch_size_editText, 'String'));
lagsNo = str2num(get(handles.lagsNo_editText, 'String'));
seriesSelectedNo = get(handles.series_select_popupMenu, 'Value');
estimateEvalCriterion = get(get(handles.est_eval_crit_buttonGroup, 'SelectedObject'), 'tag');
trainSetSize = 1e4;
testSetSize = 1e4;
validSetSize = 3e3;
seriesSelected = (tsfData(:, seriesSelectedNo) - min(tsfData(:, seriesSelectedNo))) ...
    ./ (max(tsfData(:, seriesSelectedNo)) - min(tsfData(:, seriesSelectedNo)));
actFuncType = get(get(handles.act_func_type_buttonGroup, 'SelectedObject'), 'tag');
switch actFuncType
    case 'binary_sigmoid_radioButton'
        actFunc = @logisticSigmoid;
        actFuncDer = @logisticSigmoidDerivative;
    case 'bipolar_sigmoid_radioButton'
        actFunc = @bipolarSigmoid;
        actFuncDer = @bipolarSigmoidDerivative;
    case 'arc_tangent_radioButton'
        actFunc = @arcTangent;
        actFuncDer = @arcTangentDerivative;
end
startIndex = 1;
trainSet = seriesSelected(startIndex:trainSetSize);
testSet = seriesSelected(trainSetSize+1:trainSetSize+testSetSize);
validSet = seriesSelected(trainSetSize+testSetSize+1:trainSetSize+testSetSize+validSetSize);
weightsHidden = zeros(1, hiddenLayerUnitNo, trainSetSize);
weightsContext = zeros(hiddenLayerUnitNo, hiddenLayerUnitNo, trainSetSize);
weightsOutput = zeros(hiddenLayerUnitNo, 1, trainSetSize);
weightsHidden(:, :, 1) = rand(1, hiddenLayerUnitNo);
weightsContext(:, :, 1) = rand(hiddenLayerUnitNo, hiddenLayerUnitNo);
weightsOutput(:, :, 2) = rand(hiddenLayerUnitNo, 1);
hiddenInputs = zeros(1, hiddenLayerUnitNo);
hiddenOutputs = rand(1, hiddenLayerUnitNo);
contextInputs = weightingFactor .* hiddenOutputs;
outputZ = zeros(trainSetSize, 1);
pi = zeros(1, hiddenLayerUnitNo);

weightsHiddenDelta = 0;
weightsContextDelta = 0;
weightsOutputDelta = 0;

errorMSEtrain = [];
errorMAEtrain = [];
errorRMAEtrain = [];
errorPItrain = [];

errorMSEvalid = [];
errorMAEvalid = [];
errorRMAEvalid = [];
errorPIvalid = [];

axes(handles.axes1);
cla(handles.axes1);
axes(handles.axes2);
cla(handles.axes2);
axes(handles.axes3);
cla(handles.axes3);

axes(handles.axes1);
plot(trainSet, 'Color', 'red', 'LineWidth', 2);
hold on;
grid on;

for c1 = 1:trainSetSize-lagsNo
    isBreak = get(handles.break_opt_checkBox, 'Value');
    if isBreak
        set(handles.break_opt_checkBox, 'Value', 0);
        break;
    end
    hiddenOutputsTmp = hiddenOutputs;
    hiddenInputs = outputZ(c1) * weightsHidden(:, :, c1) + contextInputs * weightsContext(:, :, c1);
    hiddenOutputs = actFunc(hiddenInputs);
    contextInputs = weightingFactor .* hiddenOutputs;
    outputIn = hiddenOutputs * weightsOutput(:, :, c1+1);
    outputZ(c1+lagsNo) = actFunc(outputIn);
    PP = outputZ(c1+lagsNo).*(1 - outputZ(c1+lagsNo)) .* (outputZ(c1+lagsNo) - trainSet(c1+lagsNo));
%     outputZ(c1) = actFunc(outputIn);
%     PP = outputZ(c1).*(1 - outputZ(c1)) .* (outputZ(c1) - trainSet(c1));
    pi = actFuncDer(hiddenInputs) .* (hiddenOutputsTmp + pi * weightsContext(:, :, c1));
    weightsHiddenDelta = weightsHiddenDelta - eta2 .* PP .* weightsOutput(:, :, c1+1)' .* actFuncDer(hiddenInputs) .* ...
        outputZ(c1); 
    weightsContextDelta = weightsContextDelta - eta2 .* PP .* (weightsOutput(:, :, c1+1) * pi);
    weightsOutputDelta = weightsOutputDelta - eta1 .* PP .* transpose(hiddenInputs);

    if rem(c1, batchSize)==0 || c1==trainSetSize-lagsNo
        weightsHidden(:, :, c1+1) = weightsHidden(:, :, c1) + weightsHiddenDelta;
        weightsContext(:, :, c1+1) = weightsContext(:, :, c1) + weightsContextDelta;
        weightsOutput(:, :, c1+2) = weightsOutput(:, :, c1+1) + weightsOutputDelta;
        weightsHiddenDelta = 0;
        weightsContextDelta = 0;
        weightsOutputDelta = 0;
        outputZvalid = seriesValidation(validSet, validSetSize, contextInputs, weightsHidden(:, :, c1+1), ...
            weightsContext(:, :, c1+1), weightsOutput(:, :, c1+2), actFunc);
    else
        weightsHidden(:, :, c1+1) = weightsHidden(:, :, c1);
        weightsContext(:, :, c1+1) = weightsContext(:, :, c1);
        weightsOutput(:, :, c1+2) = weightsOutput(:, :, c1+1);
        outputZvalid = seriesValidation(validSet, validSetSize, contextInputs, weightsHidden(:, :, c1+1), ...
            weightsContext(:, :, c1+1), weightsOutput(:, :, c1+2), actFunc);
    end
    
    errorMSEtrain = [errorMSEtrain (1/(c1+lagsNo))*sum((trainSet(1:c1+lagsNo) - outputZ(1:c1+lagsNo)) .^ 2)];
    errorMAEtrain = [errorMAEtrain (1/(c1+lagsNo))*sum(abs(trainSet(1:c1+lagsNo) - outputZ(1:c1+lagsNo)))];
    errorRMAEtrain = [errorRMAEtrain (1/(mean(trainSet(1:c1+lagsNo))))*errorMAEtrain(end)];
    errorPItrain = [errorPItrain 1-((c1+lagsNo)*errorMSEtrain(end))/(sum((trainSet(2:c1+lagsNo) - ...
        trainSet(1:c1+lagsNo-1)) .^ 2))];
    
    errorMSEvalid = [errorMSEvalid (1/validSetSize)*sum((validSet - outputZvalid) .^ 2)];
    errorMAEvalid = [errorMAEvalid (1/validSetSize)*sum(abs(validSet - outputZvalid))];
    errorRMAEvalid = [errorRMAEvalid (1/mean(validSet))*errorMAEvalid(end)];
    errorPIvalid = [errorPIvalid 1-(validSetSize*errorMSEvalid(end))/(sum((validSet(2:end) - ...
        validSet(1:end-1)) .^ 2))];
    
    if rem(c1, 100)==0 || c1==trainSetSize-lagsNo
        axes(handles.axes1);
        plot(outputZ(1:c1+lagsNo), 'Color', 'k');
        grid on;
        axes(handles.axes2);
        switch estimateEvalCriterion
            case 'mse_radioButton'
                plot(errorMSEtrain, 'Color', 'red');
                hold on;
                plot(errorMSEvalid, 'Color', 'magenta');
                grid on;
            case 'mae_radioButton'
                plot(errorMAEtrain, 'Color', 'red');
                hold on;
                plot(errorMAEvalid, 'Color', 'magenta');
                grid on;
            case 'rmae_radioButton'
                plot(errorRMAEtrain, 'Color', 'red');
                hold on;
                plot(errorRMAEvalid, 'Color', 'magenta');
                grid on;
            case 'pi_radioButton'
                plot(errorPItrain, 'Color', 'red');
                hold on;
                plot(errorPIvalid, 'Color', 'magenta');
                grid on;
        end
        axes(handles.axes3);
        X = squeeze(weightsOutput);     
%         surf(X, 'facecolor', [.5 .5 .5]);
%         colormap(parula(5));
        if size(X, 1)~=1 && size(X, 2)~=1
            C = rand(1, 3);
            C1 = rand(1, 3);
            surf(X, C, 'facecolor', C, 'edgecolor', C1, 'facelighting', 'phong');
        else
            plot(X(1:c1+2), 'Color', [.13 .37 .66], 'LineWidth', 1.5);
            xlim([0 1e4]);
            grid on;
        end
        pause(.001);
    end
end

legend(handles.axes1, 'Target Value', 'Estimated Value');
legend(handles.axes2, 'Training Error', 'Validation Error');

seriesTesting(hObject, handles, testSet, testSetSize, contextInputs, weightsHidden(:, :, c1+1), weightsContext(:, :, c1+1), ...
    weightsOutput(:, :, c1+2), actFunc, estimateEvalCriterion);

trainErrors = struct('errorMSEtrain', errorMSEtrain, 'errorMAEtrain', errorMAEtrain, 'errorRMAEtrain', errorRMAEtrain, 'errorPItrain', errorPItrain);
validErrors = struct('errorMSEvalid', errorMSEvalid, 'errorMAEvalid', errorMAEvalid, 'errorRMAEvalid', errorRMAEvalid, 'errorPIvalid', errorPIvalid);
handles.ElmanNet = struct('hiddenLayerUnitNo', hiddenLayerUnitNo, 'weightingFactor', weightingFactor, 'eta1', eta1, 'eta2', eta2, ...
    'batchSize', batchSize, 'lagsNo', lagsNo, 'seriesSelectedNo', seriesSelectedNo, 'estimateEvalCriterion', estimateEvalCriterion, ...
    'actFuncType', actFuncType, 'seriesSelected', seriesSelected, 'trainSet', trainSet, 'outputZ', outputZ, 'trainErrors', trainErrors, ...
    'validErrors', validErrors, 'contextInputs', contextInputs, 'weightsHidden', weightsHidden, 'weightsContext', weightsContext, ...
    'weightsOutput', weightsOutput);

h = msgbox('The training procedure was carried out successfully!', 'Success');
guidata(hObject, handles);

function hidden_layer_unitNo_editText_Callback(hObject, eventdata, handles)
hiddenLayerUnitNo = str2num(get(handles.hidden_layer_unitNo_editText, 'String'));
archType = strcat('1+', num2str(hiddenLayerUnitNo), '--', num2str(hiddenLayerUnitNo), '--1');
set(handles.arch_type_staticText, 'String', archType);
guidata(hObject, handles);

function hidden_layer_unitNo_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function weighting_factor_editText_Callback(hObject, eventdata, handles)

function weighting_factor_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eta1_editText_Callback(hObject, eventdata, handles)

function eta1_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function eta2_editText_Callback(hObject, eventdata, handles)

function eta2_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function batch_size_editText_Callback(hObject, eventdata, handles)

function batch_size_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lagsNo_editText_Callback(hObject, eventdata, handles)

function lagsNo_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function series_select_popupMenu_Callback(hObject, eventdata, handles)

function series_select_popupMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton5_Callback(hObject, eventdata, handles)

function radiobutton6_Callback(hObject, eventdata, handles)

function radiobutton7_Callback(hObject, eventdata, handles)

function radiobutton8_Callback(hObject, eventdata, handles)

function break_opt_checkBox_Callback(hObject, eventdata, handles)

function test_error_editText_CreateFcn(hObject, eventdata, handles)

function load_net_pushButton_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile('*.mat', 'Select the saved Elman network', 'ElmanNet01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    handles.ElmanNet = importdata([PathName FileName]);
    setParams(hObject, handles, handles.ElmanNet);
    h = msgbox('File was loaded successfully and a test has been applied!','Success');
end
guidata(hObject, handles);

function save_net_pushButton_Callback(hObject, eventdata, handles)
ElmanNet = handles.ElmanNet;
uisave({'ElmanNet'}, 'ElmanNet01.mat');
guidata(hObject, handles);
