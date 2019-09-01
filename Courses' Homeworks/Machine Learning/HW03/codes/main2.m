warning off

% cd C:\bnt_1.0.7
% addpath(genpathKPM(pwd))

dataSet = load('dataSet.txt');

% Considering leave-one-out procedure
corrClassTAN = 0;
corrClassNB = 0;
for c1 = 1:size(dataSet,1)
    trainDS = dataSet([1:c1-1 c1+1:end],:);
    featNo = size(trainDS,2)-1;
    testItem = dataSet(c1,:);
    evidence = cell(1,featNo+1);
    evidence(2:featNo+1) = num2cell(testItem(2:end));
    CMI = zeros(featNo,featNo,2);
    for c2 = 1:2
        for c3 = 1:featNo
            for c4 = 1:featNo
                CMI(c3,c4,c2) = cmiCalc(c3,c4,c2,trainDS);
            end
        end
    end
    CMIfinal = CMI(:,:,1) + CMI(:,:,2);
    CMItmp = CMIfinal - diag(diag(CMIfinal));
    CMItmpMax = max(max(CMItmp));
    CMItmpSp = sparse(CMItmp);
    CMItmpSp(find(CMItmpSp)) = CMItmpSp(find(CMItmpSp))*-1 + 2*CMItmpMax;
    CMItmpBg = biograph(CMItmpSp,[],'ShowArrows','off','ShowWeights','on');
    [maxSpanTree,~] = minspantree(CMItmpBg);
    maxSpanTree(find(maxSpanTree)) = maxSpanTree(find(maxSpanTree))*-1 + 2*CMItmpMax;
    [tanStrcBg,rootInd] = tanMaker(maxSpanTree,0);
    % Considering bnet
    tanDAG = getmatrix(tanStrcBg);
    tanDAG = double(full(tanDAG));
    nbDAG = tanDAG; nbDAG(2:end,:) = 0;
    node_sizes = [2 3.*ones(1,featNo)];
    bnetTAN = mk_bnet(tanDAG,node_sizes);
    bnetNB = mk_bnet(nbDAG,node_sizes);
    for c5 = 1:featNo+1; bnetTAN.CPD{c5} = tabular_CPD(bnetTAN,c5); end;
    for c5 = 1:featNo+1; bnetNB.CPD{c5} = tabular_CPD(bnetNB,c5); end;
    bnetTAN = learn_params(bnetTAN,num2cell(trainDS'));
    bnetNB = learn_params(bnetNB,num2cell(trainDS'));
    engineTAN = jtree_inf_engine(bnetTAN);
    engineNB = jtree_inf_engine(bnetNB);
    mpeTAN = find_mpe(engineTAN,evidence);
    mpeNB = find_mpe(engineNB,evidence);
    corrClassTAN = corrClassTAN + double(cell2mat(mpeTAN(1))==testItem(1));
    corrClassNB = corrClassNB + double(cell2mat(mpeNB(1))==testItem(1));
end
accTAN = corrClassTAN / size(dataSet,1) * 100;
accNB = corrClassNB / size(dataSet,1) * 100;

fprintf('Final Results:\n');
fprintf('\tTAN Structure:\n\t\tCorrectly Classified: %d\n\t\tIncorrectly Classified: %d\n\t\tAccuracy: %0.2f\n',corrClassTAN,size(dataSet,1)-corrClassTAN,accTAN);
fprintf('-----------------------------------------------\n');
fprintf('\tNB Structure:\n\t\tCorrectly Classified: %d\n\t\tIncorrectly Classified: %d\n\t\tAccuracy: %0.2f\n',corrClassNB,size(dataSet,1)-corrClassNB,accNB);

