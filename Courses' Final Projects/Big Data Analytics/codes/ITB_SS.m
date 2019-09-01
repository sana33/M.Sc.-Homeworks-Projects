function [OS,OSidx,Jopt,OF_final,UO] = ITB_SS(Z,o,w)

X = Z{1,1}(:,1:end-1);
featFreq = Z{1,2};
n = size(X,1);
b = 1/n; a = 1/(n-1);
[OF,wghVec,Hvec,~,WHL] = OF_Calc(X,featFreq,w);
OF_final = OF;
appDiffHL_fix = (sum(wghVec)*(log2(a)-(a/b)*log2(b)))-a*WHL;
appDiffHL = appDiffHL_fix + a.*OF;

ASidx = find(appDiffHL>0);
UO = sum(appDiffHL>0);
if o>UO; o = UO; end

OFtemp = OF;
ASidxTemp = ASidx;
OSidx = zeros(o,1);
for c1 = 1:o
    [~,maxOFidx] = max(OFtemp(ASidxTemp),[],'omitnan');
    olIdx = ASidxTemp(maxOFidx);
    OF_final(olIdx) = OFtemp(olIdx);
    OSidx(c1) = olIdx;
    ASidxTemp = ASidxTemp(ASidxTemp~=olIdx);
    OFtemp = OF_upd(X,Hvec,featFreq,a,b,olIdx,w);
    OFtemp = [OFtemp(1:olIdx-1); -inf; OFtemp(olIdx:end)];
end

OS = X(OSidx,:);
NSidx = setdiff(1:n,OSidx);
featFreq_NS = featFreqFunc(X(NSidx,:));
[~,~,~,Jopt] = WHL_Calc(featFreq_NS,w);

end