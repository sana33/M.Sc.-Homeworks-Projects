function [Jopt,bestSubset] = J_Optimal(Z,o)

X = Z{1,1}(:,1:end-1);
featFreq = Z{1,2};
if all(o~=1:10); o=10; end
n = size(X,1);
m = size(X,2);
switch o
    case 1
        Jopt = inf;
        for j1 = 1:n
            ol = X(j1,:);
            featFreq_new = featFreq;
            for k1 = 1:m
                featIdx = featFreq{1,k1}(:,1)==ol(:,k1);
                featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
            end
            [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
            if WHL<Jopt
                Jopt=WHL;
                featFreq = featFreqFunc(X(setdiff(1:n,j1),:));
                [OF,wghVec,Hvec,HL,WHL] = OF_Calc(X,featFreq,w);
                bestSubset=[j1];
            end
        end
end




candSubsets = combnk(1:n,o);
Jvec = zeros(size(candSubsets,1),1);

for k1 = 1:size(candSubsets,1)
    NSidx = setdiff(1:n,candSubsets(k1,:));
    [~,~,~,Jvec(k1),~] = WHL_Calc(X(NSidx,:));
end

[Jopt,JoptIdx] = min(Jvec,[],'omitnan');
bestSubset = candSubsets(JoptIdx,:);

end