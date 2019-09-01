function [OS] = ITB_SP(X,o)

[wghVec,Hvec,HL,WHL] = WHL_Calc(X);
n = size(X,1);
b = n; a = n-1;
OS = [];
OF = zeros(n,1);
diffHL = zeros(n,1);
diffHL_fix = (sum(wghVec)*(log2(a)-(a/b)*log2(b)))-a*WHL;

for c1 = 1:n
    OF(c1) = ;
    AS = [AS; ];
    OF(c1) = OFcalc(X(c1,:));
end

end


