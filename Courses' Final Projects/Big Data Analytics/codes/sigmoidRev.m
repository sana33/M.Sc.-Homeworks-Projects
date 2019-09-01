function [y] = sigmoidRev(x)

y = 2.*(1-(1+exp(-x)).^-1);

end

