clear; close all; clc; warning off

% ds_caHepPh = load('ds_caHepPh.mat'); ds_caHepPh = ds_caHepPh.ds_caHepPh; ds_caHepPh = double(ds_caHepPh);
% edgeList=[ds_caHepPh; [ds_caHepPh(:,2),ds_caHepPh(:,1),ds_caHepPh(:,3:4)]];
% nodesNo = max([edgeList(:,1); edgeList(:,2)]);
% edgesNo = length(edgeList)/2;
% A = sparse(edgeList(:,1),edgeList(:,2),edgeList(:,3),nodesNo,nodesNo,edgesNo);

A = generate_graph(gml_read('karate.gml'));
A = sparse(A);

[Blond_commArray, Blond_commInds] = BlondelSparse(A, 'symmetric', 1, 1, 5, 5);

VV = GCModulMax1(A);
