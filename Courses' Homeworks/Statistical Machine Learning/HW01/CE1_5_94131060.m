clc, clear all, close all

experimentsNo = 100000; % Number of flipping a coin n times in each experiment
experFallHead = zeros(experimentsNo, 1); % Number of falling head in each experiment

for ii = 1:experimentsNo
    experFallHead(ii) = binornd(100, 0.05);
end

experFallHeadAverage = mean(experFallHead); % Average of falling head on the whole experiments

fprintf('The average value of falling head on the whole experiments is: \t%0.5f\n', experFallHeadAverage);
