function [y] = deltaFunc(x)

if x==1
    y = 0;
else
    y = (x-1).*log2(x-1)-x.*log2(x);
end

end