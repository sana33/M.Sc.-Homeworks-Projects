function [H] = entCalc(featFreq)

p = featFreq(:,2)./sum(featFreq(:,2));
log2P = log2(p);

H = -sum(p.*log2P);

end