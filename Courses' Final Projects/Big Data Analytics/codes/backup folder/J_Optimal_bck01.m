function [Jopt,bestSubset] = J_Optimal(X,o)

n = size(X,1);
candSubsets = combnk(1:n,o);
Jvec = zeros(size(candSubsets,1),1);

for k1 = 1:size(candSubsets,1)
    NSidx = setdiff(1:n,candSubsets(k1,:));
    [~,~,~,Jvec(k1),~] = WHL_Calc(X(NSidx,:));
end

[Jopt,JoptIdx] = min(Jvec,[],'omitnan');
bestSubset = candSubsets(JoptIdx,:);

end