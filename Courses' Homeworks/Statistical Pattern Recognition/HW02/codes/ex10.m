clear, close all, clc, warning off

w1 = [1 1; 1 2; 1 3; 2 1; 3 1; 3 3]';
w2 = [2 2; 3 2; 3 4; 5 1; 5 4; 5 5]';
m1 = size(w1,2);
m2 = size(w2,2);
xmin = min([w1(1,:) w2(1,:)],[],2); xmax = max([w1(1,:) w2(1,:)],[],2);
ymin = min([w1(2,:) w2(2,:)],[],2); ymax = max([w1(2,:) w2(2,:)],[],2);
mu1 = mean(w1,2);
mu2 = mean(w2,2);
d1 = w1 - repmat(mu1,1,size(w1,2));
d2 = w2 - repmat(mu2,1,size(w2,2));
S1 = d1 * d1';
S2 = d2 * d2';
Sw = S1 + S2;
SwInv = inv(Sw);
W = Sw \ (mu1-mu2);

H1 = @(x1,x2) W'*[x1;x2];
figure;
gscatter([w1(1,:) w2(1,:)],[w1(2,:) w2(2,:)],[ones(1,m1) 2*ones(1,m2)],'br','so'); hold on; grid on;
h1 = ezplot(H1);
h1.Color = 'k'; h1.LineWidth = 2;
legend('class w1','class w2','Projection line of Fisher linear discriminant method','Location','northwest');
xlabel('x1'); ylabel('x2');
xlim auto; ylim auto;
title('Fisher linear discriminant method');

w1p = W'*w1; w2p = W'*w2;
minP = min([w1p w2p]); maxP = max([w1p w2p]);
mu1p = mean(w1p); mu2p = mean(w2p);
std1p = std(w1p); std2p = std(w2p);
syms x;
eqn1 = .5*((x-mu1p)/std1p).^2-.5*((x-mu2p)/std2p).^2+log(std1p/std2p) == 0;
solP = double(solve(eqn1,x)); solP = sort(solP);
figure;
plot(w1p,zeros(length(w1p),1),'s','MarkerEdgeColor','blue'); hold on; grid on;
plot(w2p,zeros(length(w2p),1),'o','MarkerEdgeColor','red'); ylim([-.1 .1]);
plot(minP-1:.001:maxP+1,normpdf(minP-1:.001:maxP+1,mu1p,std1p),'b','LineWidth',1.5);
plot(minP-1:.001:maxP+1,normpdf(minP-1:.001:maxP+1,mu2p,std2p),'r','LineWidth',1.5);
H2 = @(x1,x2) x1-solP(1); H3 = @(x1,x2) x1-solP(2);
h2 = ezplot(H2); h3 = ezplot(H3);
h2.Color = 'k'; h2.LineWidth = 2; h3.Color = 'k'; h3.LineWidth = 2;
% xx = minP-.3:maxP+.3; yy = -1:.01:1;
% fill([solP(1)*ones(1,length(yy)) solP(2)*ones(1,length(yy))],[yy fliplr(yy)],'b')
legend('class w1','class w2','class-cond. dens. of class w1','class-cond. dens. of class w2', ...
    'bayes decision rule with minimum error 1', ...
    'bayes decision rule with minimum error 2','Location','northwest');
xlabel('x1'); ylabel('Class-Cond. Prob. Density');
% xlim auto; ylim auto
xlim([minP-1 maxP+1]); ylim([-.1 3]);
title('Bayes Decision Rule with Minimum Probability of Error for Projected Data');

