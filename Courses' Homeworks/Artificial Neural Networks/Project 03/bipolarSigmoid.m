function y = bipolarSigmoid(x)
    y = (1 - exp(-.9 .* x)) ./ (1 + exp(-.9 .* x));
end