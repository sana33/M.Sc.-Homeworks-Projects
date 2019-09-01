function [weightMatrix, errorTrain, errorEval] = RLSalgorithm(trainDataset, evalDataset, trainTags, evalTags, lambda, hObject, handles)
    weightMatrix = zeros(size(trainDataset, 2), size(trainTags, 2), size(trainDataset, 1));
    P = (lambda .^ -1) .* eye(size(trainDataset, 2));
    errorTrain = zeros(2, size(trainTags, 1));
    errorEval = zeros(2, size(trainTags, 1));
    for ii = 1:size(trainDataset, 1)
        %% Training phase
        P = P - (P * transpose(trainDataset(ii, :)) * trainDataset(ii, :) * P) ./ (1 + trainDataset(ii, :) * P * ...
            transpose(trainDataset(ii, :)));
        g = P * transpose(trainDataset(ii, :));
        alpha = transpose(trainTags(ii, :)) - transpose(weightMatrix(:, :, ii)) * transpose(trainDataset(ii, :));

        weightMatrix(:, :, ii) = weightMatrix(:, :, ii) + g * transpose(alpha);
        
        [misClassifiedTrain, correctlyClassifiedTrain, errorTrain(:, ii)] = rbfTest(trainDataset, trainTags, weightMatrix(:, :, ii));

        %% Evaluation phase        
        [misClassifiedEval, correctlyClassifiedEval, errorEval(:, ii)] = rbfTest(evalDataset, evalTags, weightMatrix(:, :, ii));
    
        %% Plotting Diagrams
%         figure(3);
        axes(handles.axes3);
        plot(errorTrain(1, 1:ii), 'r');
        hold on;
        plot(errorTrain(2, 1:ii) .* 100, 'g');
        plot(errorEval(1, 1:ii), 'b');
        plot(errorEval(2, 1:ii) .* 100, 'k');
        grid on;        
        pause(.0005);
    end

%     figure(3);
    axes(handles.axes3);
    legend('TrainError(MSE)', 'TrainError(%)', 'EvalError(MSE)', 'EvalError(%)');
    hold off;
    
    set(handles.final_train_error_mse_editText, 'String', num2str(errorTrain(1, ii)));
    set(handles.final_train_error_perc_editText, 'String', num2str(errorTrain(2, ii) .* 100));
    set(handles.final_eval_error_mse_editText, 'String', num2str(errorEval(1, ii)));
    set(handles.final_eval_error_perc_editText, 'String', num2str(errorEval(2, ii) .* 100));
    guidata(hObject, handles);
    