function [cliqueCell,cliqueAdj,communities] = threeCliqueFinder(adjMat)

% Finding 3-cliques
cliqueCell = cell(0);
adjMatLow = adjMat - triu(adjMat);
for c1 = 1:length(adjMat)-2
    neighbs = [];
    neighbs = [neighbs; find(adjMatLow(:,c1)~=0)];
    for c2 = 1:length(neighbs)-1
        neighbsTmp = find(adjMat(:,neighbs(c2))~=0);
        neighbsIntsc = intersect(neighbsTmp,neighbs(c2+1:end));
        for c3 = 1:length(neighbsIntsc)
            cliqueCell = [cliqueCell {[c1;neighbs(c2);neighbsIntsc(c3)]}];
        end
    end
end

% Making adjacency matrix of 3-cliques
clqCelLng = length(cliqueCell);
cliqueAdj = zeros(clqCelLng);
clqMat = cell2mat(cliqueCell);
for c1 = 1:clqCelLng-1
    for c2 = c1+1:clqCelLng
        intrsctNo = length(intersect(clqMat(:,c1),clqMat(:,c2)));
        if intrsctNo>=2; cliqueAdj(c1,c2)=1; end;
    end
end
cliqueAdj = cliqueAdj + cliqueAdj';

% Finding connected components in the 3-clique graph
[nComponents,sizes,members] = networkComponents(cliqueAdj);

% Finding communities by getting the union of the connected nodes in the
% 3-clique graph
communities = cell(1,length(members));
for c1 = 1:length(members)
    commNodeTmp = cell2mat(members(c1));
    commMembs = [];
    for c2 = 1:length(commNodeTmp)
        commMembs = union(cell2mat(cliqueCell(commNodeTmp(c2))),commMembs);
    end
    communities(c1) = {commMembs};
end
