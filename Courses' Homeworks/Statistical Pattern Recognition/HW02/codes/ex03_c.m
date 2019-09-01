clear, close all, clc, warning off

xx1 = -10:.1:10; xx2 = -10:.1:10;
[x11,x22] = meshgrid(xx1,xx2);
prior1 = 1/3; prior2 = 1/3; prior3 = 1/3;

figure;
Sigma = [1 0; 0 1/3];
% Plotting class 1 pdf
mu1 = [0 2];
pdf1 = mvnpdf([x11(:) x22(:)],mu1,Sigma);
pdf1 = reshape(pdf1,length(xx2),length(xx1));
cMap1 = .5 * ones(length(xx2),length(xx1));
surf(xx1,xx2,pdf1,cMap1);
axis([-2 3.5 -2 3.5 0 .4]);
hold on;

% Plotting class 2 pdf
mu2 = [3 1];
pdf2 = mvnpdf([x11(:) x22(:)],mu2,Sigma);
pdf2 = reshape(pdf2,length(xx2),length(xx1));
cMap2 = zeros(length(xx2),length(xx1));
surf(xx1,xx2,pdf2,cMap2);
axis([-2 3.5 -2 3.5 0 .4]);

% Plotting class 3 pdf
mu3 = [1 0];
pdf3 = mvnpdf([x11(:) x22(:)],mu3,Sigma);
pdf3 = reshape(pdf3,length(xx2),length(xx1));
cMap3 = ones(length(xx2),length(xx1));
surf(xx1,xx2,pdf3,cMap3);
axis([-2 3.5 -2 3.5 0 .4]);

xlabel('x1'); ylabel('x2'); zlabel('Probability Density'); title('Data Distribution');

figure;
h1 = @(x1,x2) x2+3.*x1-6;
h2 = @(x1,x2) x2+.5.*x1-1.25;
h3 = @(x1,x2) x2-2.*x1+3.5;
fimplicit(h1,[-2 3.5 -2 3.5]); hold on; grid on;
fimplicit(h2,[-2 3.5 -2 3.5]);
fimplicit(h3,[-2 3.5 -2 3.5]);
