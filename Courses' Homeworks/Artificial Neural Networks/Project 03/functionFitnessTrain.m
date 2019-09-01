function [weightMatrix] = functionFitnessTrain(activationFunction, activationFunctionDerivative, ...
        layersNeuronNo, trainDataset, trainTags, validDataset, validTags, validError, maxEpochs, batchSize, ...
        learningRate, momentum, isMomentum, isWidrow, weightPlottingSrcNode, weightPlottingDestNode,...
        weightPlottingHiddOutpLayNo, hObject, handles)
        
    % The number of training vectors.    
    trainingSetSize = size(trainDataset, 1);
    
    neuronsPerLayer = layersNeuronNo;
    hiddenLayersNo = size(neuronsPerLayer, 2) - 2;
    maxLayersNeuronNo = max(neuronsPerLayer);

    weightMatrix = rand(maxLayersNeuronNo, maxLayersNeuronNo, hiddenLayersNo + 1);
    % Considering Widrow approach for apointing initial values to weights
    if isWidrow
        weightMatrix = weightMatrix - .5;
        for kk = 1:hiddenLayersNo
            scaleFactor = neuronsPerLayer(kk + 1) .^ (1 ./ neuronsPerLayer(kk));
            weightMatrix(:, :, kk) = ...
                (scaleFactor / norm(weightMatrix(1:neuronsPerLayer(kk), 1:neuronsPerLayer(kk + 1), kk))) ...
                .* weightMatrix(:, :, kk);
        end
    end
    
    oldWeightMatrix = weightMatrix;
    olderWeightMatrix = weightMatrix;
    
    plottingWeight = zeros(1, maxEpochs);

    netInputs = zeros(batchSize, maxLayersNeuronNo, hiddenLayersNo + 1);
    actFuncOutputs = zeros(batchSize, maxLayersNeuronNo, hiddenLayersNo + 1);

    hiddenDelta = zeros(batchSize, maxLayersNeuronNo, hiddenLayersNo);
    outputDelta = zeros(batchSize, neuronsPerLayer(hiddenLayersNo + 2));
    
    errorMatrixTrain = zeros(floor(trainingSetSize / batchSize), maxEpochs, 2);
    errorNormVectorTrain = zeros(1, maxEpochs);
    errorMatrixValid = zeros(1, maxEpochs, 2);
%     errorNormVectorValid = zeros(1, maxEpochs);
        
    %% Training procedure
    for t = 1:maxEpochs
        for k = 1:floor(trainingSetSize / batchSize)
            
            %% Getting the right input matrix according to the batch size
            inputMatrix = trainDataset((k - 1) * batchSize + 1:k * batchSize, :);
            
            %% Calculating netInputs and outputs for all hidden and output units
            netInputs(:, 1:neuronsPerLayer(2), 1) = ...
            inputMatrix * weightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1);
            actFuncOutputs(:, 1:neuronsPerLayer(2), 1) = ...
                activationFunction(netInputs(:, 1:neuronsPerLayer(2), 1));
            
            for ii = 2:hiddenLayersNo + 1
                netInputs(:, 1:neuronsPerLayer(ii + 1), ii) = ...
                    actFuncOutputs(:, 1:neuronsPerLayer(ii), ii - 1) ...
                    * weightMatrix(1:neuronsPerLayer(ii), 1:neuronsPerLayer(ii + 1), ii);
                actFuncOutputs(:, 1:neuronsPerLayer(ii + 1), ii) = ...
                    activationFunction(netInputs(:, 1:neuronsPerLayer(ii + 1), ii));                
            end
            
            %% Getting the target values
            trainTargetVector = trainTags((k - 1) * batchSize + 1:k * batchSize, :);

            %% Calculating the delta value for the output and hidden units
            outputDelta(:, 1:neuronsPerLayer(hiddenLayersNo + 2)) = ... 
                activationFunctionDerivative(netInputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1)) .* ...
                (trainTargetVector - ...
                actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1));
            
            hiddenDelta(:, 1:neuronsPerLayer(hiddenLayersNo + 1), hiddenLayersNo) = ...
                activationFunctionDerivative(netInputs(:, 1:neuronsPerLayer(hiddenLayersNo + 1), hiddenLayersNo)) .* ...
                (outputDelta(:, 1:neuronsPerLayer(hiddenLayersNo + 2)) * ...
                transpose(weightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1)));
            mm = hiddenLayersNo - 1;            
            while(mm > 0)
                hiddenDelta(:, 1:neuronsPerLayer(mm + 1), mm) = ...
                    activationFunctionDerivative(netInputs(:, 1:neuronsPerLayer(mm + 1), mm)) .* ...
                    (hiddenDelta(:, 1:neuronsPerLayer(mm + 2), mm + 1) * ...
                    transpose(weightMatrix(1:neuronsPerLayer(mm + 1), 1:neuronsPerLayer(mm + 2), mm + 1)));
                mm = mm - 1;
            end
            
            %% Updating the weight matrix for all hidden and output units
            if isMomentum
                weightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1) = ...
                oldWeightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1) + ...
                (1 ./ batchSize) .* learningRate .* (transpose(inputMatrix) * ...
                hiddenDelta(:, 1:neuronsPerLayer(2), 1)) + ...
                momentum * (oldWeightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1) - ...
                olderWeightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1));
                for nn = 2:hiddenLayersNo
                    weightMatrix(1:neuronsPerLayer(nn), 1:neuronsPerLayer(nn + 1), nn) = ...
                        oldWeightMatrix(1:neuronsPerLayer(nn), 1:neuronsPerLayer(nn + 1), nn) + ...
                        (1 ./ batchSize) .* learningRate .* (transpose(actFuncOutputs(:, 1:neuronsPerLayer(nn), nn - 1)) * ...
                        hiddenDelta(:, 1:neuronsPerLayer(nn + 1), nn)) + ...
                        momentum * (oldWeightMatrix(1:neuronsPerLayer(nn), 1:neuronsPerLayer(nn + 1), nn) - ...
                        olderWeightMatrix(1:neuronsPerLayer(nn), 1:neuronsPerLayer(nn + 1), nn));
                end

                weightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1) = ...
                oldWeightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1) + ...
                (1 ./ batchSize) .* learningRate .* (transpose(actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 1), hiddenLayersNo)) * ...
                outputDelta(:, 1:neuronsPerLayer(hiddenLayersNo + 2))) + ...
                momentum * (oldWeightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1) - ...
                olderWeightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1));
                olderWeightMatrix = oldWeightMatrix;
                oldWeightMatrix = weightMatrix;
            else                
                weightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1) = ...
                weightMatrix(1:neuronsPerLayer(1), 1:neuronsPerLayer(2), 1) + ...
                (1 ./ batchSize) .* learningRate .* (transpose(inputMatrix) * ...
                hiddenDelta(:, 1:neuronsPerLayer(2), 1));
                for nn = 2:hiddenLayersNo
                    weightMatrix(1:neuronsPerLayer(nn), 1:neuronsPerLayer(nn + 1), nn) = ...
                    weightMatrix(1:neuronsPerLayer(nn), 1:neuronsPerLayer(nn + 1), nn) + ...
                    (1 ./ batchSize) .* learningRate .* (transpose(actFuncOutputs(:, 1:neuronsPerLayer(nn), nn - 1)) * ...
                    hiddenDelta(:, 1:neuronsPerLayer(nn + 1), nn));
                end

                weightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1) = ...
                weightMatrix(1:neuronsPerLayer(hiddenLayersNo + 1), 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1) + ...
                (1 ./ batchSize) .* learningRate .* (transpose(actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 1), hiddenLayersNo)) * ...
                outputDelta(:, 1:neuronsPerLayer(hiddenLayersNo + 2)));
            end
            
            plottingWeight(1, t) = weightMatrix(weightPlottingSrcNode, weightPlottingDestNode, weightPlottingHiddOutpLayNo);
            
            %% Calculating the error values per batch size
