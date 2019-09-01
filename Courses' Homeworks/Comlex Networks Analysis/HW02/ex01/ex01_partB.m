clear; close all; clc; warning off;

%% Ex01 - Part B (link prediction utilizing pageRank)
graphKara = generate_graph(gml_read('karate.gml'));
gKaraBiog = biograph(graphKara, []);
gKaraBiog.LayoutType = 'equilibrium';
gKaraBiog.dolayout;

[clustIdx, rankMat] = pageRankPersonClust(graphKara, 2, .9);

gKaraNonZ = find(graphKara);
gKaraNonZLngth = length(gKaraNonZ);
% shuffInd = randperm(gKaraNonZLngth);
shuffInd = load('shuffInd'); shuffInd = shuffInd.shuffInd;
trainInd = shuffInd(1:floor(.66*gKaraNonZLngth));
testInd = shuffInd(floor(.66*gKaraNonZLngth)+1:end);
trainData = gKaraNonZ(trainInd,:);
testData = gKaraNonZ(testInd,:);

thMin = min(rankMat(trainData));
thMax = max(rankMat(trainData));

thetaVecTmp = linspace(thMin,thMax,999);
thetaVec = [quantile(thetaVecTmp,.1) quantile(thetaVecTmp,.2) quantile(thetaVecTmp,.3) quantile(thetaVecTmp,.4) ...
    quantile(thetaVecTmp,.5) quantile(thetaVecTmp,.6) quantile(thetaVecTmp,.7) quantile(thetaVecTmp,.8) ...
    quantile(thetaVecTmp,.9)];
testAcc = zeros(size(thetaVec));
for c1 = 1:length(thetaVec)
    testAcc(c1) = sum(rankMat(testData)>=thetaVec(c1))/length(testData);
end
[~,maxIdx] = max(testAcc);
thetaBest = thetaVec(maxIdx);

linksMiss = rankMat;
linksMiss(graphKara~=0) = 0;
for c1 = 1:length(rankMat); linksMiss(c1,c1)=0; end
linksPred = find(linksMiss>=thetaBest);

gKaraFinal = graphKara;
gKaraFinal(linksMiss>=thetaBest) = 2;
save('LinkPred_PageRank.mat','gKaraFinal');
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

