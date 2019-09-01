function [OS,OSidx,Jopt,OF,UO] = ITB_SP(X,o,w)

n = size(X,1);
b = 1/n; a = 1/(n-1);
[OF,wghVec,~,~,WHL,~] = OF_Calc(X,w);
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
[~,~,~,Jopt,~] = WHL_Calc(X(NSidx,:),w);

end