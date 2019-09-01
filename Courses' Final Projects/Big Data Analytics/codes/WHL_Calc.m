function [wghVec,Hvec,HL,WHL] = WHL_Calc(featFreq,w)

m = length(featFreq);
Hvec = zeros(1,m);
for c1 = 1:m
    Hvec(c1) = entCalc(featFreq{1,c1});
end
if w
    wghVec = sigmoidRev(Hvec);
else
    wghVec = ones(1,m);
end

HL = sum(Hvec);
WHL = sum(wghVec.*Hvec);

end

