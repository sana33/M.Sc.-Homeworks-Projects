function [clust] = makeUncorrClust(mu,var,n)

d = numel(mu);
clust = zeros(d,n);
for c1 = 1:d
    clust(c1,:) = sqrt(var(c1)).*randn(1,n)+mu(c1);
end

end