function [OS,OSidx,Jopt,OF,UO] = ITB_SP(Z,o,w)

X = Z{1,1}(:,1:end-1);
featFreq = Z{1,2};
n = size(X,1);
b = 1/n; a = 1/(n-1);
[OF,wghVec,~,~,WHL] = OF_Calc(X,featFreq,w);
appDiffHL_fix = (sum(wghVec)*(log2(a)-(a/b)*log2(b)))-a*WHL;
appDiffHL = appDiffHL_fix + a.*OF;

ASidx = find(appDiffHL>0);
UO = sum(appDiffHL>0);
if o>UO; o = UO; end

[~,sOFidx] = sort(OF(ASidx),'descend');
ASsOFidx = ASidx(sOFidx);

OSidx = ASsOFidx(1:o);
OS = X(OSidx,:);
NSidx = setdiff(1:n,OSidx);
featFreq_NS = featFreqFunc(X(NSidx,:));
[~,~,~,Jopt] = WHL_Calc(featFreq_NS,w);

end