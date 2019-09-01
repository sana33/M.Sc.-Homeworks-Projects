clear;
close all;
clc;
warning off;

%% Making cluster01
mu1 = [-20,0];
var1 = [1,60];
n1 = 1000;
clust1 = makeUncorrClust(mu1,var1,n1);

alpha1 = 45;
clust1 = [clust1; zeros(1,n1)];
R = rotz(alpha1);
clust1 = R*clust1;
clust1 = clust1(1:end-1,:);

%% Making cluster02
mu2 = [0,0];
var2 = [2,60];
n2 = 1000;
clust2 = makeUncorrClust(mu2,var2,n2);

alpha2 = -45;
clust2 = [clust2; zeros(1,n2)];
R = rotz(alpha2);
clust2 = R*clust2;
clust2 = clust2(1:end-1,:);

%% Making and plotting dataset
clust1 = clust1+[-5; -5];
X = [[clust1; ones(1,n1)] [clust2; 2*ones(1,n2)]];

figure;
gscatter(X(1,:),X(2,:),X(3,:),'gb'); grid on;

% save('ds.mat','X');
