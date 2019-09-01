warning off;
graph1 = generate_graph(gml_read('dolphins.gml'));
graph2 = generate_graph(gml_read('karate.gml'));

g1Dolph = biograph(graph1, [], 'ShowArrows', 'off');
g2Kara = biograph(graph2, [], 'ShowArrows', 'off');

P1 = allshortestpaths(g1Dolph, 'Directed', false);
P2 = allshortestpaths(g2Kara, 'Directed', false);
% Considering inf distances as zero
P1(P1==inf) = 0; P2(P2==inf) = 0;

tmp1 = eye(size(graph1)) - (1/length(graph1)) .* ones(size(graph1));
Ptld1 = -1/2 .* (tmp1 * (P1 .^ 2) * tmp1);
tmp2 = eye(size(graph2)) - (1/length(graph2)) .* ones(size(graph2));
Ptld2 = -1/2 .* (tmp2 * (P2 .^ 2) * tmp2);

[eV1,eD1] = eig(Ptld1,'vector');
[eV2,eD2] = eig(Ptld2,'vector');

eigPair1 = sortrows([eD1 transpose(eV1)]);
eigPair2 = sortrows([eD2 transpose(eV2)]);
V1sort = transpose(eigPair1(:,2:end));
V2sort = transpose(eigPair2(:,2:end));
D1sort = eigPair1(:,1);
D2sort = eigPair2(:,1);

D1cs = cumsum(flip(D1sort))./sum(D1sort);
D2cs = cumsum(flip(D2sort))./sum(D2sort);

bestLamNo1 = find(D1cs>=.8,1);
bestLamNo2 = find(D2cs>=.8,1);

V1 = flip(V1sort(:,end-bestLamNo1+1:end),2);
V2 = flip(V2sort(:,end-bestLamNo2+1:end),2);

Lambda1 = diag(flip(D1sort(end-bestLamNo1+1:end)));
Lambda2 = diag(flip(D2sort(end-bestLamNo2+1:end)));

SS1 = V1 * Lambda1;
SS2 = V2 * Lambda2;

%% Considering graph dolphins
commNo = 2;
modulArrDolph = [1 0];
commArrayDolph = 0;
while true
    commArrayBESTDolph = commArrayDolph;
    idx1 = kmeans(SS1,commNo);
    commArrayDolph = cell(1,commNo);
    for c1 = 1:commNo; commArrayDolph(c1) = {find(idx1==c1)}; end;
    modulDolph = modulCalc(graph1, commArrayDolph);
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

%% Considering graph karate
commNo = 2;
modulArrKara = [1 0];
commArrayKara = 0;
while true
    commArrayBESTKara = commArrayKara;
    idx2 = kmeans(SS2,commNo);
    commArrayKara = cell(1,commNo);
    for c1 = 1:commNo; commArrayKara(c1) = {find(idx2==c1)}; end;
    modulKara = modulCalc(graph2, commArrayKara);
    modulKara
    modulArrKara = [modulArrKara modulKara];
    if modulArrKara(end)-modulArrKara(end-1)<=0 && modulArrKara(end-1)-modulArrKara(end-2)>=0 ...
            && modulArrKara(end-1)>=.3 && modulArrKara(end-1)<=.7
%     if modulArrDolph(end)-modulArrDolph(end-1)<=0 && modulArrDolph(end-1)-modulArrDolph(end-2)>=0
        commNoBESTkara = commNo-1;
        modulBESTkara = modulArrKara(end-1);
        modulArrKara = modulArrKara(2:end);
        break;
    else
        commNo = commNo+1; 
    end;
end
