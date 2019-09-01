function [OF_new] = OF_upd(X,Hvec,featFreq,a,b,olIdx,w)

n = size(X,1);
m = size(X,2);
ol = X(olIdx,:);
featFreq_upd = featFreq;
olFeatFreq = zeros(1,m);
for k1 = 1:m
    featIdx = featFreq{1,k1}(:,1)==ol(k1);
    olFeatFreq(k1) = featFreq{1,k1}(featIdx,2);
    featFreq_upd{1,k1}(featIdx,2) = olFeatFreq(k1)-1;
end
Hvec_new = (1+b).*Hvec-(((a/b)-a)*log2(a)-(b+1)*log2(b))-a.*deltaFunc(olFeatFreq);

featFreqMat = featFreqMatMaker(X([1:olIdx-1 olIdx+1:end],:),featFreq_upd);

if w
    wghVec_new = sigmoidRev(Hvec_new);
else
    wghVec_new = ones(1,m);
end

wghMat_new = repmat(wghVec_new,n-1,1);
OF_new = sum(wghMat_new.*deltaFunc(featFreqMat),2);

end