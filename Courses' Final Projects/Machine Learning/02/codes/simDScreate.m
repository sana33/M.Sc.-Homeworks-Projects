clc; close all; warning off

% creating simulated datasets
% creating train dataset
mu1 = [-7,-1]; mu2 = [5,1];
sigma1 = [3,-1.5;-1.5,1]; sigma2 = [4,1;1,1];
% rng default  % For reproducibility
rndInt = randi(3e4);
tr1 = [mvnrnd(mu1,sigma1,rndInt) ones(rndInt,1)];
tr2 = [mvnrnd(mu2,sigma2,5e4-rndInt) -ones(5e4-rndInt,1)];
trDS = [tr1;tr2];

% creating test dataset
rndInt = randi(3e4);
ts1 = [mvnrnd(mu1,sigma1,rndInt) ones(rndInt,1)];
ts2 = [mvnrnd(mu2,sigma2,5e4-rndInt) -ones(5e4-rndInt,1)];
tsDS = [ts1;ts2];