function dsNormal = NormalizeToZeroOne(dataset)
    samplesNo = size(dataset,1);
    dsNormal = (dataset - repmat(min(dataset), samplesNo, 1)) ./ repmat(max(dataset) - min(dataset), samplesNo, 1);
    dsNormal(isnan(dsNormal) | isinf(dsNormal)) = 0;
end