function optimumSet = MaximumInflGreedy(adjMat, q, K)
  nodesNo = length(adjMat);
  optimumSet = zeros(1, nodesNo);
  for c1=1:K
    bestIndex = 0;
    bestGain = 0;
    for c2 = 1:nodesNo
      if optimumSet(c2) ~= 1
        tempSet = optimumSet;
        tempSet(c2) = 1;
        gain = sum(cascadeInfluence(adjMat, tempSet, q));
        if gain > bestGain
          bestGain = gain;
          bestIndex = c2;
        end
      end
    end
    optimumSet(bestIndex) = 1;
  end
end