function [y] = logFunction(x)
    if x >= 0
        y = log(1 + x);
    else
        y = -log(1 - x);
    end
end