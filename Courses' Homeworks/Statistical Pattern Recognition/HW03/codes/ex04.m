clear; close all; clc; warning off

X = [0 8 6 4 2; 4 3 -2 0 1];
Y = [+1 +1 -1 -1 -1];

figure; h1 = gscatter(X(1,:),X(2,:),Y,'br','so'); grid on;
xlabel('x'); ylabel('y'); title('2-dimensional data points with their class labels');
legend('class -','class +','location','southwest');
h1(1).LineWidth = 2; h1(2).LineWidth = 2;
h1(1).MarkerFaceColor = 'b'; h1(2).MarkerFaceColor = 'r';


