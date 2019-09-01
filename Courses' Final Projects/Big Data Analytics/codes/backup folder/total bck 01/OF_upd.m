function [OF_new] = OF_upd(Hvec,osIdxFeatFreq,a,b,Xreduc,w)

Hvec_new = (1+b).*Hvec-(((a/b)-a)*log2(a)-(b+1)*log2(b))-a.*deltaFunc(osIdxFeatFreq);

n = size(Xreduc,1);
m = size(Xreduc,2);
featFreq = zeros(n,m);
for c1 = 1:m
    [~,~,freq,ic] = entCalc(Xreduc(:,c1));
    featFreq(:,c1) = freq(ic);
end

if w
    wghVec_new = sigmoidRev(Hvec_new);
else
    wghVec_new = ones(1,m);
end

wghMat_new = repmat(wghVec_new,n,1);
OF_new = sum(wghMat_new.*deltaFunc(featFreq),2);

end