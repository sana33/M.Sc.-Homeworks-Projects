function [Fscore,precision,recall] = Fscore_Calc(nodMembGoal,nodMembGues)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

idxTruOvNod = find(sum(nodMembGoal~=0,2)>1);
idxDetOvNod = find(sum(nodMembGues~=0,2)>1);
idxCorOvNod = intersect(idxTruOvNod,idxDetOvNod);

truOvNodSz = numel(idxTruOvNod);
detOvNodSz = numel(idxDetOvNod);
corOvNodSz = numel(idxCorOvNod);

precision = corOvNodSz/detOvNodSz;
recall = corOvNodSz/truOvNodSz;

Fscore = (2*precision*recall)/(precision+recall);

end