function [commCelArr] = commCelArrMaker(nodMembMat)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

commNo = max(max(nodMembMat));
commCelArr = cell(commNo,1);

for c1 = 1:commNo
    [commMembVec,~] = find(nodMembMat==c1);
    commCelArr{c1,1} = commMembVec';
end

end

