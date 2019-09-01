function [goFactor, goProb] = GlobalOutlierFactProb(dataset, clustNo, distType)
    
    switch distType
        case 'sqeuclidean'
            [idx,~,~,centDist] = kmeans(dataset, clustNo, 'Distance', 'sqeuclidean', 'Replicates', 5);
        case 'cosine'
            [idx,~,~,centDist] = kmeans(dataset, clustNo, 'Distance', 'cosine', 'Replicates', 5);
    end
    
    goFactor = zeros(size(dataset,1),1);
    goProb = zeros(size(dataset,1),1);
    centMaxDist = zeros(clustNo,1);
    for c1 = 1:clustNo
        goFactor(idx==c1) = centDist(idx==c1,c1);
        centMaxDist(clustNo) = max(centDist(idx==c1,c1));
        goProb(idx==c1) = goFactor(idx==c1) ./ centMaxDist(clustNo);
    end
    
end

