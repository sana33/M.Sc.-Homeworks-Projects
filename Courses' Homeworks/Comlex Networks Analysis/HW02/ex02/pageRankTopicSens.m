function [rankVecFinal] = pageRankTopicSens(adjMat, topicIdx, beta)
    nodesNo = length(adjMat);
    degOutVec = sum(adjMat, 2);
    degInVec = sum(adjMat, 1);
    transMat = transpose(adjMat ./ repmat(degOutVec, 1, nodesNo));
    transMat(isnan(transMat) | isinf(transMat)) = 0;
    eS = zeros(nodesNo,1);
    eS(topicIdx) = 1;
    rankVec = zeros(nodesNo,1);
    rankVec(topicIdx) = 1/length(topicIdx);
    eSfinal = (1-beta) .* eS ./ length(topicIdx);
    iter = 1;

    while true
        rankVecPrm = beta .* transMat * rankVec + eSfinal;
        rankVecPrm(degInVec==0) = 0;
        rankVecPrm = rankVecPrm + (1 - sum(rankVecPrm)) ./ nodesNo;
        rankVecFinal = rankVecPrm;
        iter = iter + 1;
        if sum(abs(rankVecPrm - rankVec)) < 1e-20
            break;
        else
            rankVec = rankVecPrm;
        end
        if iter > 10000; break; end;
    end
end