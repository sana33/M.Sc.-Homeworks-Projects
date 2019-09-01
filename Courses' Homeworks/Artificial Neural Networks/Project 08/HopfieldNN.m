function varargout = HopfieldNN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HopfieldNN_OpeningFcn, ...
                   'gui_OutputFcn',  @HopfieldNN_OutputFcn, ...
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

function HopfieldNN_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

handles.projImages = [];

handles.weightsHebb = 0;

guidata(hObject, handles);

function varargout = HopfieldNN_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function hop_sa_n_editText_Callback(hObject, eventdata, handles)

function hop_sa_n_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hop_sa_t0_editText_Callback(hObject, eventdata, handles)

function hop_sa_t0_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hop_sa_alphaT_editText_Callback(hObject, eventdata, handles)

function hop_sa_alphaT_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function noise_perc_editText_Callback(hObject, eventdata, handles)

function noise_perc_editText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function load_noise_pushButton_Callback(hObject, eventdata, handles)
noisePerc = str2num(get(handles.noise_perc_editText, 'String'));
% set(handles.load_learn_pushButton, 'Enable', 'Off');
[FileName, PathName] = uigetfile('*.bmp', 'Select the image File');
if ~FileName 
    h = msgbox('Sorry! No image was loaded!', 'Failure', 'error');
else
    imageFile = imread([PathName FileName]);
    handles.imageOrig = imageFile;
    imgLogic = islogical(imageFile);
    imageFile = double(imageFile);
    implem_type = get(get(handles.imple_type_buttonGroup, 'SelectedObject'), 'Tag');
    % Converting image to binary format
    if ~imgLogic
        imageFile(imageFile > 0) = 1;
    else
        imageFile(imageFile > 0) = 2;
        imageFile(imageFile == 0) = 1;
        imageFile(imageFile == 2) = 0;
    end
    switch implem_type
        case 'impl_binary_radioButton'
            axes(handles.axes1);
            imshow(imageFile);
            noiseInd = randperm(length(imageFile(:)), floor(.01.*noisePerc.*length(imageFile(:))));
            imgReshaped = imageFile(:);
            imgReshaped(noiseInd) = 1 - imgReshaped(noiseInd);
            handles.imageFile = reshape(imgReshaped ,size(imageFile));
        case 'impl_bipolar_radioButton'
            imageFile(imageFile == 0) = -1;
            axes(handles.axes1);
            imshow(imageFile);
            noiseInd = randperm(length(imageFile(:)), floor(.01.*noisePerc.*length(imageFile(:))));
            imgReshaped = imageFile(:);
            imgReshaped(noiseInd) = -1 .* imgReshaped(noiseInd);
            handles.imageFile = reshape(imgReshaped ,size(imageFile));
    end
    axes(handles.axes5);
    imshow(handles.imageFile);
end
guidata(hObject, handles);

function load_learn_pushButton_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile('*.bmp', 'Select the image File');
if ~FileName 
    h = msgbox('Sorry! No image was loaded!', 'Failure', 'error');
else
    set(handles.hebb_rule_radioButton, 'Enable', 'Off');
    set(handles.proj_rule_radioButton, 'Enable', 'Off');
    set(handles.impl_binary_radioButton, 'Enable', 'Off');
    set(handles.impl_bipolar_radioButton, 'Enable', 'Off');
    imageFile = imread([PathName FileName]);
    imgLogic = islogical(imageFile);
    imageFile = double(imageFile);
    implem_type = get(get(handles.imple_type_buttonGroup, 'SelectedObject'), 'Tag');
    switch implem_type
        case 'impl_binary_radioButton'
            if ~imgLogic
                imageFile(imageFile > 0) = 1;
                handles.imageFile = imageFile;
            else
                imageFile(imageFile > 0) = 2;
                imageFile(imageFile == 0) = 1;
                imageFile(imageFile == 2) = 0;
                handles.imageFile = imageFile;
            end
        case 'impl_bipolar_radioButton'
            if ~imgLogic
                imageFile(imageFile > 0) = 1;
                imageFile(imageFile==0) = -1;
                handles.imageFile = imageFile;
            else
                imageFile(imageFile==0) = 2;
                imageFile(imageFile==1) = -1;
                imageFile(imageFile==2) = 1;
                handles.imageFile = imageFile;
            end
    end
    axes(handles.axes1);
    imshow(imageFile);
    set(handles.hebb_rule_radioButton, 'Enable', 'Off');
    set(handles.proj_rule_radioButton, 'Enable', 'Off');
    set(handles.impl_binary_radioButton, 'Enable', 'Off');
    set(handles.impl_bipolar_radioButton, 'Enable', 'Off');
    learnRule = get(get(handles.learn_rule_buttonGroup, 'SelectedObject'), 'Tag');
    switch learnRule
        case 'hebb_rule_radioButton'
            handles.weightsHebb = handles.weightsHebb + imageFile(:) * imageFile(:)';
        case 'proj_rule_radioButton'
            handles.projImages = [handles.projImages double(imageFile(:))];
            handles.weightsHebb = handles.projImages * pinv(handles.projImages); 
    end
    for k1 = 1:length(handles.weightsHebb)
        handles.weightsHebb(k1, k1) = 0;
    end
    h = msgbox('File was loaded and Learning is done successfully!','Success');
