clear; close all; clc; warning off

mu1 = [10,10]; mu2 = [22,10];
sigma = [4,4;4,9];
rng default  % For reproducibility
m1 = 1000; m2 = 1000;
C1 = mvnrnd(mu1,sigma,m1);
C2 = mvnrnd(mu2,sigma,m2);

figure;
plot(C1(:,1),C1(:,2),'+',C2(:,1),C2(:,2),'o'); grid on;
xlabel('x1'); ylabel('x2'); title('Scattered Data Points');

%% Part a
X = [C1; C2];
Y = X - repmat(mean(X),size(X,1),1);
S = Y'*Y;
[V,D] = eig(S);
pc1 = V(:,2);
group = [ones(m1,1); 2*ones(m2,1)];
figure;
gscatter(Y(:,1),Y(:,2),group,'br','so'); grid on; hold on;
h1 = ezplot(@(x1,x2) pc1(1).*x1+pc1(2).*x2,[min(Y(:,1))-1,max(Y(:,1))+1,min(Y(:,2))-1,max(Y(:,2)+1)]);
h1.LineWidth = 2; h1.Color = 'k';
xlabel('x1'); ylabel('x2'); title('Scattered Data Points with Their First Principle Component');
legend('class 1','class 2','The First PC');
xlim([-15 15]); ylim([-15 15]);

%% Part b
Yp = Y*pc1;
figure; gscatter(Yp,zeros(m1+m2,1),group,'br','so'); grid on; hold on;
title('Projected data points on the first principle component');

%% Part d
Ypp = [Yp zeros(size(Yp,1),1)];
Yrec = Ypp*V;
figure; gscatter(Yrec(:,1),Yrec(:,2),group,'br','so'); grid on; hold on;
title('Reconstructed data points in to the 2-dimensional space');
recErr = mean(sum((Yrec-Y).^2,2));
fprintf('The reconstruction error is:\t%0.5f\n',recErr);

%% Part e
mean1 = mean(C1); mean2 = mean(C2);
S1 = (C1-repmat(mean1,m1,1))'*(C1-repmat(mean1,m1,1));
S2 = (C2-repmat(mean2,m2,1))'*(C2-repmat(mean2,m2,1));
Sw = S1 + S2;
W = Sw\(mean1-mean2)';
figure;
plot(C1(:,1),C1(:,2),'+',C2(:,1),C2(:,2),'o'); grid on; hold on;
h2 = ezplot(@(x1,x2) W(1).*x1+W(2).*x2,[min(X(:,1))-1,max(X(:,1))+1,min(X(:,2))-1,max(X(:,2)+1)]);
h2.LineWidth = 2; h2.Color = 'k';
xlabel('x1'); ylabel('x2'); title('Scattered Data Points with The LDA Projection Line');
legend('class 1','class 2','The LDA Proj. Line');

%% Part f
Zp = X*W;
figure; gscatter(Zp,zeros(m1+m2,1),group,'br','so'); grid on; hold on;
title('Projected data points on the resulting LDA');
