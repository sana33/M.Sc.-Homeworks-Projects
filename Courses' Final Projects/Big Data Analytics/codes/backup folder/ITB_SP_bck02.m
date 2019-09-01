function [OS,OSinds] = ITB_SP(X,o)

n = size(X,1);
b = 1/n; a = 1/(n-1);
[OF,wghVec,~,~,WHL,~] = OF_Calc(X);
appDiffHL_fix = (sum(wghVec)*(log2(a)-(a/b)*log2(b)))-a*WHL;
appDiffHL = appDiffHL_fix + a.*OF;

% ASinds = appDiffHL>0;
ASinds = find(appDiffHL>0);
UO = sum(appDiffHL>0);
if o>UO; o = UO; end

[sOF,sOFinds] = sort(OF(ASinds),'descend');
flip(heapsort(OF))

[sADHL,sADHLinds] = sort(appDiffHL);


end

