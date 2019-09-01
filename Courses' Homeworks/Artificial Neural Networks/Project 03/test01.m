    clc, clear all, close all
    
    data = csvread('slice_localization_data.csv', 1, 1);
    features = data(:, 1:384);
    tags = data(:, 385);
         
    highInterval = input('Please enter the interval high value:\n');
    lowInterval = input('Please enter the interval low value:\n');
    normMethod = input('Please enter the method of normalization: (0 for global normalization OR 1 for vectorial normalization)\n');
    normalizedFeatures = normalizeDataSet(features, highInterval, lowInterval, normMethod);
    
    minTags = min(tags);
    maxTags = max(tags);
    normDenomTags = maxTags - minTags;
    normalizedTags = (tags - minTags) ./ normDenomTags;
    
    trainPercentage = input('Please enter the percentage of training dataset: (e.g. 70)\n');
    validPercentage = input('Please enter the percentage of validation dataset: (e.g. 15)\n');
    trainIndex = floor(.01 * trainPercentage * size(features, 1));
    validIndex = trainIndex + floor(.01 * validPercentage * size(features, 1));

    isShuffled = input('Do you want to shuffle the dataset? (0 for No OR 1 for Yes)\n');
    
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

    fprintf('Please insert activation function type:\n\t0 for logisticSigmoid\n\t1 for bipolarSigmoid\n\t2 for arcTangent\n\t3 for logFunction\n');
    actFuncType = input('');
    switch actFuncType
        case 0
            activationFunction = @logisticSigmoid;
            activationFunctionDerivative = @logisticSigmoidDerivative;
        case 1
            activationFunction = @bipolarSigmoid;
            activationFunctionDerivative = @bipolarSigmoidDerivative;
            normalizedTags = normalizedTags .* 2 - 1;
        case 2
            activationFunction = @arcTangent;
            activationFunctionDerivative = @arcTangentDerivative;
            normalizedTags = normalizedTags .* 2 - 1;
        case 3
            activationFunction = @logFunction;
            activationFunctionDerivative = @logFunctionDerivative;
            normalizedTags = normalizedTags .* 2 - 1;
    end
    
    validError = input('Please enter the minimum error for validation process:\n'); 
    
    % Choose form of MLP:
    layersNeuronNo = [384 15 15 1];
    hiddenLayersNo = size(layersNeuronNo, 2) - 2;
    maxLayersNeuronNo = max(layersNeuronNo);

    % Choose appropriate parameters.
    learningRate = .001;
%     etaStartPoint = 1 / trainIndex * 10;
%     etaEndPoint = 1 / trainIndex;
%     intervalLength = etaEndPoint - etaStartPoint;
%     intervalPercentage = .9;
%     learningRate = etaStartPoint + intervalPercentage * intervalLength;
    
    momentum = 0.9;
    isMomentum = input('Use momentum or not? (1 OR 0)\n');
    
    isWidrow = input('Using Nguyen-Widrow initialization or not? (0 for No AND 1 for Yes)\n');
    
    batchSize = input('Please enter the amount of batchsize:\n');
    maxEpochs = input('Please enter the maximum number of epochs:\n');
    
    weightPlottingSrcNode = 1;
    weightPlottingDestNode = 2;
    weightPlottingHiddOutpLayNo = 1;

    
%     [weightMatrix, errorMatrix] = functionFitnessTrain(activationFunction, activationFunctionDerivative, ...
%         layersNeuronNo, trainDataset, trainTags, validDataset, validTags, validError, maxEpochs, batchSize, ...
%         learningRate, momentum, isMomentum, isWidrow);
      
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
        figure(1);
%         axes(handles.axes1);
        plot(sum(errorMatrixTrain(:, 1:t, 1)), '-r'); % plots sum of training errors
        hold on;
        plot(errorNormVectorTrain(1:t), '-b'); % plots norm of training errors
        grid on;
%         guidata(hObject, handles);
        figure(2);
%         axes(handles.axes2);
        plot(errorMatrixValid(1, 1:t, 1), '-r'); % plots sum of validation errors
        hold on;
        plot(errorMatrixValid(1, 1:t, 2), '-b'); % plots norm of validation errors
        grid on;
        figure(3);
%         axes(handles.axes3);
        plot(plottingWeight(1, 1:t), '-k');
        grid on;
%         pause(.0005);
%         guidata(hObject, handles);
        if (abs(errorMatrixValid(1, t, 1)) < validError) 
            break
        end % end of if
        if (errorMatrixValid(1, t, 2) < validError)
            break
        end
    end % end of epoch loop
    figure(1);
%     axes(handles.axes1);
%     legend(handles.axes1, 'Sum of Training Errors', 'Norm of Training Errors');
    legend('Sum of Training Errors', 'Norm of Training Errors');
    title('Training Errors');
    figure(2);
%     axes(handles.axes1);
    legend('Sum of Evaluation Errors', 'Norm of Evaluation Errors');
    title('Evaluation Errors');
    figure(3);
    legend('W(1, 2, 1) - (srcNode, DestNode, HiddenLayerNo.)');
    title('Weight Changing Plot');
%     guidata(hObject, handles);

    [correctlyClassified, classificationErrors, testErrorPercentage] = functionFitnessTest(activationFunction, ...
        weightMatrix, testDataset, testTags, layersNeuronNo);
     
    fprintf('Classification errors: %d\n', classificationErrors);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Test error percentage is: %0.5f\n', testErrorPercentage);
% end