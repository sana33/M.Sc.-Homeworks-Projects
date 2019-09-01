clear; close all; clc; warning off

graphKara = gml_read('karate.gml');

nodesNo = size(graphKara, 1);

gKaraBiog = biograph(graphKara);
gKaraBiog.LayoutType = 'equilibrium';
gKaraBiog.dolayout;

%% Complete influence per different values for threshold 'q'
qRange = 0.01:.01:.5; % different values for threshold 'q'

greedMaxInfl_PerQ = zeros(size(qRange)); % maximum influenced no. of nodes based on greedy approach for different 'q'
pageRankMaxInfl_PerQ = zeros(size(qRange)); % maximum influenced no. of nodes based on page-rank approach for different 'q'
outDegreeMaxInfl_PerQ = zeros(size(qRange)); % maximum influenced no. of nodes based on out-degree approach for different 'q'

for c1 = 1:length(qRange)

    greedInitSet = completeInflGreedy(graphKara, qRange(c1));
    greedMaxInfl_PerQ(c1) = sum(greedInitSet);

    pageRankInitSet = completeInflPageRank(graphKara, qRange(c1));
    pageRankMaxInfl_PerQ(c1) = sum(pageRankInitSet);

    outDegreeInitSet = completeInflOutDegree(graphKara, qRange(c1));
    outDegreeMaxInfl_PerQ(c1) = sum(outDegreeInitSet);

end

figure;
hold on; grid on;
title('Complete Influential Set of Nodes with Minimum Set Size per Q');
xlabel('q = threshold');
ylabel('Minimum Initial No. of Nodes for Complete Influence');
plot(qRange, greedMaxInfl_PerQ, 'r:', 'LineWidth', 2);
plot(qRange, pageRankMaxInfl_PerQ, 'b-.', 'LineWidth', 2);
plot(qRange, outDegreeMaxInfl_PerQ, 'g--', 'LineWidth', 2)
legend('Greedy', 'Page Rank', 'Degree');

%% Visualizing complete influence per different values for threshold 'q'
qRange = .01:.02:.1; % different values for threshold 'q'

for c1 = 1:length(qRange)

    greedInitSet = completeInflGreedy(graphKara, qRange(c1));
%     pageRankInitSet = completeInflPageRank(karate, qRange(c1));
%     outDegreeInitSet = completeInflOutDegree(karate, qRange(c1));

    for c2=1:nodesNo
        if greedInitSet(c2) == 1
%         if pageRankInitSet(c2) == 1
%         if outDegreeInitSet(c2) == 1
            gKaraBiog.Nodes(c2).Color = [.5 .8 .6];
            gKaraBiog.Nodes(c2).Shape = 'ellipse';
        else
            gKaraBiog.Nodes(c2).Color = [1 1 1];    
        end
    end

    view(gKaraBiog);

end
