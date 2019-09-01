function optimumSet = completeInflGreedy(adjMat, q)
  nodesNo = length(adjMat);
  optimumSet = zeros(1, nodesNo);
  finished = false;
  while ~finished
    bestIndex = 0;
    bestGain = 0;
    for c1 = 1:nodesNo
      if optimumSet(c1) ~= 1
        tempSet = optimumSet;
        tempSet(c1) = 1;
        gain = sum(cascadeInfluence(adjMat, tempSet, q));
        if gain > bestGain
          bestGain = gain;
          bestIndex = c1;
        end
      end
    end
    optimumSet(bestIndex) = 1;
    if bestGain == nodesNo
      finished = true;
    end
  end
end