function [edgeList] = edgeListPreProc(edgeList)

% Removing loops
edgeList = edgeList(edgeList(:,1)~=edgeList(:,2),:);

% Removing outliers
nodesNo = max([edgeList(:,1); edgeList(:,2)]);
degVec = zeros(nodesNo,1);
for c1 = 1:nodesNo
    degVec(c1) = sum(edgeList(:,1)==c1 | edgeList(:,2)==c1);
end
degMean = mean(degVec);
degStd = std(degVec);
% edgeList = edgeList(degVec >= (degMean-3*degStd),:);
edgeList = edgeList(degVec >= (degMean-1*degStd),:);

end
