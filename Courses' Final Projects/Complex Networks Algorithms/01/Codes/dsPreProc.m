clear; close all; clc; warning off

% Converting from milisecond to day; 1 Day = 24*3600*1000 ms = 86400000
ms2day = 864e5;
ms2hour = 36e5;

%% Considering ca-cit-HepPh dataset
% Opening dataset file
fileID = fopen('ds_ca-cit-HepPh.txt');
C = textscan(fileID,'%d %d %d %d');
fclose(fileID);
% Making edgelist with timestamps
% ds_caHepPh = [C{1}, C{2}, C{3}, floor(C{4}./ms2day)];
ds_caHepPh = [C{1}, C{2}, C{3}, C{4}];
% Removing loops and outliers
ds_caHepPh = edgeListPreProc(ds_caHepPh);
ds_caHepPh = sortrows(ds_caHepPh,4);
save('ds_caHepPh','ds_caHepPh');

%% Considering facebook-links dataset
% Opening dataset file
fileID = fopen('ds_facebook-wosn-links.txt');
C = textscan(fileID,'%d %d %d %d');
fclose(fileID);
% Making edgelist with timestamps
% ds_fbLinks = [C{1}, C{2}, C{3}, floor(C{4}./ms2day)];
ds_fbLinks = [C{1}, C{2}, C{3}, C{4}];
% Removing loops and outliers
ds_fbLinks = edgeListPreProc(ds_fbLinks);
ds_fbLinks = sortrows(ds_fbLinks,4);
save('ds_fbLinks','ds_fbLinks');

%% Considering enronEmail dataset
% Opening dataset file
fileID = fopen('ds_enronEmail.txt');
C = textscan(fileID,'%d %d %d %d');
fclose(fileID);
% Making edgelist with timestamps
% ds_enronEmail = [C{1}, C{2}, C{3}, floor(C{4}./ms2day)];
ds_enronEmail = [C{1}, C{2}, C{3}, C{4}];
% Removing loops and outliers
ds_enronEmail = edgeListPreProc(ds_enronEmail);
ds_enronEmail = sortrows(ds_enronEmail,4);
save('ds_enronEmail','ds_enronEmail');

%% Considering wiki-conflict dataset
% Opening dataset file
fileID = fopen('ds_wikiconflict.txt');
C = textscan(fileID,'%d %d %d %d');
fclose(fileID);
% Making edgelist with timestamps
% ds_wikiConflict = [C{1}, C{2}, C{3}, floor(C{4}./ms2day)];
ds_wikiConflict = [C{1}, C{2}, C{3}, C{4}];
% Removing loops and outliers
ds_wikiConflict = edgeListPreProc(ds_wikiConflict);
ds_wikiConflict = sortrows(ds_wikiConflict,4);
save('ds_wikiConflict','ds_wikiConflict');

