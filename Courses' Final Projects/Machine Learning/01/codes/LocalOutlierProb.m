function [LoOPvalues, olClass] = LocalOutlierProb(dataSet, kValue, lambda)

    if nargin==1; kValue = 50; lambda=3; end
    if nargin==2; lambda = 3; end

    % Compute all nearest neighbors
    distTot = pdist2(dataSet,dataSet);

    % First row is just the indices of the points and the following rows
    % are considered as neighbors
    [NNdistTot, NNindTot] = sort(distTot);
    
    S = NNindTot(2:kValue+1,:);
    Sdist = NNdistTot(2:kValue+1,:);
    if kValue ~= 1
        sigma = sqrt(sum(Sdist.^2) ./ kValue);
    else
        sigma = Sdist;
    end
    
    % Calculating the Probabilistic Set Distance of all data samples
    pdist = lambda * sigma;

    % Expected value of nearest neighbors pdist values: E{s in
    % S(o)}[pdist(lambda,s,S(s))]
    if kValue ~= 1
        Epdist = mean(pdist(S));
    else
        Epdist = pdist(S);
    end
    
    % Calculating the Probabilistic Local Outlier Factor (PLOF)
    pdEpd = pdist./Epdist; pdEpd(isnan(pdEpd) | isinf(pdEpd)) = 0;
    plof = pdEpd - 1;
    
    % Normalizing the PLOF values
    if kValue ~= 1
        nplof = lambda * sqrt(mean(plof.^2));
    else
        nplof = lambda * plof;
    end
    
    % Calculating the Local Outlier Probability for each data sample
    erfContent = plof./(nplof * sqrt(2)); erfContent(isnan(erfContent) | isinf(erfContent)) = 0;
    LoOPvalues = erf(erfContent);
    LoOPvalues(LoOPvalues < 0) = 0;
    LoOPvalues = transpose(LoOPvalues);

    % Setting outlier threshold:
    olClass = LoOPvalues > .7;
end