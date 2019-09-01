clear, close all, clc, warning off

%% Part a
prior1 = .5; prior2 = .5;
f1 = makedist('Uniform','lower',2,'upper',4);
f2 = makedist('Exponential','mu',1);
x = 0:.001:5;
p1 = prior1 * pdf(f1,x);
p2 = prior2 * pdf(f2,x);

figure;
plot(x,p1,'-r','LineWidth',1.5); grid on; hold on;
plot(x,p2,'-b','LineWidth',1.5);

h1 = ezplot(@(x1,x2)x1-2); h2 = ezplot(@(x1,x2)x1-4);
h1.Color = 'Black'; h1.LineStyle = '--'; h1.LineWidth = 1.8;
h2.Color = 'Black'; h2.LineStyle = '--'; h2.LineWidth = 1.8;
xlim([0 5]); ylim([0 .5]); xlabel('x1'); ylabel('x2');
legend('Uniform Dist. with a=2 & b=4','Exponential Dist. with lambda=1','Decision Rule 1','Decision Rule 2', ...
    'Location','northwest');
title('2 Class Distributions with Decision Rules');

%% Part b
prior1 = .5; prior2 = .5;
f1 = makedist('Uniform','lower',2,'upper',22);
f2 = makedist('Exponential','mu',1);
x = 0:.001:25;
p1 = prior1 * pdf(f1,x);
p2 = prior2 * pdf(f2,x);

figure;
plot(x,p1,'-r','LineWidth',1.5); grid on; hold on;
plot(x,p2,'-b','LineWidth',1.5);

h1 = ezplot(@(x1,x2)x1-2.9957); h2 = ezplot(@(x1,x2)x1-22);
h1.Color = 'Black'; h1.LineStyle = '--'; h1.LineWidth = 1.8;
h2.Color = 'Black'; h2.LineStyle = '--'; h2.LineWidth = 1.8;
xlim([0 25]); ylim([0 .5]); xlabel('x1'); ylabel('x2');
legend('Uniform Dist. with a=2 & b=22','Exponential Dist. with lambda=1','Decision Rule 1','Decision Rule 2', ...
    'Location','northwest');
title('2 Class Distributions with Decision Rules');

