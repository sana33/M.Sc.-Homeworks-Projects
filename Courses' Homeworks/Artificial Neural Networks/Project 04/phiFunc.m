function [phiOutput] = phiFunc(distMatrix, sigma, phiType)
switch phiType
    case 'multiquad_radioButton'
        phiOutput = sqrt(distMatrix .^ 2 + sigma .^ 2);
    case 'inv_multiquad_radioButton'
        phiOutput = sqrt(distMatrix .^ 2 + sigma .^ 2) .^ -1;
    case 'gaussian_func_radioButton'
        phiOutput = exp((-.5 .* (sigma .^ -2)) .* (distMatrix .^ 2));
    case 'logarithm_func_radioButton'
        phiOutput = (distMatrix ./ (sigma .^ 2)) .* log(distMatrix ./ sigma);
end