end
guidata(hObject, handles);

function learn_image_pushButton_Callback(hObject, eventdata, handles)
guidata(hObject, handles);

function reset_learn_pushButton_Callback(hObject, eventdata, handles)
handles.weightsHebb = 0;
handles.projImages = [];
set(handles.hebb_rule_radioButton, 'Enable', 'On');
set(handles.proj_rule_radioButton, 'Enable', 'On');
set(handles.impl_binary_radioButton, 'Enable', 'On');
set(handles.impl_bipolar_radioButton, 'Enable', 'On');
set(handles.load_learn_pushButton, 'Enable', 'On');
set(handles.iterNo_editText, 'String', '0');
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
guidata(hObject, handles);

function retrieve_image_pushButton_Callback(hObject, eventdata, handles)
implem_type = get(get(handles.imple_type_buttonGroup, 'SelectedObject'), 'Tag');
imageFile = handles.imageFile;
imageOrig = handles.imageOrig;
imReshaped = imageFile(:);
imOrigReshaped = imageOrig(:);
output = imReshaped;
thetaBin = -.5 .* ones(size(imReshaped));
thetaBip = zeros(size(imReshaped));
c2 = 0;
retrievalError = [];
isSAhopfield = get(handles.hop_sa_radioButton, 'Value');
hopSAn = str2num(get(handles.hop_sa_n_editText, 'String'));
hopSAt0 = str2num(get(handles.hop_sa_t0_editText, 'String'));
hopSAalphaT = str2num(get(handles.hop_sa_alphaT_editText, 'String'));
while true
    outputTmp = output;
    switch implem_type
        case 'impl_binary_radioButton'
            for c1 = 1:length(imageFile(:))
                netInput = handles.weightsHebb(c1, :) * output + thetaBin(c1);
                output(c1) = heaviside(netInput);
            end
        case 'impl_bipolar_radioButton'
            if ~isSAhopfield
                for c1 = 1:length(imageFile(:))
                    netInput = handles.weightsHebb(c1, :) * output + thetaBip(c1);
                    output(c1) = sign(netInput);
                end
            else
                for k1 = 1:hopSAn
                    for k2 = 1:length(imReshaped)
                        deltaE = 4 .* output(k2) .* (handles.weightsHebb(k2, :) * output);
                        if deltaE < 0
                            output(k2) = -output(k2);
                        else
                            if rand < exp(-deltaE/hopSAt0)
                                output(k2) = -output(k2);
                            end
                        end
                    end
                end
                hopSAt0 = hopSAalphaT * hopSAt0;
            end
    end
    axes(handles.axes2);
    imshow(reshape(output, size(imageFile)));
    c2 = c2 + 1;
    set(handles.iterNo_editText, 'String', num2str(c2));
    retrievalError = [retrievalError mean((output - double(imOrigReshaped)).^2)];
    axes(handles.axes3);
    plot(retrievalError, '--r');
    grid on;
    handles.retrievalError = retrievalError;
    axes(handles.axes4);
    bar(output); colormap(handles.axes4, 'summer'); grid on;
    handles.output = output;
    pause(1);
    if output == outputTmp; break; end
end
h = msgbox('File was loaded and Learning is done successfully!','Success');
guidata(hObject, handles);

function iterNo_editText_CreateFcn(hObject, eventdata, handles)

function impl_binary_radioButton_Callback(hObject, eventdata, handles)
set(handles.hop_sa_radioButton, 'Enable', 'Off');
set(handles.hop_sa_n_editText, 'Enable', 'Off');
set(handles.hop_sa_t0_editText, 'Enable', 'Off');
set(handles.hop_sa_alphaT_editText, 'Enable', 'Off');
guidata(hObject, handles);

function impl_bipolar_radioButton_Callback(hObject, eventdata, handles)
set(handles.hop_sa_radioButton, 'Enable', 'On');
set(handles.hop_sa_n_editText, 'Enable', 'On');
set(handles.hop_sa_t0_editText, 'Enable', 'On');
set(handles.hop_sa_alphaT_editText, 'Enable', 'On');
guidata(hObject, handles);

function save_net_pushButton_Callback(hObject, eventdata, handles)
HopNet = struct('retrievalError', handles.retrievalError, 'output', handles.output, 'weightsHebb', handles.weightsHebb);
uisave({'HopNet'}, 'HopNet01.mat');
guidata(hObject, handles);

function load_net_pushButton_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile('*.mat', 'Select the saved Hopfield network', 'HopNet01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    handles.HopNet = importdata([PathName FileName]);
    axes(handles.axes3);
    plot(handles.HopNet.retrievalError, '--r'); grid on;
    axes(handles.axes4);
    bar(handles.HopNet.output); colormap(handles.axes4, 'summer'); grid on;
    handles.weightsHebb = handles.HopNet.weightsHebb;
    h = msgbox('File was loaded successfully!','Success');
end
guidata(hObject, handles);
