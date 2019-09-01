function [misClassified, correctlyClassified, classificationError] = rbfTest(testDataset, testTags, weightMatrix)
classificationError = zeros(2, 1);
testOutput = testDataset * weightMatrix;
[testOutputValue, testOutputClass] = max(testOutput, [], 2);
[testTagValue, testTagClass] = max(testTags, [], 2);
correctlyClassified = sum(testOutputClass == testTagClass);
misClassified = sum(testOutputClass ~= testTagClass);
classificationError(1) = mean(sum((testOutput - testTags) .^ 2, 2));
classificationError(2) = misClassified ./ size(testDataset, 1);
