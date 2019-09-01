function [Xreduc] = svmRedun(X,K)

dataset = X(:,1:end-1);
labels = X(:,end);
idx = kmeans(dataset,K);
gamma = 1;
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
        A(c1,:) = mean(UC{c1,1},1);
    else
        A(c1,:) = mean(UMC{c1-m1,1},1);
    end
end

labUnq = unique(labels);
lablUnqLngth = length(unique(labels));
hypPlnInf = cell(lablUnqLngth);
for c1 = 1:lablUnqLngth
    inds1 = A(:,end)==labUnq(c1);
    for c2 = 1:lablUnqLngth
        if c1==c2; continue; end
        inds2 = A(:,end)==labUnq(c2);
        dsTemp = [A(inds1,:); A(inds2,:)];
        svmModel = fitcsvm(dsTemp(:,1:end-1),dsTemp(:,end),'BoxConstraint',10,'KernelFunction','rbf');
        hypPlnInf{c1,c2} = cell(5,1);
        hypPlnInf{c1,c2}{1,1} = svmModel.Alpha;
        hypPlnInf{c1,c2}{2,1} = svmModel.SupportVectorLabels;
        hypPlnInf{c1,c2}{3,1} = svmModel.SupportVectors;
        hypPlnInf{c1,c2}{4,1} = svmModel.Bias;
        svNum = size(svmModel.SupportVectors,1);
        svDot = svDotCalc(svmModel.SupportVectors);
        svNorm2 = diag(svDot);
        hypPlnInf{c1,c2}{5,1} = sqrt(sum(sum((svmModel.Alpha*svmModel.Alpha').* ...
            (svmModel.SupportVectorLabels*svmModel.SupportVectorLabels').* ...
            exp(-gamma.*(repmat(svNorm2,1,svNum)+repmat(svNorm2',svNum,1)-2.*svDot)))));
    end
end

RS1 = MaxMinClustDis(UC,UMC,labUnq,gamma,hypPlnInf);

RS2 = cell(0);
for c1 = 1:size(RS1,1)
    dsTemp = RS1{c1,1};
    mu = mean(dsTemp(:,1:end-1),1);
    dist = pdist2(dsTemp(:,1:end-1),mu);
    [sDist, sDistInds] = sort(dist);
    rs2inds = FIFDR(sDist,sDistInds);
    RS2 = cellCat(RS2,dsTemp(rs2inds,:),'ver');
end

Xreduc = [];
for c1 = 1:size(RS2,1)
    Xreduc = [Xreduc; RS2{c1,1}];
end

end

