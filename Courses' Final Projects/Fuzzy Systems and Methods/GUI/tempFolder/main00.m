clear;
close all;
clc;
warning off;


prompt = {'Partitions No.:','Alpha value:','Stop Condition:','Max Iter:'};
dlg_title = 'Options';
num_lines = 1;
defaultans = {'2','2','.0001','1000'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
k = str2double(answer{1});
alpha = str2double(answer{2});
stopCond = str2double(answer{3});
maxIter = str2double(answer{4});

X = load('ds01.mat');
X = X.X;
clustNo = numel(unique(X(3,:)));
Colors = hsv(clustNo);

% cl1=X(1:2,X(3,:)==1); det1=det(cov(cl1')); cl2=X(1:2,X(3,:)==2); det2=det(cov(cl2'));
% rho = [det1 det2];rho = [det1 det2];
% rho = [5 2];
rho = rand(1,k);

figure;
gscatter(X(1,:),X(2,:),X(3,:),Colors); grid on;
title('The Main Dataset');
X = X(1:end-1,:);

% Performing Gustafson-Kessel Algorithm
[m_f,M_inv,W_GK,hFP_GK] = GK_clust(X,k,alpha,stopCond,maxIter,rho);
figure(hFP_GK);
title('The Final Result of GK Clutering Algorithm');

% Performing Fuzzy C-Means (FCM)
[V,W_FCM,hFP_FCM] = FCM(X,k,alpha,stopCond,maxIter);
figure(hFP_FCM);
title('The Final Result of FCM Clutering Algorithm');




