clear, close all, clc, warning off

w1 = [1 1; 2 2; 3 3; 1 -1; 0 1; 2 2];
w2 = [6 8; 7 9; 9 9; 6 8; 9 8; 9 11; 10 9; 10 7];
xmin = min([w1(:,1); w2(:,1)]); xmax = max([w1(:,1); w2(:,1)]);
ymin = min([w1(:,2); w2(:,2)]); ymax = max([w1(:,2); w2(:,2)]);

m1 = size(w1,1);
mu1 = sum(w1)/m1;
Sigma1 = (w1'*w1)/(m1-1) - mu1'*mu1;

m2 = size(w2,1);
mu2 = sum(w2)/m2;
Sigma2 = (w2'*w2)/(m2-1) - mu2'*mu2;

prior1 = m1/(m1+m2); prior2 = m2/(m1+m2);
% Plotting Bayes Decision Rule with Minimum Probability of Error
c11 = 0; c12 = 1; c22 = 0; c21 = 1;
H1 = @(x1,x2).5.*([x1; x2]-mu1')'*(Sigma1\([x1; x2]-mu1'))-.5.*([x1; x2]-mu2')'*(Sigma2\([x1; x2]-mu2'))+ ...
    .5.*log(det(Sigma1)/det(Sigma2))+log(((c21-c22)*prior2)/((c12-c11)*prior1));
c11 = 0; c12 = 1; c22 = 0; c21 = 3;
H2 = @(x1,x2).5.*([x1; x2]-mu1')'*(Sigma1\([x1; x2]-mu1'))-.5.*([x1; x2]-mu2')'*(Sigma2\([x1; x2]-mu2'))+ ...
    .5.*log(det(Sigma1)/det(Sigma2))+log(((c21-c22)*prior2)/((c12-c11)*prior1));
figure;
gscatter([w1(:,1);w2(:,1)],[w1(:,2);w2(:,2)],[ones(m1,1);2*ones(m2,1)],'br','so'); hold on; grid on;
h1 = ezplot(H1);
h1.Color = 'k'; h1.LineWidth = 2;
h2 = ezplot(H2);
h2.Color = 'c'; h2.LineWidth = 2;
legend('class w1','class w2','decision rule with symmetrical cost function', ...
    'decision rule with nonsymmetrical cost function','Location','northwest');
xlabel('x1'); ylabel('x2'); xlim([xmin-1 xmax+1]); ylim([ymin-1 ymax+1]);
title('Bayes Decision Rule with Minimum Probability of Error');


