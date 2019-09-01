% function [] = MLPonMNISTimages()
%MLPonMNISTimages Train the multi-layer perceptron by the MNIST database
%with evaluating its functionality.
    
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
    
%     normalizedFeatures = features;
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
    layersNeuronNo = [384 20 30 40 1];
    hiddenLayersNo = size(layersNeuronNo, 2) - 2;
    maxLayersNeuronNo = max(layersNeuronNo);

    % Choose appropriate parameters.
%     learningRate = .001;
    etaStartPoint = 1 / trainIndex * 10;
    etaEndPoint = 1 / trainIndex;
    intervalLength = etaEndPoint - etaStartPoint;
    intervalPercentage = .9;
    learningRate = etaStartPoint + intervalPercentage * intervalLength;
    
    momentum = 0.9;
    isMomentum = input('Use momentum or not? (1 OR 0)\n');
    
    isWidrow = input('Using Nguyen-Widrow initialization or not? (0 for No AND 1 for Yes)\n');
    
    batchSize = input('Please enter the amount of batchsize:\n');
    maxEpochs = input('Please enter the maximum number of epochs:\n');
    
    [weightMatrix, errorMatrix] = functionFitnessTrain(activationFunction, activationFunctionDerivative, ...
        layersNeuronNo, trainDataset, trainTags, validDataset, validTags, validError, maxEpochs, batchSize, ...
        learningRate, momentum, isMomentum, isWidrow);
        
    [correctlyClassified, classificationErrors, testErrorPercentage] = functionFitnessTest(activationFunction, ...
        weightMatrix, testDataset, testTags, layersNeuronNo);
     
    fprintf('Classification errors: %d\n', classificationErrors);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Test error percentage is: %0.5f\n', testErrorPercentage);
% end