function optimumSet = MaximumInflPageRank(adjMat, q, K)
    % 'q' is a useless value for this approach
    nodesNo = length(adjMat);
    rankVec = pageRankTopicSens(adjMat, 1:length(adjMat), .8);
    [~, Index] = sort(rankVec, 'descend');
    optimumSet = zeros(1, nodesNo);
    optimumSet(Index(1:K)) = 1;
end