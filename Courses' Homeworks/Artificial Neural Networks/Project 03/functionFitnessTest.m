function [correctlyClassified, classificationErrors, testErrorPercentage] = functionFitnessTest(activationFunction, ...
    weightMatrix, testDataset, testTags, layersNeuronNo)

    neuronsPerLayer = layersNeuronNo;
    tempOutput = testDataset;
    calcLength = size(weightMatrix, 3);
    
    for ii = 1:calcLength
        tempInput = tempOutput * weightMatrix(1:neuronsPerLayer(ii), 1:neuronsPerLayer(ii + 1), ii);
        tempOutput = activationFunction(tempInput);
    end
    
    correctlyClassified = sum(abs(tempOutput - testTags) < .01);
    classificationErrors = sum(abs(tempOutput - testTags) >= .01);
    
    testErrorPercentage = classificationErrors / (correctlyClassified + classificationErrors);
end