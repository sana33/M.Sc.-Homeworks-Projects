clc, clear all, close all

%% Question02-A Answer
facesNo = 6; % Number of facets of the dice
experimentsNo = 10; % Dice rolling counts
facetSixProb = 1/3; % Probability quantity for facet 6
facetNonSixProb = (1 - facetSixProb) / 5; % Probability quantity for other facet
experiments = zeros(1, experimentsNo); % Initialize the experiments with zeros
experimentsWithFacetSix = rand(1, experimentsNo) < facetSixProb; % Setting indices for happening facet 6
experiments(experimentsWithFacetSix) = 6; % Setting six in the happening situations
otherFacetsNo = sum(~experimentsWithFacetSix); % Clarifying the total number of other facets happenings
experiments(~experimentsWithFacetSix) = randi(5, 1, otherFacetsNo); % Creating other facets number in the indices where six isn't happened
histAxisX = 1:facesNo; % x-axis for the histogram
histResults = hist(experiments, histAxisX); % Returns the distribution of experiments results among dice facets
normalizedHistResults = histResults / experimentsNo; % Normalizing histogram results
finalResults = [histResults; normalizedHistResults];
subplot(2, 2, 1);
bar(transpose(finalResults), 'grouped'); % Draws bars for each element in normalizedHistReults at locations specified in histAxisX
xlabel('Observed Face');
ylabel('Happening/NH Number');
legend('Happening Number', 'NH Number');
title('Question02-A  Answer');
grid on;

%% Question02-B Answer
truePmf = [facetNonSixProb*ones(1, 5), facetSixProb];
subplot(2, 2, 2);
bar(transpose(finalResults), 'grouped'); % Draws bars for each element in normalizedHistReults at locations specified in histAxisX
hold on;
plot(histAxisX, truePmf, '-sr', 'lineWidth', 2);
xlabel('Observed Face');
ylabel('Happening/NH Number and TruePMF');
legend('Happening Number', 'NH Number', 'TruePMF Plot');
title('Question02-B  Answer');
grid on;
subplot(2, 2, 3);
stairs(histAxisX, normalizedHistResults, '-ob', 'lineWidth', 2);
hold on;
stairs(histAxisX, truePmf, '-sr', 'lineWidth', 2);
xlabel('Observed Face');
ylabel('NH Number and TruePMF');
legend('NH Number Stairs', 'TruePMF Stairs');
title('Question02-B  Answer');
grid on;
subplot(2, 2, 4);
stem(histAxisX, normalizedHistResults, '-ob', 'lineWidth', 2);
hold on;
stem(histAxisX, truePmf, '-sr', 'lineWidth', 2);
xlabel('Observed Face');
ylabel('NH Number and TruePMF');
legend('NH Number Stem', 'TruePMF Stem');
title('Question02-B  Answer');
grid on;