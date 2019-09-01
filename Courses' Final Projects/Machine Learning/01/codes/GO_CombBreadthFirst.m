function goProb = GO_CombBreadthFirst(goProbTot)
    clustIter = size(goProbTot,2);
    samplesNo = size(goProbTot,1);
    
%     goProbTot = NormalizeToZeroOne(goProbTot);
%     goProbTot = normc(goProbTot);
    
    [goProbSort, goProbSortInd] = sort(goProbTot,'descend');
    
    considered = false(samplesNo,1);
    indCount = 1;
    
    samplesInd = zeros(samplesNo,1);
    goProb = zeros(samplesNo,1);
    for i = 1:samplesNo
        for j = 1:clustIter
            if considered(goProbSortInd(i,j)) == 0
                samplesInd(indCount) = goProbSortInd(i,j);
                goProb(indCount) = goProbSort(i,j);
                indCount = indCount+1;
                considered(goProbSortInd(i,j)) = 1;
            end
            if indCount > samplesNo
                break;
            end
        end
    end
    goProb(samplesInd,:) = goProb;
end