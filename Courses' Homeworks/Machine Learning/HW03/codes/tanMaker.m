function [tanStrcBg,rootInd] = tanMaker(maxSpanTree,showResult)
    warning off
    treeFull = full(maxSpanTree);
    treeFull = treeFull + treeFull';
    tfTmp = treeFull;
    tfTmp(tfTmp~=0) = 1;
    [~,rootInd]=max(sum(tfTmp));
    tfFinal = treeFull;
    nodesNo = 1;
    parInd = rootInd;
    while nodesNo < length(treeFull)
        parDescTot = [];
        for c1 = 1:length(parInd)
            parDesc = find(tfFinal(parInd(c1),:));
            parDescTot = [parDescTot parDesc];
            for c2 = parDesc
                tfFinal(c2,parInd(c1)) = 0;
            end
            nodesNo = nodesNo + length(parDesc);
        end
        parInd = parDescTot;
    end
    tanStrc = zeros(1+length(treeFull));
    tanStrc(2:end,2:end) = tfFinal;
    tanStrc(1,2:end) = 1;
    
    featNo = length(treeFull);
    NodeIDs = {'ClassType'};
    for c1 = 1:featNo; NodeIDs = [NodeIDs {sprintf('feature%d',c1)}]; end;
    % Considering TAN structure
    tanStrcBg = biograph(tanStrc,NodeIDs,'Description','TAN Structure');
    tanStrcBg.Nodes(1).Shape = 'circle';
    tanStrcBg.Nodes(1).Size = [15 15];
    tanStrcBg.Nodes(1).Color = [.5 .7 1];
    tanStrcBg.Nodes(1).FontSize = 11;
    tanStrcBg.Nodes(1).TextColor = [1 1 1];
    tanStrcBg.Nodes(1).Color = [0 0 0];
    % Considering undirected maximum weighted spanning tree
    maxUndirSpanTreeBg = biograph(tfFinal,NodeIDs,'ShowArrows','off','Description','maximumUndirectedSpanningTree');
    % Considering directed maximum weighted spanning tree
    maxDirSpanTreeBg = biograph(tfFinal,NodeIDs,'Description','maximumDirectedSpanningTree');
    
    for c1 = 1:length(treeFull)
        tanStrcBg.Edges(c1).LineColor = [1 0 0];
        tanStrcBg.Edges(c1).LineWidth = .9;
        tanStrcBg.Nodes(c1+1).Shape = 'ellipse';
        maxUndirSpanTreeBg.Nodes(c1).Shape = 'ellipse';
        maxDirSpanTreeBg.Nodes(c1).Shape = 'ellipse';
    end    
    
    if showResult==1; maxUndirSpanTreeBg.view; maxDirSpanTreeBg.view; tanStrcBg.view; end;
