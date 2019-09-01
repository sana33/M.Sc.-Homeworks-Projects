function y = bipolarSigmoidDerivative(x)
    y = (1 + bipolarSigmoid(x)) .* (1 - bipolarSigmoid(x)) .* (.9 / 2);
end