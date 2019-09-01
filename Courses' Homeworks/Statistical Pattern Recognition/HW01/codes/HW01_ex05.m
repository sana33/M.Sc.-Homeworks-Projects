clear, clc, close all, warning off

n = 20; x = 12:15; p = .5;
f_binomial = (factorial(n) ./ (factorial(n-x) .* factorial(x))) .* (p.^x .* (1-p).^(n-x));

f_normal = ((5*sqrt(2*pi))^-1) * exp(-(x-10).^2 / 50);

fprintf('\nThe Binomial dist. outputs are:\n%0.4f\t%0.4f\t%0.4f\t%0.4f',f_binomial(1),f_binomial(2),f_binomial(3),f_binomial(4));
fprintf('\nThe Corresponding Normal dist. outputs are:\n%0.4f\t%0.4f\t%0.4f\t%0.4f\n',f_normal(1),f_normal(2),f_normal(3),f_normal(4));

