function [normalizedFeatures] = normalizeDataSet(dataSet, high, low, method)
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
            end % end of if-else
        end % end of for
    end % end of if-else
end % end of function