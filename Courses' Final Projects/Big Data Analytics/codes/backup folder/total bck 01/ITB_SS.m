function [OS,OSidx,Jopt,OF_final,UO] = ITB_SS(X,o,w)

n = size(X,1);
b = 1/n; a = 1/(n-1);
[OF,wghVec,Hvec,~,WHL,featFreq] = OF_Calc(X,w);
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
    osIdx = ASidxTemp(maxOFidx);
    OF_final(osIdx) = OFtemp(osIdx);
    OSidx(c1) = osIdx;
    ASidxTemp = ASidxTemp(ASidxTemp~=osIdx);
    OFtemp = OF_upd(Hvec,featFreq(osIdx,:),a,b,X([1:osIdx-1 osIdx+1:end],:),w);
    OFtemp = [OFtemp(1:osIdx-1); -inf; OFtemp(osIdx:end)];
end

OS = X(OSidx,:);
NSidx = setdiff(1:n,OSidx);
[~,~,~,Jopt,~] = WHL_Calc(X(NSidx,:),w);

end