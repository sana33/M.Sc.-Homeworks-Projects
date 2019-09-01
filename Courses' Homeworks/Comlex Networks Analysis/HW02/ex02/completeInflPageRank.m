function optimumSet = completeInflPageRank(adjMat, q)
  nodesNo = length(adjMat);
  rankVec = pageRankTopicSens(adjMat, 1:length(adjMat), .8);
  [~, Index] = sort(rankVec, 'descend');
%   [~, Index] = sort(rank);
  optimumSet = zeros(1, nodesNo);
  pointer = 1;
  finished = false;
  while ~finished
    optimumSet(Index(pointer)) = 1;
    pointer = pointer + 1;
    if sum(cascadeInfluence(adjMat, optimumSet, q)) == nodesNo
      finished = true;
    end
  end
end