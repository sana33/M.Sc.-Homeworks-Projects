function [commArray, commInds] = smallNet_create(t0_dv, t1_dv, t1_A, t0_commInds, blondelArgs)
% t0_dv: degree vector at time-step t-1 t1_dv: degree vector at time-step t
% t1_A: a sparse matrix representing the network structure at time step t
% t0_commInds: community indices at time-step t-1 blondelArgs: a structure
% array containing arguments needed for BlondelSparse() function; including
% metricType, recurr, selfLoop, ph1SC and passSC

commInds = t0_commInds;
t0_commNo = max(t0_commInds);
changedInds = find(t0_dv~=t1_dv);
commInds(changedInds) = t0_commNo + find(ones(length(changedInds),1));
commArrTmp = commArrayMaker(commInds);

% constructing small network
commNoTmp = t0_commNo + length(changedInds);
smallNet = sparse(commNoTmp,commNoTmp);
snSz = length(commArrTmp);
for c1 = 1:snSz
    for c2 = 1:snSz
        smallNet(c1,c2) = full(sum(sum(t1_A(commArrTmp{c1},commArrTmp{c2}))));
    end
end

% performing Blondel algorithm on the small network
[~, sn_commInds] = BlondelSparse(smallNet, blondelArgs.metricType, blondelArgs.recurr, ...
    blondelArgs.selfLoop, blondelArgs.ph1SC, blondelArgs.passSC);
sn_commArray = commArrayMaker(sn_commInds);

commArray = {commArrTmp, sn_commArray};
commInds = commArray2IndsMult(commArray);

end

function [commInds] = commArray2IndsMult(commArrayMult)
% It converts a hierarchy of community arrays of numeric vectors to
% community indices; each vector contains indices of nodes belonging to the
% current community number in the corresponding hierarchy level
commInds = [];
for c1 = 1:length(commArrayMult{end})
    inds = commArrayMult{end}{c1};
    count = length(commArrayMult)-1;
    while true
        numericCells = commArrayMult{count}(inds);
        inds = cell2mat(numericCells);
        count = count - 1;
        if count<1; break; end
    end
    commInds = [commInds; [inds, c1.*ones(length(inds),1)]];
end
commInds = sortrows(commInds);
commInds = commInds(:,2);

end

