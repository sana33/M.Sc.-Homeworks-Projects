function [] = setParams(hObject, handles, kohonenOutputs)
% This function sets gui parameters and axes data

%% Setting gui parameters
switch numel(kohonenOutputs.kohonenSet.kohonenDims)
    case 1
        set(handles.one_dim_radioButton, 'Value', 1);
        set(handles.one_dim_editText, 'Enable', 'on');
        set(handles.two_dim_editText, 'Enable', 'off');
        set(handles.three_dim_editText, 'Enable', 'off');
        set(handles.one_dim_editText, 'String', num2str(kohonenOutputs.kohonenSet.kohonenDims));
    case 2
        set(handles.two_dim_radioButton, 'Value', 1);
        set(handles.one_dim_editText, 'Enable', 'on');
        set(handles.two_dim_editText, 'Enable', 'on');
        set(handles.three_dim_editText, 'Enable', 'off');
        set(handles.one_dim_editText, 'String', num2str(kohonenOutputs.kohonenSet.kohonenDims(1)));
        set(handles.two_dim_editText, 'String', num2str(kohonenOutputs.kohonenSet.kohonenDims(2)));
    case 3
        set(handles.three_dim_radioButton, 'Value', 1);
        set(handles.one_dim_editText, 'Enable', 'on');
        set(handles.two_dim_editText, 'Enable', 'on');
        set(handles.three_dim_editText, 'Enable', 'on');
        set(handles.one_dim_editText, 'String', num2str(kohonenOutputs.kohonenSet.kohonenDims(1)));
        set(handles.two_dim_editText, 'String', num2str(kohonenOutputs.kohonenSet.kohonenDims(2)));
        set(handles.three_dim_editText, 'String', num2str(kohonenOutputs.kohonenSet.kohonenDims(3)));
end

switch kohonenOutputs.kohonenSet.neighbParamsSelectedObject
    case 'recognizable_neighb_radioButton'
        set(handles.recognizable_neighb_radioButton, 'Value', 1);
        set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'on');
        set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'on');
        set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'on');        
        set(handles.zigma_zero_editText, 'Enable', 'off');
        set(handles.t1_editText, 'Enable', 'off');
        set(handles.eta_zero_editText, 'Enable', 'off');
        set(handles.t2_editText, 'Enable', 'off');
        switch kohonenOutputs.kohonenSet.recognizableOpt
            case 'circle_recog_neighb_opt_radioButton'
                set(handles.circle_recog_neighb_opt_radioButton, 'Value', 1);
            case 'rectangle_recog_neighb_opt_radioButton'
                set(handles.rectangle_recog_neighb_opt_radioButton, 'Value', 1);
            case 'hexagon_recog_neighb_opt_radioButton'
                set(handles.hexagon_recog_neighb_opt_radioButton, 'Value', 1);
        end
    case 'unRecognizable_neighb_radioButton'
        set(handles.unRecognizable_neighb_radioButton, 'Value', 1);
        set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'off');
        set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'off');
        set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'off');
        set(handles.zigma_zero_editText, 'Enable', 'on');
        set(handles.t1_editText, 'Enable', 'on');
        set(handles.eta_zero_editText, 'Enable', 'on');
        set(handles.t2_editText, 'Enable', 'on');
        set(handles.zigma_zero_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.zigma_zero));
        set(handles.t1_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.t1));
        set(handles.eta_zero_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.eta_zero));
        set(handles.t2_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.t2));
end

switch kohonenOutputs.kohonenSet.winnerDistType
    case 'euclidian_winDistType_radioButton'
        set(handles.euclidian_winDistType_radioButton, 'Value', 1);
    case 'spherGeomDist_winDistType_radioButton'
        set(handles.spherGeomDist_winDistType_radioButton, 'Value', 1);
end

set(handles.cluster_measure_editText, 'String', num2str(kohonenOutputs.kohonenSet.clusterMeasure));

