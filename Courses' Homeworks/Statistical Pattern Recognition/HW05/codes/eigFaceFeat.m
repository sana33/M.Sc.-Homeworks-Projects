function [F] = eigFaceFeat(X,r)

% [~,~,V] = svd(X,'econ');
[~,~,V] = svd(X);
F = X*V(:,1:r);

end

