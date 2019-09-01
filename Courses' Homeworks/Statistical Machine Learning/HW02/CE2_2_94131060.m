clc, clear all, close all;

mean = .5;
exponRndNumbers = exprnd(.5, 100, 1);

%% Calculating and plotting empirical distribution function
exponRndNumbersSorted = sort(exponRndNumbers);
expPDF = zeros(100, 1);
expCDF = zeros(100, 1);
for ii = 1:100
    expPDF(ii) = sum(exponRndNumbersSorted == exponRndNumbersSorted(ii)) ./ 100;
    expCDF(ii) = sum(expPDF(1:ii));
end
figure(1);
stairs(exponRndNumbersSorted, expCDF, 'r', 'LineWidth', 2);
grid on;
hold on;
axisX = 0:.1:max(exponRndNumbersSorted);
exponCDF = cdf('Exponential', axisX, mean);
plot(axisX, exponCDF, 'b');
xlabel('Exponential Data Points');
ylabel('Exponential CDF');
legend('Empirical Distribution Function', 'Cumulative Distribution Function');

%% Finding the plug-in estimators
meanEst = sum(exponRndNumbers) ./ 100;
varEst1 = sum((exponRndNumbers - meanEst) .^ 2) ./ 100;
varEst2 = sum((exponRndNumbers - meanEst) .^ 2) ./ 99;
skewness = (sum((exponRndNumbers - meanEst) .^ 3) ./ 100) ./ (varEst1 .^ (3 ./ 2));
fprintf('The plug-in estimator for mean value is: \t%.4f\n', meanEst);
fprintf('The plug-in estimator for variance type 1 value is: \t%.4f\n', varEst1);
fprintf('The plug-in estimator for variance type 2 value is: \t%.4f\n', varEst2);
fprintf('The plug-in estimator for skewness value is: \t%.4f\n', skewness);
