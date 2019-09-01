function [OF,wghVec,Hvec,HL,WHL,featFreq] = OF_Calc(X,w)

n = size(X,1);
[wghVec,Hvec,HL,WHL,featFreq] = WHL_Calc(X,w);
wghMat = repmat(wghVec,n,1);

OF = sum(wghMat.*deltaFunc(featFreq),2);

end