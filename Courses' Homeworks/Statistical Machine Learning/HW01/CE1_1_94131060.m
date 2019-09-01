clc, clear all, close all

%% Question01-A Answer
facesNo = 6; % Number of faces of the dice
experimentsNo = 10; % Dice rolling counts
experiments = randi(facesNo, 1, experimentsNo); % Experiments results
histAxisX = 1:facesNo; % x-axis for the histogram
histResults = hist(experiments, histAxisX); % Returns the distribution of experiments results among dice faces

figure(1); % Opens a new figure for showing Q1-A results
subplot(2, 2, 1);
bar(histAxisX, histResults); % Draws bars for each element in histResults at locations specified in histAxisX
xlabel('Observed Face');
ylabel('Happening Number');
title('Question01-A  Answer');
grid on;

%% Question01-B Answer
normalizedHistResults= histResults / experimentsNo; % Normalizing the distribution amounts with experiments number

subplot(2, 2, 2);
bar(histAxisX, normalizedHistResults); % Draws bars for each element in normalizedHistReults at locations specified in histAxisX
hold on;
realPmf = ones(1, facesNo) / facesNo;
bar(histAxisX, realPmf, 'barWidth', 0.456, 'faceColor', [.23 .64 .37]);
xlabel('Observed Face');
ylabel('NormalizedHappening/RealPDF Number');
legend('NH Number', 'RealPDF');
title('Question01-B Answer');
grid on;

%% Question01-C Answer
experimentsNo = 10; % Dice rolling counts
experimentsRepetition = zeros(4, experimentsNo);
histResults = zeros(4, facesNo);
normalizedHistResults = zeros(4, facesNo);
realPmf = ones(1, facesNo) / facesNo;
normalizedHistResults = [normalizedHistResults; realPmf];
histAxisX = 1:facesNo; % x-axis for the histogram

for ii= 1: 4
    experimentsRepetition(ii, :) = randi(facesNo, 1, experimentsNo); % Experiments results
    histResults(ii, :) = hist(experimentsRepetition(ii, :), histAxisX); % Returns the distribution of experiments results among dice faces
    normalizedHistResults(ii, :) = histResults(ii, :) / experimentsNo; % Normalizing the distribution amounts with experiments number
end

subplot(2, 2, 3);
bar(transpose(normalizedHistResults), 'grouped'); % Draws bars for each element in normalizedHistReults at locations specified in histAxisX
xlabel('Observed Face');
ylabel('NormalizedHappenings/RealPDF Number');
legend('NH1 Number', 'NH2 Number', 'NH3 Number', 'NH4 Number', 'RealPDF Number');
title('Question01-C Answer');
grid on;

%% Question01-D Answer
experimentsNo = 10000; % Dice rolling counts
experimentsRepetition = zeros(4, experimentsNo);
histResults = zeros(4, facesNo);
normalizedHistResults = zeros(4, facesNo);
realPmf = ones(1, facesNo) / facesNo;
normalizedHistResults = [normalizedHistResults; realPmf];
histAxisX = 1:facesNo; % x-axis for the histogram

for ii= 1: 4
    experimentsRepetition(ii, :) = randi(facesNo, 1, experimentsNo); % Experiments results
    histResults(ii, :) = hist(experimentsRepetition(ii, :), histAxisX); % Returns the distribution of experiments results among dice faces
    normalizedHistResults(ii, :) = histResults(ii, :) / experimentsNo; % Normalizing the distribution amounts with experiments number
end

subplot(2, 2, 4);
bar(transpose(normalizedHistResults), 'grouped'); % Draws bars for each element in normalizedHistReults at locations specified in histAxisX
xlabel('Observed Face');
ylabel('NormalizedHappenings/RealPDF Number');
legend('NH1 Number', 'NH2 Number', 'NH3 Number', 'NH4 Number', 'RealPDF Number');
title('Question01-D Answer');
grid on;