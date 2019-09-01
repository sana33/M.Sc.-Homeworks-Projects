function [FDR] = FDRcalc(Xc,Xs)

mu1 = mean(Xc);
mu2 = mean(Xs);
var1 = var(Xc);
var2 = var(Xs);

FDR = ((mu1-mu2)^2)/(var1+var2);

end

