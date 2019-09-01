function Graph = generate_graph(AdjacencyMatrix)
if (find(AdjacencyMatrix==0))
    AdjacencyMatrix = AdjacencyMatrix + 1;
end
nodeno = max(AdjacencyMatrix(:,1));
Graph(1:nodeno,1:nodeno) = 0;
for i=1:size(AdjacencyMatrix,1)
    Graph(AdjacencyMatrix(i,1),AdjacencyMatrix(i,2)) = 1;
    Graph(AdjacencyMatrix(i,2),AdjacencyMatrix(i,1)) = 1;
end

end