clear; close all; clc; warning off

theta = 0:.001:1;
y = zeros(1,length(theta));
y(1:find(theta==.6)-1) = 0;
y(find(theta==.6):end) = (1./theta(find(theta==.6):end)).^5;

figure;
plot(theta,y,'r','LineWidth',2); grid on;
xlabel('Theta value'); ylabel('MLE of Theta');
title('MLE per theta value');

