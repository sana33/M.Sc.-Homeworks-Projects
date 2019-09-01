function [EQ] = EQ_Calc(E,nodMembMat)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Gaining the unrepeated edgelist
E = sort(E,2);
E = unique(E,'rows');
% Making the adjacency matrix
nodNo = max(E(:));
adjMat = sparse(E(:,1),E(:,2),1,nodNo,nodNo);
adjMat = adjMat+adjMat';

degVec = sum(adjMat,2);
edgNo = sum(degVec)/2;
commMembNo = sum(nodMembMat~=0,2);
[commCelArr] = commCelArrMaker(nodMembMat);

EQ = 0;
for c1 = 1:length(commCelArr)
    commNods = commCelArr{c1};
    commNodNo = numel(commNods);
    
    Avw = adjMat(commNods,commNods);
    Avw(1:(commNodNo+1):commNodNo^2) = 0;
    Ovw = commMembNo(commNods)*commMembNo(commNods)';
    Ovw(1:(commNodNo+1):commNodNo^2) = 0;
    Kvw = degVec(commNods)*degVec(commNods)';
    Kvw(1:(commNodNo+1):commNodNo^2) = 0;
    
    eq = (Avw-(Kvw/(2*edgNo)))./Ovw;
    eq(isnan(eq)) = 0;
    EQ = EQ + sum(sum(eq));
end

EQ = EQ/(2*edgNo);

end

