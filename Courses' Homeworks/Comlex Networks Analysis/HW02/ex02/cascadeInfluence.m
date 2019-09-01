function finalInfectedNodes = cascadeInfluence(adjMat, initialSet, q)
  %{
    input:
      adjMat: adjacency matrix of the graph
      initialSet: an initial set of infected nodes represented by a vector
      q: threshould value for no. of infected neighbours per total nodes of the graph, and then deciding to accept a behaviour or not
    output:
      final set of influenced nodes infected by the initial set specified above
  %}
  nodesNo = length(adjMat);
  initialSet = reshape(initialSet, 1, nodesNo);
  finalInfectedNodes = initialSet;
  finished = 0;
%   neighbNo = sum(G);
  while ~finished
    currInfecNodes = (finalInfectedNodes * adjMat / nodesNo >= q) | initialSet; 
%     newfn = (final_nodes * G ./ neighbNo >= q) | init_set; 
    finished = all(currInfecNodes == finalInfectedNodes);
    finalInfectedNodes = currInfecNodes;
  end
end