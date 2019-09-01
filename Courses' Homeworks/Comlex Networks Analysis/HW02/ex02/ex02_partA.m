clear; close all; clc; warning off

graphKara = gml_read('karate.gml');

%% Maximum influence per different values for threshold 'q'
K = 5; % no. of needed nodes for maximum influence
qRange = 0:.01:.15; % different values for threshold 'q'

greedMaxInfl_PerQ = zeros(size(qRange)); % maximum influenced no. of nodes based on greedy approach for different 'q'
pageRankMaxInfl_PerQ = zeros(size(qRange)); % maximum influenced no. of nodes based on page-rank approach for different 'q'
outDegreeMaxInfl_PerQ = zeros(size(qRange)); % maximum influenced no. of nodes based on out-degree approach for different 'q'

% summation of time spent on different algorithms
greedToc = 0; % greedy approach spent time
pageRankToc = 0; % page-rank approach spent time
outDegreeToc = 0; % out-degree approach spent time

for c1 = 1:length(qRange)

    tic;
    greedInitSet = MaximumInflGreedy(graphKara, qRange(c1), K);
    greedToc = greedToc + toc;
    greedMaxInfl_PerQ(c1) = sum(cascadeInfluence(graphKara, greedInitSet, qRange(c1)));

    tic;
    pageRankInitSet = MaximumInflPageRank(graphKara, qRange(c1), K);
    pageRankToc = pageRankToc + toc;
    pageRankMaxInfl_PerQ(c1) = sum(cascadeInfluence(graphKara, pageRankInitSet, qRange(c1)));

    tic;
    outDegreeInitSet = MaximumInflOutDegree(graphKara, qRange(c1), K);
    outDegreeToc = outDegreeToc + toc;
    outDegreeMaxInfl_PerQ(c1) = sum(cascadeInfluence(graphKara, outDegreeInitSet, qRange(c1)));

end

disp(['* Average time spent on each algorithm (s)*'])
disp(['Greedy influence maximization: ' num2str(greedToc / length(qRange))])
disp(['PageRank based influence maximization: ' num2str(pageRankToc / length(qRange))])
disp(['Degree based influence maximization: ' num2str(outDegreeToc / length(qRange))])

figure;
hold on; grid on;
title('(Maximum Influence per Q)');
xlabel('q = threshold');
ylabel('Maximum Influenced No. of Nodes');
plot(qRange, greedMaxInfl_PerQ, 'r:', 'LineWidth', 2);
plot(qRange, pageRankMaxInfl_PerQ, 'b-.', 'LineWidth', 2);
plot(qRange, outDegreeMaxInfl_PerQ, 'g', 'LineWidth', 1.1)
legend('Greedy', 'Page Rank', 'Degree');

%% Maximum influence per different values for 'K'
greedMaxInfl_PerK = zeros(1,20); % maximum influenced no. of nodes based on greedy approach for different 'K'
pageRankMaxInfl_PerK = zeros(1,20); % maximum influenced no. of nodes based on page-rank approach for different 'K'
outDegreeMaxInfl_PerK = zeros(1,20); % maximum influenced no. of nodes based on out-degree approach for different 'K'

q = .1; % initial value for threshold 'q'

for K=1:20

    greedInitSet = MaximumInflGreedy(graphKara, q, K);
    greedMaxInfl_PerK(K) = sum(cascadeInfluence(graphKara, greedInitSet, q));

    pageRankInitSet = MaximumInflPageRank(graphKara, q, K);
    pageRankMaxInfl_PerK(K) = sum(cascadeInfluence(graphKara, pageRankInitSet, q));

    outDegreeInitSet = MaximumInflOutDegree(graphKara, q, K);
    outDegreeMaxInfl_PerK(K) = sum(cascadeInfluence(graphKara, outDegreeInitSet, q));

end

figure;
hold on; grid on;
title('(Maximum Influence per K)');
xlabel('K Most Influential Nodes');
ylabel('Maximum Influenced No. of Nodes');
plot(1:20,greedMaxInfl_PerK, 'r-*');
plot(1:20,pageRankMaxInfl_PerK, 'b-+');
plot(1:20,outDegreeMaxInfl_PerK, 'g-o');
legend('Greedy', 'PageRank', 'Degree')
