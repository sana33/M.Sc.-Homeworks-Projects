clc, clear all, close all

experimentsNo = 1000;
mu = input('Please enter the mu value:\n');
variance = input('Please enter the variance value:\n');
Z = randn(experimentsNo, 1);
X = zeros(experimentsNo, 1);
normalMean = zeros(experimentsNo, 1);
sampleMean = zeros(experimentsNo, 1);

for ii = 1:experimentsNo
    X(ii) = mu + sqrt(ii * variance) * Z(ii);
    sampleMean(ii) = mean(X(1:ii));
    normalMean(ii) = mean(Z(1:ii));
    figure(1);
    sm = subplot(1, 2, 1);
    plot(sampleMean, 'b');
    grid on;
    nm = subplot(1, 2, 2);
    plot(normalMean, 'r');
    grid on;
end

xlabel(sm, 'Experiments Count');
ylabel(sm, 'Sample Mean');
legend(sm, 'Sample Mean');
title(sm, 'Sample Mean Diagram');

xlabel(nm, 'Experiments Count');
ylabel(nm, 'Normal Mean');
legend(nm, 'Normal Mean');
title(nm, 'Normal Mean Diagram');
