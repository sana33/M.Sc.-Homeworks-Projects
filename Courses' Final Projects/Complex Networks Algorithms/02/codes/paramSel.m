function [bestEpsi,bestMu,bestNodMembMat] = paramSel(E, gamma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Gaining the unrepeated edgelist
E = sort(E,2);
E = unique(E,'rows');

epsiVec = .5:.01:.74;
muVec = 2:6;

EQmax = -inf;
for c1 = epsiVec
    for c2 = muVec
        [nodMembMat] = DBLC(E, c1, c2, gamma);
        [EQ] = EQ_Calc(E,nodMembMat);
        
        if EQ>=EQmax
            EQmax = EQ;
            bestEpsi = c1;
            bestMu = c2;
            bestNodMembMat = nodMembMat;
        end
    end
end

end

