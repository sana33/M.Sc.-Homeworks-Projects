clc, clear all, close all

% urnBalls = zeros(9, 1); % The urn containing the balls, three red balls at first
% urnBalls(4:6) = ones(3, 1); % Specifying the black balls
% urnBalls(7:9) = 2 * ones(3, 1); % Specifying the three white balls

experimentsNo = 10000; % Number of choosing a ball

experiments = randi(9, experimentsNo, 1); % Experiments results

redProb = zeros(1000, 1);
blackProb = zeros(1000, 1);
whiteProb = zeros(1000, 1);

for ii = 1:1000
    randSelections = randsample(experimentsNo, 6, true); % Chooses 6 random indices from experiments
    sixDraws = experiments(randSelections);
    
    redResults = sum(sixDraws == 1);
    redResults = redResults + sum(sixDraws == 2);
    redResults = redResults + sum(sixDraws == 3);
    redProb(ii) = redResults / 6;

    blackResults = sum(sixDraws == 4);
    blackResults = blackResults + sum(sixDraws == 5);
    blackResults = blackResults + sum(sixDraws == 6);
    blackProb(ii) = blackResults / 6;

    whiteResults = sum(sixDraws == 7);
    whiteResults = whiteResults + sum(sixDraws == 8);
    whiteResults = whiteResults + sum(sixDraws == 9);
    whiteProb(ii) = whiteResults / 6;
end

finalRedProb = mean(redProb);
redNo = round(finalRedProb * 6);

finalBlackProb = mean(blackProb);
blackNo = round(finalBlackProb * 6);

finalWhiteProb = mean(whiteProb);
whiteNo = round(finalWhiteProb * 6);

totalProb = finalRedProb + finalBlackProb + finalWhiteProb;

fprintf('The probability of choosing red ball is: \t%0.5f\t so the most likely number of red ball is: \t%d\n\tThe probability of choosing black ball is: \t%0.5f\t so the most likely number of black ball is: \t%d\n\t\tThe probability of choosing white ball is: \t%0.5f\t so the most likely number of white ball is: \t%d\n\t\t\tThe total probability is: \t%0.5f\n', finalRedProb, redNo, finalBlackProb, blackNo, finalWhiteProb, whiteNo, totalProb);
