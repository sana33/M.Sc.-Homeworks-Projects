
fileName = 'Bource_Data.xlsx';
sheet = 1;
xlRange = 'C:C';
logValues = xlsread(fileName, sheet, xlRange);
alpha = input('Please enter the desired value for error rate (alpha):\n'); % The suggested value is .05
windowLength = input('Please insert the desired value for the Moving Window size:\n'); % The suggested size is 201
success = 0;
counter = 1;
indexLow = 1;
indexHigh = indexLow + windowLength - 1;
while indexHigh < length(logValues)-1
    indexHigh = indexLow + windowLength - 1;
    dataOnProcess = sort(logValues(indexLow:indexHigh));
    VaRisk = quantile(dataOnProcess, alpha);
    if VaRisk <= logValues(indexHigh+1)
        success = success + 1;
    end
    alphaGained = (counter - success) ./ counter;
    counter = counter + 1;
    indexLow = indexLow + 1;
end
fprintf('\nThe desired value for alpha is:\n\t%6.4f\nThe gained value for alpha is:\n\t%6.4f\n', alpha, alphaGained);
