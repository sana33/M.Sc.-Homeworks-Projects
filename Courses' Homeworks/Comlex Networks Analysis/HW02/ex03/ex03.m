clear; close all; clc; warning off;

%% Ex03 - Implementing Stochastic Block Model for link prediction
graphKara = generate_graph(gml_read('karate.gml'));
gKaraBiog = biograph(graphKara, []);
gKaraBiog.LayoutType = 'equilibrium';
gKaraBiog.dolayout;

gKlength = length(graphKara);
partSamplesNo = input('Please enter number of partition samples [e.g. 1000]:\n');
partMaxNo = input('\nPlease enter maximum no. of partitions to which the graph should be divided(less than 34) [e.g. 12]:\n');
pM = input('\nPlease enter the constant value for prior [e.g. .5]:\n');

partitionsTot = cell(1,partSamplesNo);
qMat = zeros(gKlength,gKlength,partSamplesNo);
likeHoodVec = ones(1,partSamplesNo);
for c1 = 1:partSamplesNo
    seqPerm = randperm(gKlength);
    partNo = randi(partMaxNo); if partNo==1; partNo=partNo+1; end
    partEndPoints = randperm(gKlength-1, partNo-1);
    partEndPoints = sort(partEndPoints);
    partitionCurr = cell(1,partNo);
    partEndPoints = [0 partEndPoints gKlength];
    for c2 = 1:length(partEndPoints)-1
        partitionCurr(c2) = {seqPerm(partEndPoints(c2)+1:partEndPoints(c2+1))};
    end
    partitionsTot(c1) = {partitionCurr};
    for c3 = 1:length(partitionCurr)
        part1 = cell2mat(partitionCurr(c3));
        for c4 = c3:length(partitionCurr)
            part2 = cell2mat(partitionCurr(c4));
            part12coinc = graphKara(part1,part2);
            if c3==c4
                linksExist = sum(sum(part12coinc))/2;
                linksPoss = length(part1)*(length(part1)-1)/2;
            else
                linksExist = sum(sum(part12coinc));
                linksPoss = length(part1)*length(part2);
            end
            qValue = linksExist/linksPoss; if isnan(qValue); qValue=0; end
            if qValue~=0 && qValue~=1
                likeHoodVec(c1) = likeHoodVec(c1)*(qValue^linksExist)*((1-qValue)^(linksPoss-linksExist));
            end
            qMat(part1,part2,c1) = qValue; qMat(part2,part1,c1) = qValue;
        end
    end
    for c5 = 1:gKlength; qMat(c5,c5,c1)=0; end
end

likeHoodMat = zeros(gKlength,gKlength,partSamplesNo);
for c6 = 1:partSamplesNo; likeHoodMat(:,:,c6)=likeHoodVec(c6)*ones(gKlength); end

reliableMat = sum(qMat.*likeHoodMat.*pM,3) ./ sum(likeHoodVec.*pM);

gKaraNonZ = find(graphKara);
gKaraNonZLngth = length(gKaraNonZ);
% shuffInd = randperm(gKaraNonZLngth);
shuffInd = load('shuffInd'); shuffInd = shuffInd.shuffInd;
trainInd = shuffInd(1:floor(.66*gKaraNonZLngth));
testInd = shuffInd(floor(.66*gKaraNonZLngth)+1:end);
trainData = gKaraNonZ(trainInd,:);
testData = gKaraNonZ(testInd,:);

thMin = min(reliableMat(trainData));
thMax = max(reliableMat(trainData));

thetaVecTmp = linspace(thMin,thMax,999);
thetaVec = [quantile(thetaVecTmp,.1) quantile(thetaVecTmp,.2) quantile(thetaVecTmp,.3) quantile(thetaVecTmp,.4) ...
    quantile(thetaVecTmp,.5) quantile(thetaVecTmp,.6) quantile(thetaVecTmp,.7) quantile(thetaVecTmp,.8) ...
    quantile(thetaVecTmp,.9)];
testAcc = zeros(size(thetaVec));
for c1 = 1:length(thetaVec)
    testAcc(c1) = sum(reliableMat(testData)>=thetaVec(c1))/length(testData);
end
[~,maxIdx] = max(testAcc);
thetaBest = thetaVec(maxIdx);

linksMiss = reliableMat;
linksMiss(graphKara~=0) = 0;
for c1 = 1:length(reliableMat); linksMiss(c1,c1)=0; end
linksPred = find(linksMiss>=thetaBest);

gKaraFinal = graphKara;
gKaraFinal(linksMiss>=thetaBest) = 2;
save('LinkPred_StochBlockModel.mat','gKaraFinal');
gKaraFinalBiog = biograph(gKaraFinal, []);
gKaraFinalBiog.LayoutType = 'equilibrium';
gKaraFinalBiog.dolayout;

for c1 = 1:length(gKaraFinalBiog.Edges)
    if gKaraFinalBiog.Edges(c1).Weight==2
        gKaraFinalBiog.Edges(c1).LineColor = [.63 .16 .79];
        gKaraFinalBiog.Edges(c1).Description = 'Predicted Link';
    else
        gKaraFinalBiog.Edges(c1).LineColor = [0 0 0];
        gKaraFinalBiog.Edges(c1).Description = 'Existent Link';
    end
end

view(gKaraBiog);
view(gKaraFinalBiog);

%% comparing to result of pageRank link prediction
linkPredPageRank = load('LinkPred_PageRank.mat'); linkPredPageRank = linkPredPageRank.gKaraFinal;
linkPredStochBlock = gKaraFinal;

linksExistentNo = sum(sum(graphKara==1))/2;
linksMissedNo = (sum(sum(graphKara~=1))-gKlength)/2;
linksPredPageRankNo = sum(sum(linkPredPageRank==2))/2;
linksPredStochBlockNo = sum(sum(linkPredStochBlock==2))/2;

linkPredPageRank(linkPredPageRank~=2) = 0;
linkPredStochBlock(linkPredStochBlock~=2) = 0;
predSame = sum(sum(linkPredPageRank==linkPredStochBlock & linkPredPageRank==2 & linkPredStochBlock==2));
[~,maxPredInd] = max([linksPredPageRankNo linksPredStochBlockNo]);
if maxPredInd==1; maxPredName='PageRank'; else maxPredName='Stochastic Block Model'; end

fprintf('\n1)PageRank Predicted Links No.:\t%d\n2)StochasticBlockModel Predicted Links No.:\t%d\nMax predicted algorithm:\t\"%d)%s\"\nPrediction coincidence no.:\t%d\n\n',linksPredPageRankNo,linksPredStochBlockNo,maxPredInd,maxPredName,predSame);

figure;
barComp = bar([linksExistentNo linksMissedNo linksPredPageRankNo; ...
    linksExistentNo linksMissedNo linksPredStochBlockNo]); grid on;
barComp(3).LineWidth = 2; barComp(3).EdgeColor = 'r'; barComp(3).FaceColor = [0 0 0];
title({'PageRank(1) Link Prediction'; 'versus'; 'StochasticBlockModel(2) Link Prediction'}, 'Color', 'b');
legend('Existent Links No.','Missing Links No.','Predicted Links No.');
