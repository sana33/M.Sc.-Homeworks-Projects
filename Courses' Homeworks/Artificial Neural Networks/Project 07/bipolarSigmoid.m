function y = bipolarSigmoid(x)
alpha = 1;
y = (1 - exp(-alpha .* x)) ./ (1 + exp(-alpha .* x));
end