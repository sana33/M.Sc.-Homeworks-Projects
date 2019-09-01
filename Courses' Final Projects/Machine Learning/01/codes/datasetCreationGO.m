clear; close all; clc; warning off

% Creating a synthetic dataset with some samples as GLOBAL OUTLIERS
GOsynthDS = [];
dim = 37;
clustNo = 7;
mu = rand(1,dim);
mu = normalizeDataSet(mu,10,-10,0);
A = rand(dim);
covMat = A'*A;
clustMemb = randi([600,1000],1,clustNo);
for c1 = 1:clustNo
    clust = mvnrnd(mu,covMat,clustMemb(c1));
    clust = [clust zeros(size(clust,1),2)];
    clust(:,end-1) = c1;
    GOsynthDS = [GOsynthDS; clust];
end

GOs = rand(70,dim);
GOs = normalizeDataSet(GOs,40,50,1);
GOs = [GOs zeros(size(GOs,1),2)];
GOs(:,end) = 1;
GOsynthDS = [GOsynthDS; GOs];
GOsynthDS = GOsynthDS(randperm(length(GOsynthDS)),:);

save('synthDataset_GO','GOsynthDS');
