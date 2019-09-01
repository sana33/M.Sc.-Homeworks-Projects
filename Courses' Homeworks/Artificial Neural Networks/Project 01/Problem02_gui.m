function varargout = Problem02_gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Problem02_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Problem02_gui_OutputFcn, ...
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

% --- Executes just before Problem02_gui is made visible.
function Problem02_gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Problem02_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in loadDataset02.
function loadDataset02_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.data','Select the Input File');
dataSet = load([PathName FileName]);
handles.dataSet = dataSet;
guidata(hObject,handles);

% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
maxEpoch = handles.max_ep;
minError = handles.min_err;
dataSet = handles.dataSet;
dataSet = sortrows(dataSet, 3);
handles.dataSet = dataSet;
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
        %           w = w + transpose(features) * error(:, m, n); % Updating weights without applying learning rate
        threshold = threshold + mean(error(:, m, n));
        axes(handles.axes13);
        hold on
        scatter(handles.axes13,  class1(:, 1), class1(:,2),'bs') %
        scatter(handles.axes13, class2(:, 1), class2(:,2),'ro')   
        h3 = ezplot(handles.axes13, @(x,y)foPtFunc(w(1),w(2),x,y,threshold), [minValues(1)-3 maxValues(1)+3 minValues(2)-3 maxValues(2)+3]);
        set(h3, 'color', rand(1, 3));
        grid(handles.axes13, 'on')
        drawnow;
        hold off
        errorMean(m, n) = mean(abs(error(:, m, n)));
        if errorMean(m, n) <= minError
            break;
        end % End of if
    end % End of while
    finalError(n) = mean(abs(errorMean(:, n)));
    finalWeights(:, n) = w;
    finalThreshold(:, n) = threshold;
    finalCoefficient = -finalWeights(1, n) / finalWeights(2, n);
    finalBias = finalThreshold(1, n) / finalWeights(2, n);
    x2 = finalCoefficient * x1 + finalBias;

    axes(handles.axes14);
    hold on;
    fh1 = plot(handles.axes14, class1(:, 1), class1(:,2), 'line', 'none', 'marker', 's', 'color', 'r');
    fh2 = plot(handles.axes14, class2(:, 1), class2(:,2), 'line', 'none', 'marker', 'o', 'color', 'b');
    finalColorMap = [.7 .6 .5; .4 .5 .3; .8 .2 .7];
    fh3 = plot(handles.axes14, x1, x2, '-', 'color', finalColorMap(n, :), 'LineWidth', 1.7);
    drawnow;
    grid(handles.axes14, 'on')
    hold off;
end % End of for
eX = linspace(1,maxEpoch,maxEpoch);
axes(handles.axes6);
hold on;
eh1 = plot(handles.axes6, eX, errorMean(:, 1));         % First application of first-order perceptron
eh2 = plot(handles.axes6, eX, errorMean(:, 2),'r*');         % Second application of first-order perceptron
eh3 = plot(handles.axes6, eX, errorMean(:, 3),'co');         % Third application of first-order perceptron
legend('First App.','Second App.','Third App.');
grid(handles.axes6, 'on')
hold off;
axes(handles.axes3);
hold on;
wh11 = plot(eX, plotingWeights(1, :, 1),'b.-');
wh12 = plot(eX, plotingWeights(2, :, 1), 'color', 'r');
grid(handles.axes3, 'on');
hold off;
axes(handles.axes4);
hold on;
wh21 = plot(eX, plotingWeights(1, :, 2), 'b.-'); 
wh22 = plot(eX, plotingWeights(2, :, 2), 'color', 'r');
grid(handles.axes4, 'on');
hold off;
axes(handles.axes5);
hold on;
wh31 = plot(eX, plotingWeights(1, :, 3), 'b.-');
wh32 = plot(eX, plotingWeights(2, :, 3),  'r');
grid(handles.axes5, 'on');
hold off;
guidata(hObject,handles);

function dataset02_ButtonDownFcn(hObject, eventdata, handles)


% --- Executes when entered data in editable cell(s) in tableOfNI02.
function tableOfNI02_CellEditCallback(hObject, eventdata, handles)

% --- Executes on button press in loadShuffledDataset02.
function loadShuffledDataset02_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function tableOfNI02_ButtonDownFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function tableOfNI02_CreateFcn(hObject, eventdata, handles)

% --- Executes on key press with focus on tableOfNI02 and none of its controls.
function tableOfNI02_KeyPressFcn(hObject, eventdata, handles)

function max_epoch_Callback(hObject, eventdata, handles)
str = get(handles.max_epoch, 'string');
max_ep = str2num(str);
handles.max_ep = max_ep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_epoch_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function min_error_Callback(hObject, eventdata, handles)
str = get(handles.min_error, 'string');
min_err = str2num(str);
handles.min_err = 10^min_err;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function min_error_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function axes13_CreateFcn(hObject, eventdata, handles)
