function y = logisticSigmoid(x)
alpha = 2;
y = 1 ./ (1 + exp(-alpha .* x));
end