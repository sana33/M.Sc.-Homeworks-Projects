function [featFreqMat] = featFreqMatMaker(X,featFreq)

n = size(X,1);
m = size(X,2);
featFreqMat = zeros(n,m);
for k1 = 1:m
    for k2 = 1:size(featFreq{1,k1},1)
        featFreqMat(X(:,k1)==featFreq{1,k1}(k2,1),k1) = featFreq{1,k1}(k2,2);
    end
end

end

