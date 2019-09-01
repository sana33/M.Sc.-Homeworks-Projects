clc, clear all, close all;

%% Question 7 - Part A
beta1 = 1;
axisX = 0:.01:4;
expPDF1 = pdf('Exponential', axisX, beta1);
figure(1);
subplot(3, 1, 1);
plot(axisX, expPDF1, 'b');
title('Q7-A');
legend('Exponential Distribution with Beta=1');

%% Question 7 - Part B
pdf1 = pdf('Exponential', 1, beta1);
pdf2 = pdf('Exponential', 2, beta1);
pdf4 = pdf('Exponential', 4, beta1);
likelihood = pdf1 .* pdf2 .* pdf4;
subplot(3, 1, 2);
plot(axisX, expPDF1, 'b');
title('Q7-B');
hold on
plot(1, pdf1, '-ok');
plot(2, pdf2, '-ok');
plot(4, pdf4, '-ok');
plot(2, pdf1 .* pdf2, '-ok');
plot(4, likelihood, '-sr');

%% Question 7 - Part C
beta2 = .5;
expPDF2 = pdf('Exponential', axisX, beta2);
subplot(3, 1, 3);
plot(axisX, expPDF2, 'b');
hold on;
title('Q7-C');
legend('Exponential Distribution with Beta=.5');
pdf1 = pdf('Exponential', 1, beta2);
pdf2 = pdf('Exponential', 2, beta2);
pdf4 = pdf('Exponential', 4, beta2);
likelihood = pdf1 .* pdf2 .* pdf4;
plot(1, pdf1, '-ok');
plot(2, pdf2, '-ok');
plot(4, pdf4, '-ok');
plot(2, pdf1 .* pdf2, '-ok');
plot(4, likelihood, '-sr');
