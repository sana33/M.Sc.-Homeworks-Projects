clear; close all; clc; warning off

%% Part a
X = [3 2 4 0 6 3 1 5 -1 7; 1 3 -1 7 -5 1 0 2 -1 3];
group = [1 1 1 1 1 -1 -1 -1 -1 -1];
figure;
gscatter(X(1,:),X(2,:),group,'br','so'); grid on;
title('Scatterd Data Points'); xlabel('x1'); ylabel('x2');

%% Part b
Y = X - repmat(mean(X,2),1,size(X,2));

%% Part c
C = (1/(size(Y,2)-1))*(Y*Y');
[V,D] = eig(C);

%% Part d
Yp1 = V(:,2)'*Y;
varYp1 = var(Yp1);
fprintf('The accounted fraction of the total variance of the data by the first principle component of C is:\t%0.5f\n',varYp1);

%% Part e
v1 = V(:,1); v2 = V(:,2);
figure;
gscatter(X(1,:),X(2,:),group,'br','so'); grid on; hold on;
h1 = ezplot(@(x1,x2) v1(1).*x1+v1(2).*x2,[min(X(1,:))-1,max(X(1,:))+1,min(X(2,:))-1,max(X(2,:))+1]);
h1.LineWidth = 2; h1.Color = 'r';
h2 = ezplot(@(x1,x2) v2(1).*x1+v2(2).*x2,[min(X(1,:))-1,max(X(1,:))+1,min(X(2,:))-1,max(X(2,:))+1]);
h2.LineWidth = 2; h2.Color = 'r';
title('Scatterd Data Points with Principle Component Eigenvectors'); xlabel('x1'); ylabel('x2');

%% Part f
Yp1 = V(:,2)'*Y; Yp2 = V(:,1)'*Y;
figure;
subplot(1,2,1); gscatter(Yp1,zeros(size(Y,2),1),group,'br','so'); grid on; hold on;
title('Projected data points on the first principle component');
subplot(1,2,2); gscatter(Yp2,zeros(size(Y,2),1),group,'br','so'); grid on; hold on;
title('Projected data points on the second principle component');


