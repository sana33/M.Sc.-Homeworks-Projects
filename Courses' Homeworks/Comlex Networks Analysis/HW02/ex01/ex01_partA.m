clear; close all; clc; warning off;

%% Ex01 - Part A (personalized pageRank)
graphKara = generate_graph(gml_read('karate.gml'));
gKaraBiog = biograph(graphKara, []);
gKaraBiog.LayoutType = 'equilibrium';
gKaraBiog.dolayout;

beta = input('\nPlease enter the Beta value in (.8-.9):\n');
clustNo = input('\nPlease enter number of clusters into which the graph should be divided [e.g. 2]:\n');
[clustIdx, rankMat] = pageRankPersonClust(graphKara, clustNo, beta);
clustColors = [
  1 1 1;
  1 0 0;
  0 1 0;
  0 0 1;
  0 1 1;
  1 0 1;
  1 1 0;
];
clustShape = {
    'ellipse';
    'rect';
    'house';
    'trapezium';    
    'invtrapezium';
    'invhouse';
    'circle';    
};

for c1 = 1:length(gKaraBiog.Nodes)
    gKaraBiog.Nodes(c1).Color = clustColors(clustIdx(c1),:);
    gKaraBiog.Nodes(c1).Shape = char(clustShape(clustIdx(c1)));
end

view(gKaraBiog);
