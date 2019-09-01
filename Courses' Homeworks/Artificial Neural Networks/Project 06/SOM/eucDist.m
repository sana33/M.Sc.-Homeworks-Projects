function [EUCdistance] = eucDist(XI, XJ)
XII = ones(size(XJ, 1), 1) * XI;
EUCdistance = sqrt(sum((XII - XJ) .^ 2, 2));