function [commArray, commInds] = BlondelSparse(A, metricType, recurr, selfLoop, ph1SC, passSC)

% A: Adjacency Matrix Sparsed

nodesNo = length(A);

% Permuting the order of graph nodes' labels
P = permMatrix(nodesNo);
A = P * A * P';

% Converting string of metricType to lower case string
metricType = lower(metricType);

[commArray] = BlondelCommDetect(A, metricType, recurr, selfLoop, ph1SC, passSC);
if length(commArray) == 1
    commInds = commArray2IndsSingle(commArray);
else
    commInds = commArray2IndsMult(commArray);
end

% Unpermuting the order of graph nodes' labels
commInds = P' * commInds;

% Playing beep sound signing that the job is done!
% beep;

end

function [commArray] = BlondelCommDetect(A, metricType, recurr, selfLoop, ph1SC, passSC)

if nargin < 1; error('Not enough input arguments!'); end
if nargin < 2; metricType = 'symmetric'; recurr = 0; selfLoop = 1; ph1SC = 2; passSC = 2; end
if nargin < 3; recurr = 0; selfLoop = 1; ph1SC = 2; passSC = 2; end
if nargin < 4; selfLoop = 1; ph1SC = 2; passSC = 2; end
if nargin < 5; ph1SC = 2; passSC = 2; end
if nargin < 6; passSC = 2; end

commArray = cell(1);
Asz = length(A);
if ~selfLoop; A((Asz+1).*[0:Asz-1]+1) = 0; end

% Passes goes here
passStop = 1;
while true
    nodesNo = length(A);
    nodesNeighb = cell(nodesNo,1);
    switch metricType
        case 'symmetric'
            degVec = sum(A);
            for c1 = 1:nodesNo
                nodesNeighb{c1} = find(A(c1,:));
            end
        case 'asymmetric'
            degVec = sum(A+A');
            for c1 = 1:nodesNo
                nodesNeighb{c1} = find(A(c1,:)+A(:,c1)');
            end
    end
    degSum = full(sum(degVec));
    commInds = find(ones(nodesNo,1));
    phase1Stop = 1;
    % Phase 1
    while true
        gainTotChange = 0;
        for c1 = 1:nodesNo
            neighbNo = length(nodesNeighb{c1});
            if neighbNo==0; continue; end
            modulGain = zeros(1,neighbNo);
            for c2 = 1:neighbNo
                if commInds(c1)==commInds(nodesNeighb{c1}(c2)); continue; end
                modulGain(c2) = modulGainCalc(A, c1, commInds, commInds(nodesNeighb{c1}(c2)), degSum);
            end
            [gainMax, gainInd] = max(modulGain);
            if gainMax<=0; continue; end
            gainTotChange = gainTotChange + gainMax;
            commInds(c1) = commInds(nodesNeighb{c1}(gainInd));
        end
        if gainTotChange<=0; break; end
        phase1Stop = phase1Stop + 1;
        if phase1Stop>ph1SC; break; end
    end
    commArray = cellCat(commArray, commInds2Array(commInds), 'hor');
    if ~recurr; break; end
    if length(commArray)>2 && length(commArray{end})==length(commArray{end-1}); commArray=commArray(1:end-1); break; end
    % Phase 2
    Bsz = length(commArray{end});
    B = sparse(Bsz,Bsz);
    for c1 = 1:Bsz
        for c2 = 1:Bsz
            B(c1,c2) = full(sum(sum(A(commArray{end}{c1},commArray{end}{c2}))));
        end
    end
    if ~selfLoop; B((Bsz+1).*[0:Bsz-1]+1) = 0; end
    A = B;
    passStop = passStop + 1;
    if passStop>passSC; break; end
end
commArray = commArray(2:end);

end

function [permMat] = permMatrix(matSize)

rp = randperm(matSize);
permMat = sparse(rp,1:matSize,1);

end

function [commArray] = commInds2Array(commInds)

commIndsReind = commIndsReindex(commInds);
commNo = max(commIndsReind);
commArray = cell(commNo,1);
for c1 = 1:commNo
    commArray{c1} = find(commIndsReind==c1);
end

end

function [commIndsReind] = commIndsReindex(commInds)

commIndsReind = commInds;
commUnq = unique(commInds);
commNo = length(commUnq);
for c1 = 1:commNo
    commIndsReind(commIndsReind==commUnq(c1)) = c1;
end

end

function [commInds] = commArray2IndsSingle(commArraySingle)
% It converts a community array of numeric vectors to community indices;
% each vector contains indices of nodes belonging to the current community
% number
if length(commArraySingle)==1; commArraySingle=commArraySingle{1}; end
commInds = [];
for c1 = 1:length(commArraySingle)
    commInds = [commInds; [commArraySingle{c1}, c1.*ones(length(commArraySingle{c1}),1)]];
end
commInds = sortrows(commInds);
commInds = commInds(:,2);

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

function [cellsCat] = cellCat(cellArray, cellNew, dir)

cellSz = length(cellArray);
dir = lower(dir);
switch dir
    case 'hor'
        cellsCat = cell(1,cellSz+1);
        for c1 = 1:cellSz
            cellsCat{c1} = cellArray{c1};
        end
        cellsCat{end} = cellNew;
    case 'ver'
        cellsCat = cell(cellSz+1,1);
        for c1 = 1:cellSz
            cellsCat{c1} = cellArray{c1};
        end
        cellsCat{end} = cellNew;
end

end

function [modulGain] = modulGainCalc(A, nodeID, commInds, commNo, degSum)

comm = find(commInds==commNo);
E_in = full(sum(sum(A(comm,comm))));
E_tot = full(sum(sum(A(:,comm))));
k_i = full(sum(A(:,nodeID)));
k_i_in = full(sum(A(nodeID,comm)));

modulGain = ((E_in+k_i_in)/degSum - ((E_tot+k_i)/degSum)^2) - (E_in/degSum - (E_tot/degSum)^2 - (k_i/degSum)^2);

end
