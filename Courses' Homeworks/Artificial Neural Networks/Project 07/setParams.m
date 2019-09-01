function [] = setParams(hObject, handles, ElmanNet)
set(handles.hidden_layer_unitNo_editText, 'String', num2str(ElmanNet.hiddenLayerUnitNo));
set(handles.weighting_factor_editText, 'String', num2str(ElmanNet.weightingFactor));
archType = strcat('1+', num2str(ElmanNet.hiddenLayerUnitNo), '--', num2str(ElmanNet.hiddenLayerUnitNo), '--1');
set(handles.arch_type_staticText, 'String', archType);
set(handles.eta1_editText, 'String', num2str(ElmanNet.eta1));
set(handles.eta2_editText, 'String', num2str(ElmanNet.eta2));
set(handles.batch_size_editText, 'String', num2str(ElmanNet.batchSize));
set(handles.lagsNo_editText, 'String', num2str(ElmanNet.lagsNo));
set(handles.series_select_popupMenu, 'Value', ElmanNet.seriesSelectedNo);
switch ElmanNet.estimateEvalCriterion
    case 'mse_radioButton'
        set(handles.mse_radioButton, 'Value', 1);
    case 'mae_radioButton'
        set(handles.mae_radioButton, 'Value', 1);
    case 'rmae_radioButton'
        set(handles.rmae_radioButton, 'Value', 1);
    case 'pi_radioButton'
        set(handles.pi_radioButton, 'Value', 1);
end
switch ElmanNet.actFuncType
    case 'binary_sigmoid_radioButton'
        set(handles.binary_sigmoid_radioButton, 'Value', 1);
        actFunc = @logisticSigmoid;
    case 'bipolar_sigmoid_radioButton'
        set(handles.bipolar_sigmoid_radioButton, 'Value', 1);
        actFunc = @bipolarSigmoid;
    case 'arc_tangent_radioButton'
        set(handles.arc_tangent_radioButton, 'Value', 1);
        actFunc = @arcTangent;
end

cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);

axes(handles.axes1);
plot(ElmanNet.trainSet, 'Color', 'red', 'LineWidth', 2);
hold on;
grid on;
plot(ElmanNet.outputZ, 'Color', 'k');

axes(handles.axes2);
switch ElmanNet.estimateEvalCriterion
    case 'mse_radioButton'
        plot(ElmanNet.trainErrors.errorMSEtrain, 'Color', 'red');
        hold on;
        plot(ElmanNet.validErrors.errorMSEvalid, 'Color', 'magenta');
        grid on;
    case 'mae_radioButton'
        plot(ElmanNet.trainErrors.errorMAEtrain, 'Color', 'red');
        hold on;
        plot(ElmanNet.validErrors.errorMAEvalid, 'Color', 'magenta');
        grid on;
    case 'rmae_radioButton'
        plot(ElmanNet.trainErrors.errorRMAEtrain, 'Color', 'red');
        hold on;
        plot(ElmanNet.validErrors.errorRMAEvalid, 'Color', 'magenta');
        grid on;
    case 'pi_radioButton'
        plot(ElmanNet.trainErrors.errorPItrain, 'Color', 'red');
        hold on;
        plot(ElmanNet.validErrors.errorPIvalid, 'Color', 'magenta');
        grid on;
end

legend(handles.axes1, 'Target Value', 'Estimated Value');
legend(handles.axes2, 'Training Error', 'Validation Error');

axes(handles.axes3);
X = squeeze(ElmanNet.weightsOutput);     
%         surf(X, 'facecolor', [.5 .5 .5]);
%         colormap(parula(5));
if size(X, 1)~=1 && size(X, 2)~=1
    C = rand(1, 3);
    C1 = rand(1, 3);
    surf(X, C, 'facecolor', C, 'edgecolor', C1, 'facelighting', 'phong');
else
    plot(X, 'Color', [.13 .37 .66], 'LineWidth', 1.5);
    xlim([0 1e4]);
    grid on;
end

% Considering a test after loading old net
seriesTesting(hObject, handles, ElmanNet.seriesSelected, length(ElmanNet.seriesSelected), ElmanNet.contextInputs, ElmanNet.weightsHidden(:, :, end), ...
    ElmanNet.weightsContext(:, :, end), ElmanNet.weightsOutput(:, :, end), actFunc, ElmanNet.estimateEvalCriterion);

guidata(hObject, handles);