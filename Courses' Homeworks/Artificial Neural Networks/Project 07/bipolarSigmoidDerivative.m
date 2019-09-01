function y = bipolarSigmoidDerivative(x)
alpha = 1;
y = (1 + bipolarSigmoid(x)) .* (1 - bipolarSigmoid(x)) .* (alpha / 2);
end