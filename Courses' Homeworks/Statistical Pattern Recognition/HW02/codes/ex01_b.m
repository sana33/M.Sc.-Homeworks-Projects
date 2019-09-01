clear, close all, clc, warning off

xx1 = -7:.1:7; xx2 = -7:.1:7;
[x11,x22] = meshgrid(xx1,xx2);
prior1 = .5; prior2 = .5;
c11 = 0; c12 = 2; c21 = 1; c22 = 0;

figure;
% Plotting class 1 pdf
mu1 = [1 0];
Sigma1 = [1 .5; .5 1];
pdf1 = mvnpdf([x11(:) x22(:)],mu1,Sigma1);
pdf1 = reshape(pdf1,length(xx2),length(xx1));
cMap1 = ones(length(xx2),length(xx1));
subplot(1,2,1);
surf(xx1,xx2,pdf1,cMap1);
axis([-3 3 -3 3 0 .3]);
hold on;

% Plotting class 2 pdf
mu2 = [-1 0];
Sigma2 = [1 -.5; -.5 1];
pdf2 = mvnpdf([x11(:) x22(:)],mu2,Sigma2);
pdf2 = reshape(pdf2,length(xx2),length(xx1));
cMap2 = zeros(length(xx2),length(xx1));
subplot(1,2,1);
surf(xx1,xx2,pdf2,cMap2);
axis([-3 3 -3 3 0 .3]);
xlabel('x1'); ylabel('x2'); zlabel('Probability Density'); title('Data Distribution');

% Plotting Bayes Decision Rule with Minimum Risk
H = @(x1,x2).5.*([x1; x2]-mu1')'*(Sigma1\([x1; x2]-mu1'))-.5.*([x1; x2]-mu2')'*(Sigma2\([x1; x2]-mu2'))+ ...
    .5.*log(det(Sigma1)/det(Sigma2))+log(((c21-c22)*prior2)/((c12-c11)*prior1));
subplot(1,2,2);
h1 = ezplot(H,[-3,3,-3,3]); grid on; title('Bayes Decision Rule with Minimum Risk');
h1.Color = 'r'; h1.LineWidth = 2;

% syms h(x1,x2);
% h(x1,x2) = .5.*([x1; x2]-mu1')'*(Sigma1\([x1; x2]-mu1'))-.5.*([x1; x2]-mu2')'*(Sigma2\([x1; x2]-mu2'))+ ...
%     .5.*log(det(Sigma1)/det(Sigma2))-log(prior1/prior2);
% figure; fimplicit(h);


