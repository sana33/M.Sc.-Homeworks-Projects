clc, clear all, close all

experimentsNo = 1000000; % Number of experiments
stdBd = zeros(23, 1); % Initialize students birthdays
randBds = randi(365, 365, 1); % Randomize birthday vector
stdRandBds = zeros(23, 1); % Initialize students random birthday vector
sameBdCounter = 0; % Same birthday counter

for ii = 1:experimentsNo
    stdRandBds = randsample(randBds, 23, true); % Choosing random birthdays from 365 days of a year with replacement
    stdBd1stJanCount = sum(stdRandBds == 1); % Counting January 1 birthday
    if stdBd1stJanCount > 1
        sameBdCounter = sameBdCounter + 1;
    end
end

sameBdProb = sameBdCounter / experimentsNo; % Calculating probability of having the same birthday on January 1 among 23 students

fprintf('The probability of having the same birthday for 2 or more students is: \t%0.5f\n', sameBdProb);
