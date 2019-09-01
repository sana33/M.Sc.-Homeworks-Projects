function [nodMembMat] = DBLC(EdgList, epsi, mu, gamma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Gaining the unrepeated edgelist
EdgList = sort(EdgList,2);
EdgList = unique(EdgList,'rows');

nodNo = max(EdgList(:));
edgNo = size(EdgList,1);

% Making the adjacency matrix
adjMat = sparse(EdgList(:,1),EdgList(:,2),1,nodNo,nodNo);
adjMat = adjMat+adjMat';

% Making the incidence matrix
incidMat = sparse([1:edgNo 1:edgNo],[EdgList(:,1); EdgList(:,2)],1,edgNo,nodNo);

% Making similarity matrix S
simMat = sparse(edgNo,edgNo);
for c1 = 1:nodNo
    idxInc = find(incidMat(:,c1));
    simMat(idxInc,idxInc) = 1;
end
simMat = triu(simMat,1);
[Srow,Scol] = find(simMat);
for c1 = 1:numel(Srow)
    idxS = setdiff(find(incidMat(Srow(c1),:) | incidMat(Scol(c1),:)), find(incidMat(Srow(c1),:) & incidMat(Scol(c1),:)));
    [~,~,simMat(Srow(c1),Scol(c1))] = similFunc(adjMat,idxS(1),idxS(2),gamma);
end
simMat = simMat+simMat';
simMat = exp(simMat)./(1+exp(simMat));

% Specifying core edges
idxCore = find((sum(simMat>=epsi,2)+1)>=mu);

% Considering the expansion part
idxLinkClust = sparse(edgNo,1);
visited = sparse(edgNo,1);
isNoise = sparse(edgNo,1);
commNo = 0;
for c1 = 1:numel(idxCore)
    if ~visited(idxCore(c1))
        visited(idxCore(c1)) = 1;
        idxCorNghb = intersect(idxCore,find(simMat(:,idxCore(c1))>=epsi));
        commNo = commNo+1;
        edgeExpand(idxCore(c1),idxCorNghb,commNo);
    end
end

% Considering the updating part for edge clustering
edgeUpdate();

% Considering noise edges
isNoise(idxLinkClust==0) = 1;

% Transferring the link cluster into the cluster with nodes according to
% the incidence matrix
[nodMembMat,idxNodUnclss] = nodMembMatMaker();

% Managing the unclassified nodes in appropriate way
unclssNodMang(idxNodUnclss);


% Nested function for edge expansion procedure
    function edgeExpand(idxExp,idxCorNghb,commNo)
        idxLinkClust(idxExp) = commNo;
        if ~isempty(idxCorNghb)
            k1 = 1;
            while true
                idxCorCurr = idxCorNghb(k1);
                if ~visited(idxCorCurr)
                    visited(idxCorCurr) = 1;
                    idxCorNghb = [idxCorNghb; setdiff(intersect(idxCore,find(simMat(:,idxCorCurr)>=epsi)),idxCorNghb)];
                end
                k1 = k1+1;
                if k1>numel(idxCorNghb)
                    break;
                end
            end
            idxLinkClust(unique(idxCorNghb)) = commNo;
        end
    end

% Nested function for updating strategy
    function edgeUpdate()
        idxCorTmp = sparse(edgNo,1);
        idxCorTmp(idxCore) = 1;
        [maxCorSim,maxCorIdx] = max(simMat.*(repmat(idxCorTmp,1,edgNo) & simMat>=epsi),[],'omitnan');
        cond1 = maxCorSim'~=0 & idxLinkClust==0;
        idxLinkClust(cond1) = idxLinkClust(maxCorIdx(cond1)');
    end

% Nested function for creating node community membership matrix
    function [nodMembMat,idxNodUnclss] = nodMembMatMaker()
        idxNodUnclss = [];
        idxLinkClustMat = repmat(idxLinkClust,1,nodNo);
        nodMembMat = idxLinkClustMat.*incidMat;
        for d1 = 1:nodNo
            nodMemVec = setdiff(unique(nodMembMat(:,d1)),0);
            if ~isempty(nodMemVec)
                nodMembMat(:,d1) = padarray(nodMemVec,edgNo-numel(nodMemVec),'post');
            else
                idxNodUnclss = [idxNodUnclss; d1];
            end
        end
        idxZero = sum(nodMembMat,2)==0;
        nodMembMat = transpose(nodMembMat(~idxZero,:));
        if isempty(nodMembMat)
            nodMembMat = sparse(nodNo,1);
        end
    end

% Nested function for management of unclassified nodes
    function unclssNodMang(idxNodUnclss)
        % Assigning the unclassified nodes connected to marginal edges to
        % their very first neighbors' communities
        idxNodClss = setdiff((1:nodNo)',idxNodUnclss);
        idxNodClssVec = sparse(nodNo,1);
        idxNodClssVec(idxNodClss) = 1;
        adjMatUnclssNod = repmat(idxNodClssVec,1,nodNo).*adjMat;
        [maxNodUnclssNghbClss,idxNodUnclssNghbClss] = max(adjMatUnclssNod(:,idxNodUnclss));
        idxNodUnclss = idxNodUnclss(maxNodUnclssNghbClss'~=0);
        idxNodUnclssNghbClss = idxNodUnclssNghbClss(maxNodUnclssNghbClss'~=0);
        nodMembMat(idxNodUnclss,:) = nodMembMat(idxNodUnclssNghbClss',:);
        
        % Assigning each of the remained unclassified nodes to a new
        % community containing only that unclassified node
        idxNodUnclss = find(max(nodMembMat,[],2)==0);
        commNo = max(max(nodMembMat));
        nodMembMat(idxNodUnclss,1) = ((commNo+1):(commNo+numel(idxNodUnclss)))';
    end
end

