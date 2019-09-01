function [normalizedFeatures] = normalizeDataSet(dataSet, high, low, method)
% This function normalizes the input dataset according to the boundaries
% defined by values 'high' and 'low'. The 'method' value defines the way in
% which the dataset is normalized, 0 for global normalization and 1 for
% columnwise normalization

normalizedFeatures = zeros(size(dataSet));
if ~method
    minValue = min(min(dataSet));
    maxValue = max(max(dataSet));
    coeff = (high - low) / (maxValue - minValue);
    bias = (maxValue * low - minValue * high) / (maxValue - minValue);
    normalizedFeatures = coeff .* dataSet + bias;
else
    for ii = 1:size(dataSet, 2)
        maxValue = max(dataSet(:, ii));
        minValue = min(dataSet(:, ii));
        if minValue == maxValue
            normalizedFeatures(:, ii) = (high + low) ./ 2;
        else
            coeff = (high - low) / (maxValue - minValue);
            bias = (maxValue * low - minValue * high) / (maxValue - minValue);
            normalizedFeatures(:, ii) = coeff .* dataSet(:, ii) + bias;
        end
    end
end

end