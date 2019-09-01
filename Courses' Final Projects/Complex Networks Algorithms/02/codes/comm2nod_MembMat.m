function [nodMembMat] = comm2nod_MembMat(commMembMat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nodNo = max(max(commMembMat));
commNo = size(commMembMat,1);
nodMembMat = sparse(nodNo,commNo);
for c1 = 1:nodNo
    [commRow,~] = find(commMembMat==c1);
    nodMembMat(c1,1:numel(commRow)) = commRow';
end

nodMembMat = nodMembMat(:,sum(nodMembMat)~=0);

end