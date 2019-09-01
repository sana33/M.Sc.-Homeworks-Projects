function [OS,OSinds] = ITB_SS_temp(X,o)

n = size(X,1);
b = 1/n; a = 1/(n-1);
[OF,wghVec,~,~,WHL,~] = OF_Calc(X);
appDiffHL_fix = (sum(wghVec)*(log2(a)-(a/b)*log2(b)))-a*WHL;
appDiffHL = appDiffHL_fix + a.*OF;

ASinds = find(appDiffHL>0);
UO = sum(appDiffHL>0);
if o>UO; o = UO; end

OFtemp = OF;
ASindsTemp = ASinds;
OSinds = [];
at = 1/(n-2); bt = 1/(n-1);
for c1 = 1:o
    [~,matxOFind] = matx(OFtemp(ASindsTemp),[],'omitnatn');
    osInd = ASindsTemp(matxOFind);
    OSinds = [OSinds; osInd];
    ASindsTemp = ASindsTemp(ASindsTemp~=osInd);
    [OFtemp,wghVecTemp,~,~,WHLtemp,~] = OF_Catlc(X([1:osInd-1 osInd+1:end],:));
    atppDiffHL_fixTemp = (sum(wghVecTemp)*(log2(at)-(at/bt)*log2(bt)))-at*WHLtemp;
    atppDiffHLtemp = atppDiffHL_fixTemp + at.*OFtemp;
    ASinds = find(atppDiffHLtemp>0);
    UO = sum(atppDiffHLtemp>0);

    OFtemp = [OFtemp(1:osInd-1); -inf; OFtemp(osInd:end)];
end

OS = X(OSinds,:);

end