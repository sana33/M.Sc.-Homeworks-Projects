function [outputZtest] = seriesTesting(hObject, handles, testSet, testSetSize, contextInputs, weightsHidden, weightsContext, ...
    weightsOutput, actFunc, estimateEvalCriterion)
% This function performs a test according to gained net weights given to
% the this function
contextInputsTest = contextInputs;
outputZtest = zeros(testSetSize-1, 1);
for k1 = 1:testSetSize-1
    hiddenInputsTest = testSet(k1) * weightsHidden + contextInputsTest * weightsContext;
    hiddenOutputsTest = actFunc(hiddenInputsTest);
    contextInputsTest = hiddenOutputsTest;
    outputInTest = hiddenOutputsTest * weightsOutput;
    outputZtest(k1) = actFunc(outputInTest);
end

errorMSEtest = (1/(testSetSize-1))*sum((testSet(2:end) - outputZtest) .^ 2);
errorMAEtest = (1/(testSetSize-1))*sum(abs(testSet(2:end) - outputZtest));
errorRMAEtest = (1/mean(testSet(2:end)))*errorMAEtest;
errorPItest = 1 - ((testSetSize-1)*errorMSEtest)/(sum((testSet(3:end) - testSet(2:end-1)) .^ 2));

switch estimateEvalCriterion
    case 'mse_radioButton'
        set(handles.test_error_editText, 'String', num2str(errorMSEtest));
    case 'mae_radioButton'
        set(handles.test_error_editText, 'String', num2str(errorMAEtest));
    case 'rmae_radioButton'
        set(handles.test_error_editText, 'String', num2str(errorRMAEtest));
    case 'pi_radioButton'
        set(handles.test_error_editText, 'String', num2str(errorPItest));
end

guidata(hObject, handles);