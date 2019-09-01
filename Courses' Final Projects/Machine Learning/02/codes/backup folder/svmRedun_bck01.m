function [] = svmRedun(X,K)

dataset = X(:,1:end-1);
labels = X(:,end);
idx = kmeans(dataset,K);

% clusts = cell(K,1);
% for c1 = 1:K
%     clusts{c1,1} = dataset(idx==c1,:);
% end

UC = cell(0);
MC = cell(0);
for c1 = 1:K
    if length(unique(labels(idx==c1)))==1
        inds = idx==c1;
        UC = cellCat(UC, [dataset(inds,:) labels(inds)], 'ver');
    else
        labTemp = unique(labels(idx==c1));
        mcTemp = cell(0);
        for c2 = 1:length(labTemp)
            inds = idx==c1 & labels==labTemp(c2);
            mcTemp = cellCat(mcTemp, [dataset(inds,:) labels(inds)], 'hor');
        end
        MC = cellCat(MC, mcTemp, 'ver');
    end
end


svmMdl = fitcsvm(dsTemp(:,1:end-1),dsTemp(:,end),'BoxConstraint',10,'KernelFunction','rbf');

% MaxMinClustDis(UC,MC,unique(labels));

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
