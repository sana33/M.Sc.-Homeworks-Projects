function [scores, olClass, aucIter, aucTot] = FeatureBagging(dataset, olLabel, baseMethod, iter, combType, minPtsLB, minPtsUB, kStep, theta)

    samplesNo = size(dataset,1);
    dataDim = size(dataset,2);
    aucIter = zeros(iter,1);
    
    olScores = zeros(samplesNo, iter);
    for c1 = 1:iter
        % Select a randomly selected set of features
        featCount = randi([floor(dataDim./2) (dataDim-1)]);
        featSelect = randperm(dataDim,featCount);
        dsFeatReduc = dataset(:,featSelect);
        
        % Get LOF or LoOP score for each data sample
        if strcmpi(baseMethod,'LOF') == 1
            [scoreValues, ~, ~] = LocalOutlierFactor(dsFeatReduc, minPtsLB, minPtsUB, kStep, theta);
        elseif strcmpi(baseMethod,'LoOP') == 1
            kVals = minPtsLB:kStep:minPtsUB;
            scoreValues = [];
            for c2 = 1:length(kVals)
                [scoreValuesTmp, ~] = LocalOutlierProb(dsFeatReduc, kVals(c2));
                scoreValues = [scoreValues, scoreValuesTmp];
            end
            scoreValues = max(scoreValues,[],2);
        end
        olScores(:,c1) = scoreValues;
        [~,~,~,aucIter(c1)] = perfcurve(olLabel, scoreValues, 1);
    end
    % Combine scores
    if strcmpi(combType,'BreadthFirst') == 1
        scores = CombBreadthFirst(olScores);
    elseif strcmpi(combType,'CumulativeSum') == 1
        scores = CombCumulativeSum(olScores);
    end
    [~,~,~,aucTot] = perfcurve(olLabel, scores, 1);
    olClass = double(scores > theta);
end

function samplesScores = CombBreadthFirst(olScores)
    iter = size(olScores,2);
    samplesNo = size(olScores,1);
    
%     olScores = NormalizeToZeroOne(olScores);
    olScores = normc(olScores);
    
    [olsSort, olsSortInd] = sort(olScores,'descend');
    
    considered = false(samplesNo,1);
    indCount = 1;
    
    samplesInd = zeros(samplesNo,1);
    samplesScores = zeros(samplesNo,1);
    for i = 1:samplesNo
        for j = 1:iter
            if considered(olsSortInd(i,j)) == 0
                samplesInd(indCount) = olsSortInd(i,j);
                samplesScores(indCount) = olsSort(i,j);
                indCount = indCount+1;
                considered(olsSortInd(i,j)) = 1;
            end
            if indCount > samplesNo
                break;
            end
        end
    end
    samplesScores(samplesInd,:) = samplesScores;
end

function scores = CombCumulativeSum(olScores)
%     scores = sum(olScores, 2) ./ size(olScores,2);
    scores = mean(olScores, 2);
    scores(isnan(scores) | isinf(scores)) = 0;
end