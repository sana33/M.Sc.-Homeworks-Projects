clear, close all, clc, warning off

trainSet = load('Iris_train.dat'); trainNo = size(trainSet,1);
testSet = load('Iris_test.dat'); testNo = size(testSet,1);
trainSet = trainSet(:,[2 end]);
testSet = testSet(:,[2 end]);
clsSetoTrInds = trainSet(:,2)==0; clsSetoTrNo = sum(clsSetoTrInds);
clsVersTrInds = trainSet(:,2)==1; clsVersTrNo = sum(clsVersTrInds);
clsSetoTsInds = testSet(:,2)==0; clsSetoTsNo = sum(clsSetoTsInds);
clsVersTsInds = testSet(:,2)==1; clsVersTsNo = sum(clsVersTsInds);

%% Part a
nbins = 1:.2:5;
figure;
subplot(2,1,1); histogram(trainSet(clsSetoTrInds,1),nbins,'FaceColor','blue'); grid on;
xlabel('Sepal Width'); ylabel('Histogram Distribution');
xlim([1 5]); title('Class "Iris Setosa" Histogram');
subplot(2,1,2); histogram(trainSet(clsVersTrInds,1),nbins,'FaceColor','red'); grid on;
xlabel('Sepal Width'); ylabel('Histogram Distribution');
xlim([1 5]); title('Class "Iris Versicolor" Histogram');

%% Part b
priorSetosa = sum(clsSetoTrInds)/trainNo;
priorVersicolor = sum(clsVersTrInds)/trainNo;
fprintf('Class Setosa a Priori Prob.:\t%0.2f\n',priorSetosa);
fprintf('Class Versicolor a Priori Prob.:\t%0.2f\n\n',priorVersicolor);

%% Part c
mu1 = mean(trainSet(clsSetoTrInds,1)); std1 = std(trainSet(clsSetoTrInds,1));
mu2 = mean(trainSet(clsVersTrInds,1)); std2 = std(trainSet(clsVersTrInds,1));
fprintf('Class Setosa mean:\t%0.3f,\tvariance:\t%0.3f\n',mu1,std1.^2);
fprintf('Class Versicolor mean:\t%0.3f,\tvariance:\t%0.3f\n\n',mu2,std2.^2);

%% Part d
minTr = min(trainSet(:,1)); maxTr = max(trainSet(:,1));
pdf1 = normpdf(minTr-2:.01:maxTr+2,mu1,std1);
pdf2 = normpdf(minTr-2:.01:maxTr+2,mu2,std2);

figure;
plot(minTr-2:.01:maxTr+2,pdf1,'b','LineWidth',1.5); hold on; grid on;
plot(minTr-2:.01:maxTr+2,pdf2,'r','LineWidth',1.5);
legend('class-cond. prob. dens. of class setosa','class-cond. prob. dens. of class versicolor');
xlabel('Sepal Width'); ylabel('Estimated Class-Conditional Prob. Density');
title('Estimated Class-Conditional Prob. Densities of 2 Class');

post1 = (pdf1.*priorSetosa)./(pdf1.*priorSetosa+pdf2.*priorVersicolor);
post2 = (pdf2.*priorVersicolor)./(pdf1.*priorSetosa+pdf2.*priorVersicolor);
figure;
plot(minTr-2:.01:maxTr+2,post1,'b','LineWidth',1.5); hold on; grid on;
plot(minTr-2:.01:maxTr+2,post2,'r','LineWidth',1.5);
legend('a post. prob. dens. of class setosa','a post. prob. dens. of class versicolor');
xlabel('Sepal Width'); ylabel('Estimated a Posteriori Prob. Density');
title('Estimated a Posteriori Prob. Densities of 2 Class');

%% Part e
syms x;
eqn1 = .5*((x-mu1)/std1).^2-.5*((x-mu2)/std2).^2+log(std1/std2) == 0;
solP = double(solve(eqn1,x)); solP = sort(solP);
figure;
plot(minTr-2:.01:maxTr+2,priorSetosa*pdf1,'b','LineWidth',1.5); hold on; grid on;
plot(minTr-2:.01:maxTr+2,priorVersicolor*pdf2,'r','LineWidth',1.5);
H1 = @(x1,x2) x1-solP(1); H2 = @(x1,x2) x1-solP(2);
h1 = ezplot(H1); h2 = ezplot(H2);
h1.Color = 'k'; h1.LineWidth = 2; h2.Color = 'k'; h2.LineWidth = 2;
legend('unnormalized a posteriori prob. dens. of class setosa', ...
    'unnormalized a posteriori prob. dens. of class versicolor', ...
    'bayes decision rule with minimum error 1', ...
    'bayes decision rule with minimum error 2','Location','northwest');
xlabel('x1'); ylabel('Unnormalized a Posteriori Prob. Density');
xlim auto; ylim([0 1.2]);
title('Bayes Decision Rule with Minimum Probability of Error for Iris TrainSet');

trainClsf = .5*((trainSet(:,1)-mu1)./std1).^2-.5*((trainSet(:,1)-mu2)./std2).^2+log(std1/std2);
trainClsf(trainClsf<0) = 0; trainClsf(trainClsf>0) = 1;
clsSetoTrMsClsNo = sum(trainClsf(clsSetoTrInds)~=0);
clsVersTrMsClsNo = sum(trainClsf(clsVersTrInds)~=1);
trainMsClsPerc = sum(trainClsf~=trainSet(:,2))/trainNo;
fprintf('# of Class Setosa Misclassified Items:\t%d out of %d Training Items\n',clsSetoTrMsClsNo,clsSetoTrNo);
fprintf('# of Class Versicolor Misclassified Items:\t%d out of %d Training Items\n',clsVersTrMsClsNo,clsVersTrNo);
fprintf('Percentage of incorrectly classified Training Data Items:\t%0.3f\n\n',trainMsClsPerc);

%% Part f
testClsf = .5*((testSet(:,1)-mu1)./std1).^2-.5*((testSet(:,1)-mu2)./std2).^2+log(std1/std2);
testClsf(testClsf<0) = 0; testClsf(testClsf>0) = 1;
clsSetoTsMsClsNo = sum(testClsf(clsSetoTsInds)~=0);
clsVersTsMsClsNo = sum(testClsf(clsVersTsInds)~=1);
testMsClsPerc = sum(testClsf~=testSet(:,2))/testNo;
fprintf('# of Class Setosa Misclassified Items:\t%d out of %d Test Items\n',clsSetoTsMsClsNo,clsSetoTsNo);
fprintf('# of Class Versicolor Misclassified Items:\t%d out of %d Test Items\n',clsVersTsMsClsNo,clsVersTsNo);
fprintf('Percentage of incorrectly classified Test Data Items:\t%0.3f\n\n',testMsClsPerc);

