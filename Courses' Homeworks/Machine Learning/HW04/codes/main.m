clear; close all; clc; warning off;

dataSet = csvread('Data.csv');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 1
dataC0 = dataSet(dataSet(:,3)==0,1:2);
dataC1 = dataSet(dataSet(:,3)==1,1:2);

figure(1);
scatter(dataC0(:,1),dataC0(:,2),[],'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5); hold on; grid on;
scatter(dataC1(:,1),dataC1(:,2),[],'MarkerEdgeColor',[.5 .5 0],'MarkerFaceColor',[.7 .7 0],'LineWidth',1.5);
legend('Class 0','Class 1'); title('Part 1 - Plotted Data');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 2
dsLength = length(dataSet);
% shuffledInd = randperm(dsLength);
shuffledInd = load('shuffledInd.mat'); shuffledInd = shuffledInd.shuffledInd;
trainInd = shuffledInd(1:floor(.5*dsLength));
testInd = shuffledInd(floor(.5*dsLength)+1:end);
trainData = dataSet(trainInd,:);
testData = dataSet(testInd,:);

% Making the SVM model using training data
boxCons = .1; % The regularization term
svmModel = fitcsvm(trainData(:,1:end-1),trainData(:,end),'BoxConstraint',boxCons);
SVs = svmModel.SupportVectors;

% Plotting training data and support vectors
trainDataC0 = trainData(trainData(:,3)==0,1:2);
trainDataC1 = trainData(trainData(:,3)==1,1:2);

figure(2); % figure for part 2
% figure(10); figure for part 3
scatter(trainDataC0(:,1),trainDataC0(:,2),[],'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5); hold on; grid on;
scatter(trainDataC1(:,1),trainDataC1(:,2),[],'MarkerEdgeColor',[.5 .5 0],'MarkerFaceColor',[.7 .7 0],'LineWidth',1.5);
plot(SVs(:,1),SVs(:,2),'ks','MarkerSize',13);
legend('Class 0','Class 1','Support Vectors');

% Plotting decision boundary and margins
alpha = svmModel.Alpha;
svLabels = svmModel.SupportVectorLabels;
bias = svmModel.Bias;

w = transpose(alpha .* svLabels) * SVs;
% Plotting decision boundary
h1 = ezplot(@(x,y)svPlot(w,bias,x,y), [min(trainData(:,1)), max(trainData(:,1)), min(trainData(:,2)), max(trainData(:,2))]);
set(h1, 'Color', 'r', 'LineWidth', 1.2);
% Plotting margins
h2 = ezplot(@(x,y)svPlot(w,bias+1/norm(w),x,y), [min(trainData(:,1)), max(trainData(:,1)), min(trainData(:,2)), max(trainData(:,2))]);
set(h2, 'Color', 'b', 'LineWidth', 1.2);
h3 = ezplot(@(x,y)svPlot(w,bias-1/norm(w),x,y), [min(trainData(:,1)), max(trainData(:,1)), min(trainData(:,2)), max(trainData(:,2))]);
set(h3, 'Color', 'b', 'LineWidth', 1.2);
title('Part 2 - Linear SVM'); % Title for part 2
% title(sprintf('Part 3 - Linear SVM with Parameter C = %d',boxCons)); % Title for part 3

% SVM model prediction on training data and test data
svmPredTrain = predict(svmModel, trainData(:,1:end-1));
svmPredTest = predict(svmModel, testData(:,1:end-1));

svmPredTrainAcc = sum(svmPredTrain == trainData(:,end)) / length(trainData);
svmPredTestAcc = sum(svmPredTest == testData(:,end)) / length(testData);

fprintf('\nPart 2:\n\tLinear SVM prediction accuracy on training data:\t%0.2f perc.\n\tLinear SVM prediction accuracy on test data:\t%0.2f perc.\n',svmPredTrainAcc*100,svmPredTestAcc*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 3
% By changing the boxCons value in Part 2 we can gain different decision
% boundaries and margins
% boxCons = .1; boxCons = 100; boxCons = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 4
% Considering polynomial kernel
% Making the SVM model using training data
polyOrder = 10;
svmModel = fitcsvm(trainData(:,1:end-1),trainData(:,end),'KernelFunction','polynomial','PolynomialOrder',polyOrder);
SVs = svmModel.SupportVectors;

% Plotting training data and support vectors
trainDataC0 = trainData(trainData(:,3)==0,1:2);
trainDataC1 = trainData(trainData(:,3)==1,1:2);

figure(3);
scatter(trainDataC0(:,1),trainDataC0(:,2),[],'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5); hold on; grid on;
scatter(trainDataC1(:,1),trainDataC1(:,2),[],'MarkerEdgeColor',[.5 .5 0],'MarkerFaceColor',[.7 .7 0],'LineWidth',1.5);
plot(SVs(:,1),SVs(:,2),'ks','MarkerSize',13);
legend('Class 0','Class 1','Support Vectors'); title('Part 4 - Polynomial Kernel');

% SVM model prediction on training data and test data
svmPredTrain = predict(svmModel, trainData(:,1:end-1));
svmPredTest = predict(svmModel, testData(:,1:end-1));

svmPredTrainAcc = sum(svmPredTrain == trainData(:,end)) / length(trainData);
svmPredTestAcc = sum(svmPredTest == testData(:,end)) / length(testData);

fprintf('\nPart 4:\n\tSVM (Polynomial(order=%d) Kernel) prediction accuracy on training data:\t%0.2f perc.\n\tSVM (Polynomial(order=%d) Kernel) prediction accuracy on test data:\t%0.2f perc.\n',polyOrder,svmPredTrainAcc*100,polyOrder,svmPredTestAcc*100);

% Considering RBF kernel
% Making the SVM model using training data
svmModel = fitcsvm(trainData(:,1:end-1),trainData(:,end),'KernelFunction','rbf');
SVs = svmModel.SupportVectors;

% Plotting training data and support vectors
trainDataC0 = trainData(trainData(:,3)==0,1:2);
trainDataC1 = trainData(trainData(:,3)==1,1:2);

figure(4);
scatter(trainDataC0(:,1),trainDataC0(:,2),[],'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5); hold on; grid on;
scatter(trainDataC1(:,1),trainDataC1(:,2),[],'MarkerEdgeColor',[.5 .5 0],'MarkerFaceColor',[.7 .7 0],'LineWidth',1.5);
plot(SVs(:,1),SVs(:,2),'ks','MarkerSize',13);
legend('Class 0','Class 1','Support Vectors'); title('Part 4 - RBF Kernel');

% SVM model prediction on training data and test data
svmPredTrain = predict(svmModel, trainData(:,1:end-1));
svmPredTest = predict(svmModel, testData(:,1:end-1));

svmPredTrainAcc = sum(svmPredTrain == trainData(:,end)) / length(trainData);
svmPredTestAcc = sum(svmPredTest == testData(:,end)) / length(testData);

fprintf('\nPart 4:\n\tSVM (RBF Kernel) prediction accuracy on training data:\t%0.2f perc.\n\tSVM (RBF Kernel) prediction accuracy on test data:\t%0.2f perc.\n',svmPredTrainAcc*100,svmPredTestAcc*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 5
p5trainInd = shuffledInd(1:floor(.6*dsLength));
p5evalInd = shuffledInd(floor(.6*dsLength)+1:floor(.8*dsLength));
p5testInd = shuffledInd(floor(.8*dsLength)+1:end);
p5trainData = dataSet(p5trainInd,:);
p5evalData = dataSet(p5evalInd,:);
p5testData = dataSet(p5testInd,:);

p5evalAccVec = [];
for c1 = 1:500
    p5svmModel = fitcsvm(p5trainData(:,1:end-1),p5trainData(:,end),'KernelFunction','rbf','BoxConstraint',c1*.0001);
%     p5SVs = p5svmModel.SupportVectors;
    % Assessment on evaluation data
    p5PredEval = predict(p5svmModel,p5evalData(:,1:2));
    p5EvalAcc = sum(p5PredEval == p5evalData(:,end)) / length(p5evalData);
    p5evalAccVec = [p5evalAccVec p5EvalAcc];
end

figure(5);
plot(.0001:.0001:.05,p5evalAccVec,'r','LineWidth',1.2); title('Part 5 - EvalAccuracy per RegularizationTerm(C)','Color','b'); grid on;
xlabel('RegularizationTerm(C)','FontSize',12,'FontWeight','bold','Color','k')
ylabel('EvalAccuracy','FontSize',12,'FontWeight','bold','Color','k')

[bestAcc,bestC] = max(p5evalAccVec);
bestC = bestC * .0001;

% Assessment on test data
p5svmModelBestEval = fitcsvm(p5trainData(:,1:end-1),p5trainData(:,end),'KernelFunction','rbf','BoxConstraint',bestC*.0001);
p5PredTestBestEval = predict(p5svmModelBestEval,p5testData(:,1:2));
p5TestAccBestEval = sum(p5PredTestBestEval == p5testData(:,end)) / length(p5testData);

p5PredTestMaxIter = predict(p5svmModel,p5testData(:,1:2));
p5TestAccMaxIter = sum(p5PredTestMaxIter == p5testData(:,end)) / length(p5testData);

fprintf('\nPart 5:\n\tThe best value for regularization term:\t%0.4f\n\tSVM (RBF Kernel) prediction accuracy on test data by best value for param. C obtained on evaluation data:\t%0.2f perc.\n\tSVM (RBF Kernel) prediction accuracy on test data by value for param. C obtained on maxIteration:\t%0.2f perc.\n',bestC,p5TestAccBestEval*100,p5TestAccMaxIter*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 6
% Gaining test data belonging prob.
p6svmModel = svmtrain(p5trainData(:,3),p5trainData(:,1:2),'-s 0 -t 2 -g 2 -c .0199 -b 1 -q');
p6SVs = full(p6svmModel.SVs);

[p6PredTest, p6Acc, p6ProbEst] = svmpredict(p5testData(:,end),p5testData(:,1:end-1),p6svmModel,'-b 1 -q'); % p6ProbEst is the test data belonging prob. vector
save('p6ProbEst.mat','p6ProbEst');

figure(6);
gscatter(p5trainData(:,1),p5trainData(:,2),p5trainData(:,3)); grid on; hold on;
plot(p6SVs(:,1),p6SVs(:,2),'ks','MarkerSize',13);

% Plotting ROC cure
[xAxis,yAxis] = perfcurve(p5testData(:,3),p6PredTest,1);
figure(7);
plot(xAxis,yAxis,'r','LineWidth',1.2); grid on;
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC for classification by SVM (RBF Kernel)');


