function [correctlyClassified, classificationErrors, testErrorPercentage] = MLPonMNISTimagesTest(activationFunction, ...
    weightMatrix, mnistTestDB, testTags, layersNeuronNo)

    neuronsPerLayer = layersNeuronNo;
    tempOutput = transpose(mnistTestDB);
    calcLength = size(weightMatrix, 3);
    
    for ii = 1:calcLength
        tempInput = tempOutput * weightMatrix(1:neuronsPerLayer(ii), 1:neuronsPerLayer(ii + 1), ii);
        tempOutput = activationFunction(tempInput);
    end
    
    tempOutput = transpose(tempOutput);
    maxRowVector = max(tempOutput);
    testOutputClass = zeros(1, size(tempOutput, 2));
    
    for jj = 1:size(tempOutput, 2)
        testOutputClass(jj) = find(tempOutput(:, jj) == maxRowVector(jj), 1, 'first') - 1;
    end
    
    testOutputClass = transpose(testOutputClass);
    
    correctlyClassified = sum(testOutputClass == testTags);
    classificationErrors = sum(testOutputClass ~= testTags);
    
    testErrorPercentage = classificationErrors / (correctlyClassified + classificationErrors);
end