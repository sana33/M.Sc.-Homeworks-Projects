% function [] = MLPonMNISTimages()
%MLPonMNISTimages Train the multi-layer perceptron by the MNIST database
%with evaluating its functionality.
    
    clc, clear all, close all
    
    % Load MNIST database.
    mnistTrainDB = loadMNISTImages('train-images.idx3-ubyte');
    trainTags = loadMNISTLabels('train-labels.idx1-ubyte');
    
    % Transform the tags to correct target values.
    targetValues = 0.*ones(10, size(trainTags, 1));
    for n = 1:size(trainTags, 1)
        targetValues(trainTags(n) + 1, n) = 1;
    end
    
    % The number of training vectors.    
    trainingSetSize = size(mnistTrainDB, 2);
    % Input vector has 784 dimensions.    
    inputDimensions = size(mnistTrainDB, 1);
    % We have to distinguish 10 digits.    
    outputDimensions = size(targetValues, 1);    
    
    % Choose form of MLP:
    layersNeuronNo = [784 20 30 40 10];
    hiddenLayersNo = size(layersNeuronNo, 2) - 2;
    maxLayersNeuronNo = max(layersNeuronNo);

    % Choose appropriate parameters.
%     learningRate = .2;
    etaStartPoint = 1 / trainingSetSize * 10;
    etaEndPoint = 1 / trainingSetSize;
    intervalLength = etaEndPoint - etaStartPoint;
    intervalPercentage = .9;
    learningRate = etaStartPoint + intervalPercentage * intervalLength;
    
    momentum = 0.7;
    isMomentum = input('Use momentum or not? (true OR false)\n');
    
    actFuncType = input('Please insert activation function type: (0 for logisticSigmoid OR 1 for bipolarSigmoid)\n');
    if ~actFuncType
        activationFunction = @logisticSigmoid;
        activationFunctionDerivative = @logisticSigmoidDerivative;
    else    
        activationFunction = @bipolarSigmoid;
        activationFunctionDerivative = @bipolarSigmoidDerivative;
    end
    
    batchSize = 100;
    epochs = 20;
    
    weightMatrix = zeros(maxLayersNeuronNo, maxLayersNeuronNo, hiddenLayersNo + 1);
    errorMatrix = zeros(trainingSetSize / batchSize, epochs);    

    [weightMatrix, errorMatrix] = MLPonMNISTimagesTrain(activationFunction, activationFunctionDerivative, ...
        layersNeuronNo, mnistTrainDB, targetValues, epochs, batchSize, learningRate, momentum, isMomentum);
        
    % Load validation set.
    mnistTestDB = loadMNISTImages('t10k-images.idx3-ubyte');
    testTags = loadMNISTLabels('t10k-labels.idx1-ubyte');

    [correctlyClassified, classificationErrors, testErrorPercentage] = MLPonMNISTimagesTest(activationFunction, ...
        weightMatrix, mnistTestDB, testTags, layersNeuronNo);
     
    fprintf('Classification errors: %d\n', classificationErrors);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Test error percentage is: %0.5f\n', testErrorPercentage);
%     end