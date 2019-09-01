% clc;
% close all;
warning off

%% considering results 1
% loading simulated data sets
load('..\datasets\Simulated data set\trDS.mat','trDS');
load('..\datasets\Simulated data set\tsDS.mat','tsDS');

[clfAccPropMethSimDS_p1,trTimePropMethSimDS_p1] = result1(trDS,tsDS,2:5:120,[0 120],'simulated data set');

% loading coverType data set
load('..\datasets\covertype dataset\covtype.data');
covtype2 = covtype(1:1e4,:);
trDS = covtype2(1:9e3,:);
tsDS = covtype2(9e3+1:end,:);
[clfAccPropMethCovTypeDS_p1,trTimePropMethCovTypeDS_p1] = result1(trDS,tsDS,2:5:150,[0 150],'covertype data set');

%% considering results 2
load('..\datasets\covertype dataset\covtype.data');
covtype2 = covtype(1:1e4,:);
trDS = covtype2(1:9e3,:);
tsDS = covtype2(9e3+1:end,:);
[clfAccPropMethCovTypeDS_p2,trTimePropMethCovTypeDS_p2] = result2(trDS,tsDS,100);





