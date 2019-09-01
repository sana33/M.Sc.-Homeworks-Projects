clear, close all, clc, warning off

%% Part a
f1 = @(x) 2.*x; f2 = @(x) 2-2.*x;
figure;
f1p = ezplot(f1,[0 1 0 2]); hold on; grid on;
f2p = ezplot(f2,[0 1 0 2]);
f1p.Color = 'Red'; f1p.LineWidth = 2; f2p.Color = 'Blue'; f2p.LineWidth = 2;
xlabel('x'); ylabel('p(x|wi)'); title('Two class distributions'); legend('w1','w2');

%% Part b
prior1 = .5; prior2 = .5;
f11 = @(x) prior1.*2.*x; f22 = @(x) prior2.*(2-2.*x); h1 = @(x,y) x-.5;
figure;
f11p = ezplot(f11,[0 1 0 2]); hold on; grid on;
f22p = ezplot(f22,[0 1 0 2]);
h1p = ezplot(h1,[0 1 0 2]);
f11p.Color = 'Red'; f11p.LineWidth = 2; f22p.Color = 'Blue'; f22p.LineWidth = 2; h1p.Color = 'Black'; h1p.LineWidth = 2;
xlabel('x'); ylabel('p(wi)p(x|wi)'); title('Two class unnormalized a posteriori prob.'); legend('p(w1)p(x|w1)','p(w2)p(x|w2)','Decision Rule');
X = 0:.001:1; Y1 = arrayfun(f11,X); Y2 = arrayfun(f22,X);
j1 = area(X(1:floor(length(X)/2)),Y1(1:floor(length(X)/2))); j1(1).FaceColor = [.3 .5 .7];
j2 = area(X(floor(length(X)/2):end),Y2(floor(length(X)/2):end)); j2(1).FaceColor = [.3 .5 .7]; 

%% Part c
eps1 = integral(f1,0,.5); eps2 = integral(f2,.5,1);
epsTot = prior1*eps1 + prior2*eps2;
fprintf('The bayes classification error is: %0.2f\n',epsTot);

%% Part d
prior1 = .4; prior2 = .6;
f111 = @(x) prior1.*2.*x; f222 = @(x) prior2.*(2-2.*x); h1 = @(x,y) x-.6;
figure;
f111p = ezplot(f111,[0 1 0 2]); hold on; grid on;
f222p = ezplot(f222,[0 1 0 2]);
h1p = ezplot(h1,[0 1 0 2]);
f111p.Color = 'Red'; f111p.LineWidth = 2; f222p.Color = 'Blue'; f222p.LineWidth = 2; h1p.Color = 'Black'; h1p.LineWidth = 2;
xlabel('x'); ylabel('p(wi)p(x|wi)'); title('Two class unnormalized a posteriori prob.'); legend('p(w1)p(x|w1)','p(w2)p(x|w2)','Decision Rule');
X = 0:.001:1; Y1 = arrayfun(f111,X); Y2 = arrayfun(f222,X);
j1 = area(X(1:floor(.6*length(X))),Y1(1:floor(.6*length(X)))); j1(1).FaceColor = [.3 .5 .7];
j2 = area(X(floor(.6*length(X)):end),Y2(floor(.6*length(X)):end)); j2(1).FaceColor = [.3 .5 .7]; 
eps1 = integral(f1,0,.6); eps2 = integral(f2,.6,1);
epsTot = prior1*eps1 + prior2*eps2;
fprintf('The bayes classification error is: %0.2f\n',epsTot);

