warning off;
graph1 = generate_graph(gml_read('dolphins.gml'));
graph2 = generate_graph(gml_read('karate.gml'));

[cliqueCellDolph,cliqueAdjDolph,communitiesDolph] = threeCliqueFinder(graph1);
[cliqueCellKara,cliqueAdjKara,communitiesKara] = threeCliqueFinder(graph2);

% Removing overlappings for graph dolphins
communitiesDolphOLnot = communitiesDolph;
for c1 = 1:length(communitiesDolphOLnot)-1
    commTmp1 = cell2mat(communitiesDolphOLnot(c1));
    for c2 = c1+1:length(communitiesDolphOLnot)
        commTmp2 = cell2mat(communitiesDolphOLnot(c2));
        commTmp1 = setdiff(commTmp1,commTmp2);
    end
    communitiesDolphOLnot(c1)= {commTmp1};
end
% Removing overlappings for graph karate
communitiesKaraOLnot = communitiesKara;
for c1 = 1:length(communitiesKaraOLnot)-1
    commTmp1 = cell2mat(communitiesKaraOLnot(c1));
    for c2 = c1+1:length(communitiesKaraOLnot)
        commTmp2 = cell2mat(communitiesKaraOLnot(c2));
        commTmp1 = setdiff(commTmp1,commTmp2);
    end
    communitiesKaraOLnot(c1)= {commTmp1};
end

% Calculating modularity
modulDolph = modulCalc(graph1,communitiesDolphOLnot);
modulKara = modulCalc(graph2,communitiesKaraOLnot);

