function [y] = logFunctionDerivative(x)
    if x >= 0
        y = 1 ./ (1 + x);
    else
        y = 1 ./ (1 - x);
    end
end