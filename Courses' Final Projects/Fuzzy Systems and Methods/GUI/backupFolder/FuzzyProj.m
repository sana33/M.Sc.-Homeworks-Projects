function varargout = FuzzyProj(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FuzzyProj_OpeningFcn, ...
                   'gui_OutputFcn',  @FuzzyProj_OutputFcn, ...
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

function FuzzyProj_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = FuzzyProj_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function partNo_editText_Callback(hObject, eventdata, handles)

function partNo_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function alpha_editText_Callback(hObject, eventdata, handles)

function alpha_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stopCond_editText_Callback(hObject, eventdata, handles)

function stopCond_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maxIter_editText_Callback(hObject, eventdata, handles)

function maxIter_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rhoVal_editText_Callback(hObject, eventdata, handles)

function rhoVal_editText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function load_pushBtn_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat', 'Select the dataset for clustering', 'ds01.mat');
if ~FileName 
    h = msgbox('Sorry! No file was loaded!', 'Failure', 'error');
else
    handles.dataset = importdata([PathName FileName]);
    h = msgbox('File was loaded successfully!','Success');
end

guidata(hObject, handles);

function start_pushBtn_Callback(hObject, eventdata, handles)

cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);

X = handles.dataset;

k = str2double(get(handles.partNo_editText,'String'));
alpha = str2double(get(handles.alpha_editText,'String'));
stopCond = str2double(get(handles.stopCond_editText,'String'));
maxIter = str2double(get(handles.maxIter_editText,'String'));
rho = str2num(get(handles.rhoVal_editText,'String'));
% rho = rand(1,k);

clustNo = numel(unique(X(3,:)));
Colors = hsv(clustNo);

axes(handles.axes1);
gscatter(X(1,:),X(2,:),X(3,:),Colors); grid on;
X = X(1:end-1,:);

% Performing Gustafson-Kessel Algorithm
hFP_GK = handles.axes2;
[m_f,M_inv,W_GK,hFP_GK] = GK_clust(X,k,alpha,stopCond,maxIter,rho,hFP_GK);
axes(hFP_GK);
title('The Final Result of GK Clutering Algorithm');

% Performing Fuzzy C-Means (FCM)
hFP_FCM = handles.axes3;
[V,W_FCM,hFP_FCM] = FCM(X,k,alpha,stopCond,maxIter,hFP_FCM);
axes(hFP_FCM);
title('The Final Result of FCM Clutering Algorithm');

h = msgbox('Operations done successfully!','Success');

guidata(hObject,handles);
