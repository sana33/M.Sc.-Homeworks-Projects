warning off;
graph1 = generate_graph(gml_read('dolphins.gml'));
graph2 = generate_graph(gml_read('karate.gml'));

graph1Biog = graph1 - triu(graph1);
graph2Biog = graph2 - triu(graph2);
g1Dolph = biograph(graph1Biog, [], 'ShowArrows', 'off');
g1DolphMerg = biograph(graph1Biog, [], 'ShowArrows', 'off', 'Label', 'Merged Graph of Dolphins with cutoff edges');
set(g1DolphMerg.Edges, 'LineWidth', 1.5);
g2Kara = biograph(graph2Biog, [], 'ShowArrows', 'off');
g2KaraMerg = biograph(graph2Biog, [], 'ShowArrows', 'off', 'Label', 'Merged Graph of Karates with cutoff edges');
set(g2KaraMerg.Edges, 'LineWidth', 1.5);

degVec1 = sum(graph1);
degVec2 = sum(graph2);
degMat1 = diag(sum(graph1));
degMat2 = diag(sum(graph2));

lapMat1 = degMat1 - graph1;
lapMat2 = degMat2 - graph2;

[V1,D1] = eig(lapMat1,'vector');
[V2,D2] = eig(lapMat2,'vector');

secSmlEigV1 = V1(:,2);
secSmlEigV2 = V2(:,2);

G1Dolph = [];
G2Dolph = [];
G1Kara = [];
G2Kara = [];

%% Considering graph dolphins
for c1 = 1:length(graph1)
    if secSmlEigV1(c1)<0; G1Dolph = [G1Dolph c1]; else G2Dolph = [G2Dolph c1]; end;
end
graph1Sep = zeros(size(graph1));
for c1 = 1:length(graph1)
    if any(c1==G1Dolph)
        for c2 = 1:length(G1Dolph)
            graph1Sep(c1,G1Dolph(c2)) = graph1(c1,G1Dolph(c2));
        end
    else
        for c2 = 1:length(G2Dolph)
            graph1Sep(c1,G2Dolph(c2)) = graph1(c1,G2Dolph(c2));
        end
    end
end
graph1SepBiog = graph1Sep - triu(graph1Sep);
graph1Diff = graph1Biog~=graph1SepBiog;
edgeCounter = 0;
for c1 = 1:length(graph1Diff)
    for c2 = 1:length(graph1Diff)
        if graph1Biog(c1,c2)~=0; edgeCounter=edgeCounter+1; end;
        if graph1Diff(c1,c2)~=0
%             fprintf('Node %d -> Node %d\n',c1,c2);
            g1DolphMerg.edges(edgeCounter).LineColor = [.9725 .9725 .9725];
            g1DolphMerg.edges(edgeCounter).LineWidth = .1;
        end
    end
end
g1DolphSepBiog = biograph(graph1SepBiog, [], 'ShowArrows', 'off', 'Label', 'Separated Graph of Dolphins without cutoff edges');
view(g1DolphMerg); view(g1DolphSepBiog);
% Calculating Modularity for only one step separation for graph dolphins
commArray1 = cell(1,2);
commArray1{1} = G1Dolph; commArray1{2} = G2Dolph;
modul1 = modulCalc(graph1, commArray1); modul1


%% Considering graph karate
for c1 = 1:length(graph2)
    if secSmlEigV2(c1)<0; G1Kara = [G1Kara c1]; else G2Kara = [G2Kara c1]; end;
end
graph2Sep = zeros(size(graph2));
for c1 = 1:length(graph2)
    if any(c1==G1Kara)
        for c2 = 1:length(G1Kara)
            graph2Sep(c1,G1Kara(c2)) = graph2(c1,G1Kara(c2));
        end
    else
        for c2 = 1:length(G2Kara)
            graph2Sep(c1,G2Kara(c2)) = graph2(c1,G2Kara(c2));
        end
    end
end
graph2SepBiog = graph2Sep - triu(graph2Sep);
graph2Diff = graph2Biog~=graph2SepBiog;
edgeCounter = 0;
for c1 = 1:length(graph2Diff)
    for c2 = 1:length(graph2Diff)
        if graph2Biog(c1,c2)~=0; edgeCounter=edgeCounter+1; end;
        if graph2Diff(c1,c2)~=0
%             fprintf('Node %d -> Node %d\n',c1,c2);
            g2KaraMerg.edges(edgeCounter).LineColor = [.9725 .9725 .9725];
            g2KaraMerg.edges(edgeCounter).LineWidth = .1;
        end
    end
end
g1KaraSepBiog = biograph(graph2SepBiog, [], 'ShowArrows', 'off', 'Label', 'Separated Graph of Karates without cutoff edges');
view(g2KaraMerg); view(g1KaraSepBiog);
% Calculating Modularity for only one step separation for graph karate
commArray2 = cell(1,2);
commArray2{1} = G1Kara; commArray2{2} = G2Kara;
modul2 = modulCalc(graph2, commArray2); modul2
