function [H,unq,freq,ic] = entCalc(set)

[unq,~,ic] = unique(set);
n = length(set);
freq = zeros(length(unq),1);

for c1 = 1:length(unq)
    freq(c1) = sum(set==unq(c1));
end
p = freq./n;
log2P = log2(p);

H = -sum(p.*log2P);

end