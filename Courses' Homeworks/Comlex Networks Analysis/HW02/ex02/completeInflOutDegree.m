function optimumSet = completeInflOutDegree(adjMat, q)
  nodesNo = length(adjMat);
  outDegVec = sum(adjMat, 2);
  [~, Index] = sort(outDegVec, 'descend');
  optimumSet = zeros(1, nodesNo);
  pointer = 1;
  while sum(cascadeInfluence(adjMat, optimumSet, q)) ~= nodesNo
    optimumSet(Index(pointer)) = 1;
    pointer = pointer + 1;
  end
end