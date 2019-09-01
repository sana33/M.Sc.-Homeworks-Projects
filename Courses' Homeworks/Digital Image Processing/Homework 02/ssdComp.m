function [ssd] = ssdComp(A,B)
ssd = sum(sum((double(A)-double(B)).^2));
end