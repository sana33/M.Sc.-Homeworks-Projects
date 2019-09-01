function [OF] = OF_Calc(X)

n = size(X,1);
m = size(X,2);
[wghVec,~,~,~] = WHL_Calc(X);
wghMat = repmat(wghVec,n,1);
Y = zeros(size(X));

for c1 = 1:m
    [~,unq,freq,ic] = entCalc(X(:,c1));
    [unq,~,ic] = unique(X(:,c1));
    z = zeros(length(unq),1);
    for c2 = 1:length(z)
        z(c2) = sum(X(:,c1)==unq(c2));
    end
    Y(:,c1) = z(ic);
end

OF = sum(wghMat.*deltaFunc(Y),2);

end