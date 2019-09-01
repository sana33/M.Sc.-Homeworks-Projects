function y = logisticSigmoidDerivative(x)
alpha = 2;
y = alpha .* logisticSigmoid(x) .* (1 - logisticSigmoid(x));
end