set(handles.beta_desino_editText, 'String', num2str(kohonenOutputs.kohonenSet.desinoParams.desinoBeta));
set(handles.gamma_desino_editText, 'String', num2str(kohonenOutputs.kohonenSet.desinoParams.desinoGamma));
if kohonenOutputs.kohonenSet.desinoParams.isDesino
    set(handles.is_desino_checkBox, 'Value', 1);
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
    set(handles.is_desino_checkBox, 'Value', 0);
    switch kohonenOutputs.kohonenSet.neighbParamsSelectedObject
        case 'recognizable_neighb_radioButton'
            set(handles.recognizable_neighb_radioButton, 'Value', 1);
            set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'on');
            set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'on');
            set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'on');        
            set(handles.zigma_zero_editText, 'Enable', 'off');
            set(handles.t1_editText, 'Enable', 'off');
            set(handles.eta_zero_editText, 'Enable', 'off');
            set(handles.t2_editText, 'Enable', 'off');
            switch kohonenOutputs.kohonenSet.recognizableOpt
                case 'circle_recog_neighb_opt_radioButton'
                    set(handles.circle_recog_neighb_opt_radioButton, 'Value', 1);
                case 'rectangle_recog_neighb_opt_radioButton'
                    set(handles.rectangle_recog_neighb_opt_radioButton, 'Value', 1);
                case 'hexagon_recog_neighb_opt_radioButton'
                    set(handles.hexagon_recog_neighb_opt_radioButton, 'Value', 1);
            end
        case 'unRecognizable_neighb_radioButton'
            set(handles.unRecognizable_neighb_radioButton, 'Value', 1);
            set(handles.circle_recog_neighb_opt_radioButton, 'Enable', 'off');
            set(handles.rectangle_recog_neighb_opt_radioButton, 'Enable', 'off');
            set(handles.hexagon_recog_neighb_opt_radioButton, 'Enable', 'off');
            set(handles.zigma_zero_editText, 'Enable', 'on');
            set(handles.t1_editText, 'Enable', 'on');
            set(handles.eta_zero_editText, 'Enable', 'on');
            set(handles.t2_editText, 'Enable', 'on');
            set(handles.zigma_zero_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.zigma_zero));
            set(handles.t1_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.t1));
            set(handles.eta_zero_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.eta_zero));
            set(handles.t2_editText, 'String', num2str(kohonenOutputs.kohonenSet.unRecognizableOpt.t2));
    end
end

set(handles.train_size_editText, 'String', num2str(kohonenOutputs.kohonenSet.trainSizePerc));
set(handles.test_size_editText, 'String', num2str(kohonenOutputs.kohonenSet.testSizePerc));
if kohonenOutputs.kohonenSet.isStandard
    set(handles.is_standard_checkBox, 'Value', 1);
else
    set(handles.is_standard_checkBox, 'Value', 0);
end
set(handles.epoch1_editText, 'String', num2str(kohonenOutputs.kohonenSet.EPOCH1));
set(handles.epoch2_editText, 'String', num2str(kohonenOutputs.kohonenSet.EPOCH2));

%% Setting gui axes
set(handles.winner_neurons_table, 'Data', reshape(kohonenOutputs.winCounter, kohonenOutputs.kohonenSet.kohonenDims(1), []));

axes(handles.axes1);
plot(kohonenOutputs.errorMean, '-r');
grid on;

axes(handles.axes2);
plot(kohonenOutputs.deadNeuron, '-k');
grid on;

legend(handles.axes1, 'Updating Error Rate');
legend(handles.axes2, 'Dead Neurons No.');

axes(handles.axes3);
bar(kohonenOutputs.groups);
grid on;

axes(handles.axes4);
plot(kohonenOutputs.clustersNo);
grid on;

legend(handles.axes3, 'Clusters Bar');
legend(handles.axes4, 'Clusters Count');

kWeightsReshaped = reshape(kohonenOutputs.kohonenWeights, prod(kohonenOutputs.kohonenSet.kohonenDims), []);
inputNo = size(kWeightsReshaped, 1);
inputLength = size(kWeightsReshaped, 2);
plotKWeightsDims(hObject, handles, kWeightsReshaped, ...
    inputNo, inputLength);

axes(handles.axes7);
imagesc(normalizeDataSet(kohonenOutputs.U_Matrix, 1, 0, 0), 'CDataMapping', 'scaled'); colorbar;

%% .......
guidata(hObject, handles);
