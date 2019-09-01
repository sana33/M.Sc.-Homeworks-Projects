function [clustIdx, rankMat] = pageRankPersonClust(adjMat, clustNo, beta)
nodesNo = length(adjMat);
rankMat = zeros(nodesNo);

for c1 = 1:nodesNo
    rankMat(:,c1) = pageRankTopicSens(adjMat, c1, beta);
end

clustIdx = kmeans(rankMat, clustNo, 'Distance', 'cosine', 'EmptyAction', 'drop', 'Replicates', 5);