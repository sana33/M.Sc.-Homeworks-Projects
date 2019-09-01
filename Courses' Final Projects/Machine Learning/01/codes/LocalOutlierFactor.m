function [lofValues, olClass, lofKmat] = LocalOutlierFactor(dataset, minPtsLB, minPtsUB, kStep, theta)
    
    % Less no. of arguments issue handling
    if nargin==1; minPtsLB = 10; minPtsUB = 50; kStep = 1; theta = 2; end
    if nargin==2; if minPtsLB<=50; minPtsUB = 50; end; kStep = 1; theta = 2; end
    if nargin==3; kStep = 1; theta = 2; end
    if nargin==4; theta = 2; end
    
    samplesNo = size(dataset,1);
    if kStep==0; kStep=1; end
    kVals = minPtsLB:kStep:minPtsUB;
    kCount = length(kVals);
    lofKmat = zeros(samplesNo, kCount);

    % calculate k-distances and k-distance neighborhoods and local
    % reachability density for samples in dataset according to different
    % values of k
    kDistNeighb = cell(samplesNo, kCount);
    distTot = pdist2(dataset,dataset);
    [sDist, sDistInd] = sort(distTot,2);
    kDistances = sDist(:,kVals+1);
    lrdK = zeros(samplesNo, kCount);
    for c1 = 1:samplesNo
        for c2 = 1:kCount
            kDistNbInd = find(sDist(c1,:) <= kDistances(c1,c2));
            kDistNeighb{c1,c2} = sDistInd(c1, kDistNbInd(2:end));
            lrdK(c1,c2) = length(kDistNeighb{c1,c2}) ./ sum(max(kDistances(kDistNeighb{c1,c2},c2), ...
                distTot(kDistNeighb{c1,c2},c1)));
        end
    end
    
    % Calculating lofKmat containing calculated LOF values for each k value
    % (number of neighbors). Each column represents dataset samples LOF
    % values for a certain k.
    for c1 = 1:samplesNo
        for c2 = 1:kCount
            lofKmat(c1,c2) = sum(lrdK(kDistNeighb{c1,c2},c2)) ./ (lrdK(c1,c2) .* length(kDistNeighb{c1,c2}));
        end
    end
    lofKmat(isnan(lofKmat) | isinf(lofKmat)) = 0;

    % Setting final lof value by taking the maximum value of LOFs computed
    % by different values of k
    lofValues = max(lofKmat,[],2);

    % Calculating the lof class or the value for being an outlier(=1) or
    % not(=0)
    olClass = double(lofValues > theta);
end
