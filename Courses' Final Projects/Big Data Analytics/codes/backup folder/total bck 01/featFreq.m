function [featUnqFreq] = featFreq(X)

n = size(X,1);
m = size(X,2);
featUnqFreq = cell(1,m);
for k1 = 1:m
    unq = unique(X(:,k1));
    unqFreq = zeros(length(unq),1);
    for k2 = 1:length(unq)
        unqFreq(k2) = sum(X(:,k1)==unq(k2));
    end
    featUnqFreq{1,k1} = [unq unqFreq];
end

end

