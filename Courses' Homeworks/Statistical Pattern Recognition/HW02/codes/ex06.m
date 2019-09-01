clear, close all, clc, warning off

x1 = -5:.1:5; x2 = -5:.1:5;
[X1,X2] = meshgrid(x1,x2);
prior1 = .5; prior2 = .5;
mu = [0 0];

Sigma1 = [1 0; 0 4];
pdf1 = mvnpdf([X1(:) X2(:)],mu,Sigma1);
pdf1 = reshape(pdf1,length(x2),length(x1));

Sigma2 = [4 0; 0 1];
pdf2 = mvnpdf([X1(:) X2(:)],mu,Sigma2);
pdf2 = reshape(pdf2,length(x2),length(x1));

figure;
cn1 = contour(x2,x1,pdf1); hold on;
cn2 = contour(x2,x1,pdf2);

h1 = @(x1,x2) x1.^2-x2.^2;
ezplot(h1,[-5 5 -5 5]); hold on;

y1 = -5:.5:5; y2 = -5:.5:5;
[Y1,Y2] = meshgrid(y1,y2);
Yres = zeros(length(y2),length(y1));
Yres((Y1.^2-Y2.^2)<0) = 1;
Yres((Y1.^2-Y2.^2)>0) = 2;
scatter(Y1(:),Y2(:),[],Yres(:));

xlabel('x1'); ylabel('x2'); zlabel('Probability Density Contour Lines'); title('Data Distribution Contours and The Decision Rule');
