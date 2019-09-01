clear; close all; clc; warning off

%% Creating a synthetic symmetric dataset
nodesNo = 200;
edgeNo = 1000;
nodeFrom = randi([1 nodesNo],edgeNo,1,'double');
nodeTo = randi([1 nodesNo],edgeNo,1,'double');
timeStamp = randi([0 1e8],edgeNo,1,'double');

ds_synthTempSymm = [nodeFrom, nodeTo, ones(edgeNo,1), timeStamp];

save('ds_synthTempSymm.mat','ds_synthTempSymm');

%% Creating a synthetic asymmetric dataset
nodesNo = 300;
edgeNo = 2000;
nodeFrom = randi([1 nodesNo],edgeNo,1,'double');
nodeTo = randi([1 nodesNo],edgeNo,1,'double');
timeStamp = randi([0 1e8],edgeNo,1,'double');

ds_synthTempAsymm = [nodeFrom, nodeTo, ones(edgeNo,1), timeStamp];

save('ds_synthTempAsymm.mat','ds_synthTempAsymm');
