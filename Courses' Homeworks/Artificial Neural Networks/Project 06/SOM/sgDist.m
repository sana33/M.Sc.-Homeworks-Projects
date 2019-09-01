function [SGdistance] = sgDist(XI, XJ)
XII = ones(size(XJ, 1), 1) * XI;
SGdistance = 1 - (sum(XII .* XJ, 2) ./ (sqrt(sum(XII .^ 2, 2)) .* sqrt(sum(XJ .^ 2, 2))));