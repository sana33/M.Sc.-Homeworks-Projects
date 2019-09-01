function [] = svmRedun(X,K)

dataset = X(:,1:end-1);
labels = X(:,end);
idx = kmeans(dataset,K);
gamma = 1;

% clusts = cell(K,1);
% for c1 = 1:K
%     clusts{c1,1} = dataset(idx==c1,:);
% end

UC = cell(0);
UMC = cell(0);
for c1 = 1:K
    if length(unique(labels(idx==c1)))==1
        inds = idx==c1;
        UC = cellCat(UC, [dataset(inds,:) labels(inds)], 'ver');
    else
        labTemp = unique(labels(idx==c1));
        for c2 = 1:length(labTemp)
            inds = idx==c1 & labels==labTemp(c2);
            UMC = cellCat(UMC, [dataset(inds,:) labels(inds)], 'ver');
        end
    end
end

m1 = length(UC); m2 = length(UMC);
A = zeros(m1+m2,size(X,2));
for c1 = 1:m1+m2
    if c1<=m1
        A(c1,:) = mean(UC{c1,1});
    else
        A(c1,:) = mean(UMC{c1-m1,1});
    end
end

labUnq = unique(labels);
lablUnqLngth = length(unique(labels));
hypPlnInf = cell(lablUnqLngth,lablUnqLngth-1);
for c1 = 1:lablUnqLngth
    inds1 = A(:,end)==labUnq(c1);
    for c2 = 1:lablUnqLngth-1
        if c1==c2; continue; end
        inds2 = A(:,end)==labUnq(c2);
        dsTemp = [A(inds1,:); A(inds2,:)];
        svmMdl = fitcsvm(dsTemp(:,1:end-1),dsTemp(:,end),'BoxConstraint',10,'KernelFunction','rbf');
        hypPlnInf{c1,c2} = cell(5,1);
        hypPlnInf{c1,c2}{1,1} = svmMdl.Alpha;
        hypPlnInf{c1,c2}{2,1} = svmMdl.SupportVectorLabels;
        hypPlnInf{c1,c2}{3,1} = svmMdl.SupportVectors;
        hypPlnInf{c1,c2}{4,1} = svmMdl.Bias;
        svNum = size(svmMdl.SupportVectors,1);
        svDot = svDotCalc(svmMdl.SupportVectors);
        svNorm2 = diag(svDot);
        hypPlnInf{c1,c2}{5,1} = sqrt(sum(sum((svmMdl.Alpha*svmMdl.Alpha').* ...
            (svmMdl.SupportVectorLabels*svmMdl.SupportVectorLabels').* ...
            exp(-gamma.*(repmat(svNorm2,1,svNum)+repmat(svNorm2',svNum,1)-2.*svDot)))));
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
