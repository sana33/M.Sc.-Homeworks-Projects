function [y] = arcTangentDerivative(x)
    y = (2 ./ pi) ./ (1 + x .^ 2);
end