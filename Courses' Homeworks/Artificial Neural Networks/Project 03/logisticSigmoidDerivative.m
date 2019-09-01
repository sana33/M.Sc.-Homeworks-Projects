function y = logisticSigmoidDerivative(x)
    y = .9 .* logisticSigmoid(x) .* (1 - logisticSigmoid(x));
end