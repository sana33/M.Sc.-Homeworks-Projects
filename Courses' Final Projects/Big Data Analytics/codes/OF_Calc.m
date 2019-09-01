function [OF,wghVec,Hvec,HL,WHL] = OF_Calc(X,featFreq,w)

n = size(X,1);
m = size(X,2);
[wghVec,Hvec,HL,WHL] = WHL_Calc(featFreq,w);

wghMat = repmat(wghVec,n,1);
featFreqMat = featFreqMatMaker(X,featFreq);

OF = sum(wghMat.*deltaFunc(featFreqMat),2);

end