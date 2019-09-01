clc, clear all, close all

successProb = 0.25; % The cessation condition and the probability of rolling head
experimentsNo = 1000;
successVector = zeros(experimentsNo, 1);

for cc = 1:experimentsNo
    kk = 1;
    while(rand(1, 1) > 0.25)
        kk = kk + 1;
    end
    successVector(cc) = kk;
end

observedPMF = zeros(20, 1);
truePMF = zeros(20, 1);

for dd = 1:20
    observedPMF(dd) = sum(successVector == dd) / experimentsNo;
    truePMF(dd) = successProb * (1 - successProb) .^ (dd - 1);
end

finalPmfResults = [observedPMF, truePMF];

subplot(1, 2, 1);
bar(finalPmfResults, 'grouped');
xlabel('Success Rate');
ylabel('Observed/True PMF');
legend('Observed PMF', 'True PMF');
title('Final PMF Results');
grid on;

observedCDF = cumsum(observedPMF);
trueCDF = cumsum(truePMF);
% observedCDF = zeros(20, 1);
% trueCDF = zeros(20, 1);
% for ee = 1:20
%     observedCDF(ee) = sum(observedPMF(1:ee));
%     trueCDF(ee) = sum(truePMF(1:ee));
% end

finalCdfResults = [observedCDF, trueCDF];

subplot(1, 2, 2);
bar(finalCdfResults, 'grouped');
xlabel('Success Rate');
ylabel('Observed/True CDF');
legend('Observed CDF', 'True CDF');
title('Final CDF Results');
grid on;

averageSuccessRate = sum(successVector) / experimentsNo;
fprintf('The average value for success rate is:\t %0.5f\n\n', averageSuccessRate);

probXGt4 = 1 - sum(observedCDF(4));
fprintf('The probability that X > 4:\t %0.5f\n\n', probXGt4);
