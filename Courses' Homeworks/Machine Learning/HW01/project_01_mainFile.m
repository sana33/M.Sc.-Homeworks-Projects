clc, clear, close all

dataSet = load('data.txt');
xx = dataSet(:,1);
yy = dataSet(:,2);
xxMin = min(xx); xxMax = max(xx);
yyMin = min(yy); yyMax = max(yy);

%% Considering cubic polynomial
% Plotting estimated curved lines
figure(1);
subplot(3,1,1);
scatter(xx, yy, 'filled', 'MarkerEdgeColor', [0 .5 .5], 'MarkerFaceColor', [0 .7 .7], 'LineWidth', 1.5); grid on;
hold on;
X = [ones(length(dataSet),1) xx xx.^2 xx.^3];
eye3 = eye(4); eye3(1,1) = 0;
theta3_lam0 = inv(transpose(X) * X + 0 * eye3) * transpose(X) * yy;
h1 = ezplot(@(x,y)poly3Plot(theta3_lam0, x, y), [xxMin-2, xxMax+2, yyMin-2, yyMax+2]);
theta3_lam1 = inv(transpose(X) * X + 1 * eye3) * transpose(X) * yy;
h2 = ezplot(@(x,y)poly3Plot(theta3_lam1, x, y), [xxMin-2, xxMax+2, yyMin-2, yyMax+2]);
theta3_lam10 = inv(transpose(X) * X + 10 * eye3) * transpose(X) * yy;
h3 = ezplot(@(x,y)poly3Plot(theta3_lam10, x, y), [xxMin-2, xxMax+2, yyMin-2, yyMax+2]);
title('Cubic Polynomial');
set(h1, 'Color', 'k'); set(h2, 'Color', 'r'); set(h3, 'Color', 'b');
drawnow; legend('dataPoints', 'lambda=0', 'lambda=1', 'lambda=10');
% Plotting norms of theta vectors
thetaNorms = [norm(theta3_lam0) norm(theta3_lam1) norm(theta3_lam10)];
subplot(3,1,2);
plot(thetaNorms, '-rs', 'LineWidth', 2); grid on; title('Theta Vectors Norms');
% Plotting MSE errors according to different values of lambda
mseErrors_lam0 = mean((X * theta3_lam0 - yy) .^ 2);
mseErrors_lam1 = mean((X * theta3_lam1 - yy) .^ 2);
mseErrors_lam10 = mean((X * theta3_lam10 - yy) .^ 2);
mseErrors = [mseErrors_lam0 mseErrors_lam1 mseErrors_lam10];
subplot(3,1,3);
plot(mseErrors, '-ro', 'LineWidth', 2); grid on; title('MSE Errors per Lambda Values');

%% Considering sextic grade polynomial
% Plotting estimated curved lines
figure(2);
subplot(3,1,1);
scatter(xx, yy, 'filled', 'MarkerEdgeColor', [0 .5 .5], 'MarkerFaceColor', [0 .7 .7], 'LineWidth', 1.5); grid on;
hold on;
X = [ones(length(dataSet),1) xx xx.^2 xx.^3 xx.^4 xx.^5 xx.^6];
eye6 = eye(7); eye6(1,1) = 0;
theta6_lam0 = inv(transpose(X) * X + 0 * eye6) * transpose(X) * yy;
h1 = ezplot(@(x,y)poly6Plot(theta6_lam0, x, y), [xxMin-2, xxMax+2, yyMin-2, yyMax+2]);
theta6_lam1 = inv(transpose(X) * X + 1 * eye6) * transpose(X) * yy;
h2 = ezplot(@(x,y)poly6Plot(theta6_lam1, x, y), [xxMin-2, xxMax+2, yyMin-2, yyMax+2]);
theta6_lam10 = inv(transpose(X) * X + 10 * eye6) * transpose(X) * yy;
h3 = ezplot(@(x,y)poly6Plot(theta6_lam10, x, y), [xxMin-2, xxMax+2, yyMin-2, yyMax+2]);
title('Sextic Grade Polynomial');
set(h1, 'Color', 'k'); set(h2, 'Color', 'r'); set(h3, 'Color', 'b');
drawnow; legend('dataPoints', 'lambda=0', 'lambda=1', 'lambda=10');
% Plotting norms of theta vectors
thetaNorms = [norm(theta6_lam0) norm(theta6_lam1) norm(theta6_lam10)];
subplot(3,1,2);
plot(thetaNorms, '-rs', 'LineWidth', 2); grid on; title('Theta Vectors Norms');
% Plotting MSE errors according to different values of lambda
mseErrors_lam0 = mean((X * theta6_lam0 - yy) .^ 2);
mseErrors_lam1 = mean((X * theta6_lam1 - yy) .^ 2);
mseErrors_lam10 = mean((X * theta6_lam10 - yy) .^ 2);
mseErrors = [mseErrors_lam0 mseErrors_lam1 mseErrors_lam10];
subplot(3,1,3);
plot(mseErrors, '-ro', 'LineWidth', 2); grid on; title('MSE Errors per Lambda Values');


