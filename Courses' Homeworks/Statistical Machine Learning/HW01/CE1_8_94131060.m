clc, clear all, close all

% urnBalls = zeros(6, 1); % The urn containing the balls, four red balls at first
% urnBalls(5:6) = ones(2, 1); % Specifying the black balls

experimentsNo = 10000; % Number of choosing a ball

experiments = randi(6, experimentsNo, 1); % Experiments results

successCounter = 0; % Success counter for obtaining one red ball and one black ball in any order
% possibleDraws = zeros(experimentsNo, 2);

for ii = 1:experimentsNo
    randSelections = randsample(experimentsNo, 2, false); % Chooses 6 random indices from experiments
    twoDraws = experiments(randSelections);
    
    cond = (sum(twoDraws == 1) == 1 || sum(twoDraws == 2) == 1 || sum(twoDraws == 3) == 1 ...
        || sum(twoDraws == 4) == 1) && (sum(twoDraws == 5) == 1 || sum(twoDraws == 6) == 1);
    
    if cond
        successCounter = successCounter + 1;
    end
end

finalProb = successCounter / experimentsNo;

fprintf('The probability of obtaining one red ball and one black ball in any order is: \t%0.5f\n', finalProb);
