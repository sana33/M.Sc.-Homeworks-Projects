% clear;
% close all;
% clc;
% warning off;

load('ds01.mat');

labels = unique(X(3,:));
k = numel(labels);
detVec = zeros(1,k);

for c1 = 1:k
    detVec(c1) = det(cov(X(1:end-1,X(3,:)==labels(c1))'));
end

