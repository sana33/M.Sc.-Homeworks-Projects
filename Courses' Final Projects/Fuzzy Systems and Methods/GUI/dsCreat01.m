clear;
close all;
clc;
warning off;

%% Making cluster01
n1 = 10;
clust1 = [normalizeDataSet(rand(1,n1), .1, -.1, 0); normalizeDataSet(rand(1,n1), 1, -1, 0)];


%% Making cluster02
n2 = 10;
clust2 = [normalizeDataSet(rand(1,n2), 1, -1, 0); normalizeDataSet(rand(1,n2), .1, -.1, 0)];


%% Making and plotting dataset
X = [[clust1; ones(1,n1)] [clust2; 2*ones(1,n2)]];

figure;
gscatter(X(1,:),X(2,:),X(3,:),'gb'); grid on;

% save('ds.mat','X');
