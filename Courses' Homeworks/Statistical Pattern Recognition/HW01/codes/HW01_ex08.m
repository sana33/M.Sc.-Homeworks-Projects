clear, clc, close all, warning off

samplesNo = 500;
X = mvnrnd(zeros(1,2),eye(2),samplesNo);

figure;
scatter(X(:,1),X(:,2),'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5); grid on; hold on;

A = [-5 5; 1 1]; b = [.5; 1];
Y = A * transpose(X) + repmat(b,1,samplesNo);
% YY = X * transpose(A) + repmat(transpose(b),samplesNo,1); all(transpose(Y)==YY)
Y = transpose(Y);

scatter(Y(:,1),Y(:,2),'d','MarkerEdgeColor',[.5 0 .5],'MarkerFaceColor',[.7 0 .7],'LineWidth',1.5);
xlim([min(min(X(:,1),min(Y(:,1)))),max(max(X(:,1),max(Y(:,1))))]);
ylim([min(min(X(:,1),min(Y(:,1)))),max(max(X(:,1),max(Y(:,1))))]);
legend('Gaussian Mixture','Transformed Gaussian Mixture');