%             errorMatrix(k, t) = mean(transpose(sum((targetVector - ...
%                 actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1))) .^ 2) ./ 2));
            % RMS Error
%             errorMatrix(k, t, 1) = mean((targetVector - ...
%                 actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1)) .^ 2);
            % Sum of errors
            errorMatrixTrain(k, t, 1) = sum(trainTargetVector - ...
                actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1));
            errorMatrixTrain(k, t, 2) = norm(trainTargetVector - ...
                actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1));
%             errorMatrix(k, t) = mean(transpose(sqrt(sum((targetVector - ...
%                 transpose(actFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1))) .^ 2))));
        end
        
        %% Calculating output vales for validation set
        validOutput = validDataset;
        calcLength = size(weightMatrix, 3);

        for ii = 1:calcLength
            validInput = validOutput * weightMatrix(1:neuronsPerLayer(ii), 1:neuronsPerLayer(ii + 1), ii);
            validOutput = activationFunction(validInput);
        end

%         errorMatrixValid(t) = mean((validTags - validActFuncOutputs(:, 1:neuronsPerLayer(hiddenLayersNo + 2), hiddenLayersNo + 1)) .^ 2);
        errorMatrixValid(1, t, 1) = sum(validTags - validOutput);
        errorMatrixValid(1, t, 2) = norm(validTags - validOutput);
        errorNormVectorTrain(t) = norm(errorMatrixTrain(:, t, 2));
%         figure(1);
        axes(handles.axes1);
        plot(sum(errorMatrixTrain(:, 1:t, 1)), '-r'); % plots sum of training errors
        hold on;
        plot(errorNormVectorTrain(1:t), '-b'); % plots norm of training errors
        grid on;
%         guidata(hObject, handles);
%         figure(2);
        axes(handles.axes2);
        plot(errorMatrixValid(1, 1:t, 1), '-r'); % plots sum of validation errors
        hold on;
        plot(errorMatrixValid(1, 1:t, 2), '-b'); % plots norm of validation errors
        grid on;
        axes(handles.axes3);
        plot(plottingWeight(1, 1:t), '-k');
        grid on;
        pause(.0005);
%         guidata(hObject, handles);
        if (abs(errorMatrixValid(1, t, 1)) < validError) 
            break
        end % end of if
        if (errorMatrixValid(1, t, 2) < validError)
            break
        end
    end % end of epoch loop
%     figure(1);
%     axes(handles.axes1);
    legend(handles.axes1, 'Sum of Training Errors', 'Norm of Training Errors');
%     title(handles.axes1, 'Training Errors');
%     figure(2);
%     axes(handles.axes1);
    legend(handles.axes2, 'Sum of Evaluation Errors', 'Norm of Evaluation Errors');
%     title(handles.axes2, 'Evaluation Errors');
    guidata(hObject, handles);
end