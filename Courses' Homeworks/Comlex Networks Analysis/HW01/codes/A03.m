warning off;
graph1 = generate_graph(gml_read('dolphins.gml'));
graph2 = generate_graph(gml_read('karate.gml'));

%% Considering graph dolphins
commNo = 2;
modulArrDolph = [1 0];
commMembStrMatDolph = 0; commArrayOLdolph = 0; commArrayOLnotDolph = 0;
while true
    caolBESTdolph = commArrayOLdolph;
    caolnBESTdolph = commArrayOLnotDolph;
    cmsmBESTdolph = commMembStrMatDolph;
    [commArrayOLdolph, commArrayOLnotDolph, commMembStrMatDolph] = AGMclust(graph1,commNo);
    modulDolph = modulCalc(graph1, commArrayOLnotDolph);
    modulDolph
    modulArrDolph = [modulArrDolph modulDolph];
    if modulArrDolph(end)-modulArrDolph(end-1)<=0 && modulArrDolph(end-1)-modulArrDolph(end-2)>=0 ...
            && modulArrDolph(end-1)>=.3 && modulArrDolph(end-1)<=.7
%     if modulArrDolph(end)-modulArrDolph(end-1)<=0 && modulArrDolph(end-1)-modulArrDolph(end-2)>=0
        commNoBESTdolph = commNo-1;
        modulBESTdolph = modulArrDolph(end-1);
        modulArrDolph = modulArrDolph(2:end);
        break;
    else
        commNo = commNo+1; 
    end;
end

%% Computing Normalized Mutual Information (NMI) for the gained partition by AGM for graph dolphins
commBaseDolph = load('commArrayBESTDolph.mat','commArrayBESTDolph');
NMIdolph = NMIcompute(caolnBESTdolph,commBaseDolph.commArrayBESTDolph,length(graph1));

%% Considering graph karate
commNo = 2;
modulArrKara = [1 0];
commMembStrMatKara = 0; commArrayOLkara = 0; commArrayOLnotKara = 0;
while true
    caolBESTkara = commArrayOLkara;
    caolnBESTkara = commArrayOLnotKara;
    cmsmBESTkara = commMembStrMatKara;
    [commArrayOLkara, commArrayOLnotKara, commMembStrMatKara] = AGMclust(graph2,commNo);
    modulKara = modulCalc(graph2, commArrayOLnotKara);
    modulKara
    modulArrKara = [modulArrKara modulKara];
    if modulArrKara(end)-modulArrKara(end-1)<=0 && modulArrKara(end-1)-modulArrKara(end-2)>=0 ...
            && modulArrKara(end-1)>=.3 && modulArrKara(end-1)<=.7
%     if modulArrKara(end)-modulArrKara(end-1)<=0 && modulArrKara(end-1)-modulArrKara(end-2)>=0
        commNoBESTkara = commNo-1;
        modulBESTkara = modulArrKara(end-1);
        modulArrKara = modulArrKara(2:end);
        break;
    else
        commNo = commNo+1; 
    end;
end

%% Computing Normalized Mutual Information (NMI) for the gained partition by AGM for graph karate
commBaseKara = load('commArrayBESTKara.mat','commArrayBESTKara');
NMIkara = NMIcompute(caolnBESTkara,commBaseKara.commArrayBESTKara,length(graph2));

%% Showing final results
fprintf('\nGRAPH dolphins:\n------------------\n\tBest number of communities:  %d\n\tBest size of modularity:  %.4f\n\tValue of NMI:  %.4f\n',commNoBESTdolph,modulBESTdolph,NMIdolph);
fprintf('\nGRAPH karate:\n------------------\n\tBest number of communities:  %d\n\tBest size of modularity:  %.4f\n\tValue of NMI:  %.4f\n',commNoBESTkara,modulBESTkara,NMIkara);
