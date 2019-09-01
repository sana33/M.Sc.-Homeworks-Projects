function optimumSet = MaximumInflOutDegree(adjMat, q, K)
    % 'q' is a useless value for this approach
    nodesNo = length(adjMat);
    outDegVec = sum(adjMat, 2);
    [~, Index] = sort(outDegVec, 'descend');
    optimumSet = zeros(1, nodesNo);
    optimumSet(Index(1:K)) = 1;
end