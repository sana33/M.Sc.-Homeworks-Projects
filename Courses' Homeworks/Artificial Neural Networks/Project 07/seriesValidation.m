function [outputZvalid] = seriesValidation(validSet, validSetSize, contextInputs, weightsHidden, weightsContext, weightsOutput, actFunc)
contextInputsValid = ones(validSetSize, 1) * contextInputs;
hiddenInputsValid = validSet * weightsHidden + contextInputsValid * weightsContext;
hiddenOutputsValid = actFunc(hiddenInputsValid);
outputInValid = hiddenOutputsValid * weightsOutput;
outputZvalid = actFunc(outputInValid);