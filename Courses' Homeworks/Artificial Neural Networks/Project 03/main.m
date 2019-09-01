function varargout = main(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function interval_top_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function interval_bottom_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function training_percentage_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function evaluation_percentage_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function validation_min_error_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function batch_size_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function max_epoch_editText_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function hidden_layers_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function momentum_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function learning_rate_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function normalization_method_buttonGroup_CreateFcn(hObject, eventdata, handles)

function activation_function_buttonGroup_CreateFcn(hObject, eventdata, handles)

function is_widrow_checkbox_CreateFcn(hObject, eventdata, handles)

function is_momentum_checkbox_CreateFcn(hObject, eventdata, handles)

function is_widrow_checkBox_Callback(hObject, eventdata, handles)

function is_momentum_checkbox_Callback(hObject, eventdata, handles)

function momentum_editText_Callback(hObject, eventdata, handles)

function learning_rate_editText_Callback(hObject, eventdata, handles)

function hidden_layers_editText_Callback(hObject, eventdata, handles)

function interval_top_editText_Callback(hObject, eventdata, handles)

function interval_bottom_editText_Callback(hObject, eventdata, handles)

function nm_global_radioButton_Callback(hObject, eventdata, handles)

function nm_vectorial_radioButton_Callback(hObject, eventdata, handles)

function logistic_sigmoid_function_radioButton_Callback(hObject, eventdata, handles)

function bipolar_sigmoid_function_radioButton_Callback(hObject, eventdata, handles)

function arctangent_function_radioButton_Callback(hObject, eventdata, handles)

function logarithm_function_radioButton_Callback(hObject, eventdata, handles)

function is_shuffled_checkbox_Callback(hObject, eventdata, handles)

function training_percentage_editText_Callback(hObject, eventdata, handles)

function evaluation_percentage_editText_Callback(hObject, eventdata, handles)

function validation_min_error_editText_Callback(hObject, eventdata, handles)

function batch_size_editText_Callback(hObject, eventdata, handles)

function max_epoch_editText_Callback(hObject, eventdata, handles)

function load_dataset_pushbutton_Callback(hObject, eventdata, handles)
    [FileName,PathName] = uigetfile('*.csv', 'Select the Input File', 'slice_localization_data.csv');
    handles.dataSet = csvread([PathName FileName], 1, 1);
    guidata(hObject,handles);

% --- Executes on button press in start_pushbutton.
function start_pushbutton_Callback(hObject, eventdata, handles)                
    cla(handles.axes1, 'reset');
    cla(handles.axes2, 'reset');
    set(handles.test_samples_total_no_editText, 'string', '');
    set(handles.correctly_classified_editText, 'string', '');
    set(handles.wrongly_classified_editText, 'string', '');
    set(handles.classification_errors_editText, 'string', '');
    
    data = handles.dataSet;
    features = data(:, 1:384);
    tags = data(:, 385);
    
    b(1) = get(handles.nm_global_radioButton, 'value');
    b(2) = get(handles.nm_vectorial_radioButton, 'value');
    highInterval = str2double(get(handles.interval_top_editText, 'string'));
    lowInterval = str2double(get(handles.interval_bottom_editText, 'string'));
    if b(1)
        normMethod = 0;
    elseif b(2)
        normMethod = 1;
    end
    normalizedFeatures = normalizeDataSet(features, highInterval, lowInterval, normMethod);
    
    minTags = min(tags);
    maxTags = max(tags);
    normDenomTags = maxTags - minTags;
    normalizedTags = (tags - minTags) ./ normDenomTags;
    
    trainPercentage = str2double(get(handles.training_percentage_editText, 'string'));
    validPercentage = str2double(get(handles.evaluation_percentage_editText, 'string'));
    trainIndex = floor(.01 * trainPercentage * size(features, 1));
    validIndex = trainIndex + floor(.01 * validPercentage * size(features, 1));

    isShuffled = get(handles.is_shuffled_checkbox, 'value');
    
    if isShuffled
        indicesPerm = randperm(size(features, 1));
        shuffledNormFeatures = normalizedFeatures(indicesPerm, :);
        shuffledNormTags = normalizedTags(indicesPerm, :);
        trainDataset = shuffledNormFeatures(1:trainIndex, :);
        trainTags = shuffledNormTags(1:trainIndex, :);
        validDataset = shuffledNormFeatures(trainIndex + 1:validIndex, :);
        validTags = shuffledNormTags(trainIndex + 1:validIndex, :);
        testDataset = shuffledNormFeatures(validIndex + 1:end, :);
        testTags = shuffledNormTags(validIndex + 1:end, :);
    else
        trainDataset = normalizedFeatures(1:trainIndex, :);
        trainTags = normalizedTags(1:trainIndex, :);
        validDataset = normalizedFeatures(trainIndex + 1:validIndex, :);
        validTags = normalizedTags(trainIndex + 1:validIndex, :);
        testDataset = normalizedFeatures(validIndex + 1:end, :);
        testTags = normalizedTags(validIndex + 1:end, :);
    end
    
    set(handles.test_samples_total_no_editText, 'string', num2str(size(testDataset, 1)));
    
    c(1) = get(handles.logistic_sigmoid_function_radioButton, 'value');
    c(2) = get(handles.bipolar_sigmoid_function_radioButton, 'value');
    c(3) = get(handles.arctangent_function_radioButton, 'value');
    c(4) = get(handles.logarithm_function_radioButton, 'value');
    if b(1)
        activationFunction = @logisticSigmoid;
        activationFunctionDerivative = @logisticSigmoidDerivative;
    elseif b(2)
        activationFunction = @bipolarSigmoid;
        activationFunctionDerivative = @bipolarSigmoidDerivative;
        normalizedTags = normalizedTags .* 2 - 1;
    elseif b(3)
        activationFunction = @arcTangent;
        activationFunctionDerivative = @arcTangentDerivative;
        normalizedTags = normalizedTags .* 2 - 1;
    elseif b(4)
        activationFunction = @logFunction;
        activationFunctionDerivative = @logFunctionDerivative;
        normalizedTags = normalizedTags .* 2 - 1;
    end
    
    validError = str2double(get(handles.validation_min_error_editText, 'string')); 
    
    % Choose form of MLP:
    hiddenLayersArray = str2num(get(handles.hidden_layers_editText, 'string'));
    layersNeuronNo = [384, hiddenLayersArray, 1];
    hiddenLayersNo = size(layersNeuronNo, 2) - 2;
    maxLayersNeuronNo = max(layersNeuronNo);

    % Choose appropriate parameters.
    learningRate = str2double(get(handles.learning_rate_editText, 'string'));
    
    isMomentum = get(handles.is_momentum_checkbox, 'value');
    if isMomentum
        momentum = str2double(get(handles.momentum_editText, 'string'));
    end
    
    isWidrow = get(handles.is_widrow_checkBox, 'value');
    
    batchSize = str2num(get(handles.batch_size_editText, 'string'));
    maxEpochs = str2num(get(handles.max_epoch_editText, 'string'));
    
    weightPlottingSrcNode = str2num(get(handles.source_neuron_editText, 'string'));
    weightPlottingDestNode = str2num(get(handles.destination_neuron_editText, 'string'));
    weightPlottingHiddOutpLayNo = str2num(get(handles.hidden_output_layer_no_editText, 'string'));
    
    [weightMatrix] = functionFitnessTrain(activationFunction, activationFunctionDerivative, ...
        layersNeuronNo, trainDataset, trainTags, validDataset, validTags, validError, maxEpochs, batchSize, ...
        learningRate, momentum, isMomentum, isWidrow, weightPlottingSrcNode, weightPlottingDestNode,...
        weightPlottingHiddOutpLayNo, hObject, handles);

    [correctlyClassified, classificationErrors, testErrorPercentage] = functionFitnessTest(activationFunction, ...
        weightMatrix, testDataset, testTags, layersNeuronNo);
     
    set(handles.correctly_classified_editText, 'string', num2str(correctlyClassified));
    set(handles.wrongly_classified_editText, 'string', num2str(classificationErrors));
    set(handles.classification_errors_editText, 'string', num2str(testErrorPercentage .* 100));

    
%     fprintf('Classification errors: %d\n', classificationErrors);
%     fprintf('Correctly classified: %d\n', correctlyClassified);
%     fprintf('Test error percentage is: %0.5f\n', testErrorPercentage);
    guidata(hObject, handles);
    



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to test_samples_total_no_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of test_samples_total_no_editText as text
%        str2double(get(hObject,'String')) returns contents of test_samples_total_no_editText as a double


% --- Executes during object creation, after setting all properties.
function test_samples_total_no_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to test_samples_total_no_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to correctly_classified_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of correctly_classified_editText as text
%        str2double(get(hObject,'String')) returns contents of correctly_classified_editText as a double


% --- Executes during object creation, after setting all properties.
function correctly_classified_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correctly_classified_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to wrongly_classified_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wrongly_classified_editText as text
%        str2double(get(hObject,'String')) returns contents of wrongly_classified_editText as a double


% --- Executes during object creation, after setting all properties.
function wrongly_classified_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wrongly_classified_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to classification_errors_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of classification_errors_editText as text
%        str2double(get(hObject,'String')) returns contents of classification_errors_editText as a double


% --- Executes during object creation, after setting all properties.
function classification_errors_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classification_errors_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function source_neuron_editText_Callback(hObject, eventdata, handles)
% hObject    handle to source_neuron_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of source_neuron_editText as text
%        str2double(get(hObject,'String')) returns contents of source_neuron_editText as a double


% --- Executes during object creation, after setting all properties.
function source_neuron_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source_neuron_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function destination_neuron_editText_Callback(hObject, eventdata, handles)
% hObject    handle to destination_neuron_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of destination_neuron_editText as text
%        str2double(get(hObject,'String')) returns contents of destination_neuron_editText as a double


% --- Executes during object creation, after setting all properties.
function destination_neuron_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to destination_neuron_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hidden_output_layer_no_editText_Callback(hObject, eventdata, handles)
% hObject    handle to hidden_output_layer_no_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hidden_output_layer_no_editText as text
%        str2double(get(hObject,'String')) returns contents of hidden_output_layer_no_editText as a double


% --- Executes during object creation, after setting all properties.
function hidden_output_layer_no_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hidden_output_layer_no_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
