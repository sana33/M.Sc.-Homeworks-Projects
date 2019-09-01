clear, close all, clc, warning off

xx1 = -7:.1:7; xx2 = -7:.1:7;
[x11,x22] = meshgrid(xx1,xx2);
prior1 = .5; prior2 = .5;
c11 = 0; c12 = 1; c21 = 1; c22 = 0;

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
Hdr = @(x1,x2).5.*([x1; x2]-mu1')'*(Sigma1\([x1; x2]-mu1'))-.5.*([x1; x2]-mu2')'*(Sigma2\([x1; x2]-mu2'))+ ...
    .5.*log(det(Sigma1)/det(Sigma2))+log(((c21-c22)*prior2)/((c12-c11)*prior1));
subplot(1,2,2);
h1 = ezplot(Hdr,[-3,3,-3,3]); grid on; title('The Minimax Test Decision Rule');
h1.Color = 'r'; h1.LineWidth = 2;

H = sum(.5.*([x11(:) x22(:)]-repmat(mu1,numel(x11),1)).*(Sigma1\([x11(:) x22(:)]-repmat(mu1,numel(x11),1))')',2) ...
    -sum(.5.*([x11(:) x22(:)]-repmat(mu2,numel(x11),1)).*(Sigma2\([x11(:) x22(:)]-repmat(mu2,numel(x11),1))')',2) ...
    +.5.*log(det(Sigma1)/det(Sigma2))+log(((c21-c22)*prior2)/((c12-c11)*prior1));
H = reshape(H,length(xx2),length(xx1));
eps1 = sum(sum(pdf1(H>0)))/100;
eps2 = sum(sum(pdf2(H<0)))/100;
errorTotMiniMax = prior1 * eps1 + prior2 * eps2;
fprintf('The Eps1 value of Minimax test is: %0.5f\n',eps1);
fprintf('The Eps2 value of Minimax test is: %0.5f\n',eps2);
fprintf('The total error of Minimax test is: %0.5f\n',errorTotMiniMax);

% syms h(x1,x2);
% h(x1,x2) = .5.*([x1; x2]-mu1')'*(Sigma1\([x1; x2]-mu1'))-.5.*([x1; x2]-mu2')'*(Sigma2\([x1; x2]-mu2'))+ ...
%     .5.*log(det(Sigma1)/det(Sigma2))-log(prior1/prior2);
% figure; fimplicit(h);


