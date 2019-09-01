clear; close all; clc; warning off

w1 = [.1 6.8 -3.5 2 4.1 3.1 -.8 .9 5 3.9; 1.1 7.1 -4.1 2.7 2.8 5 -1.3 1.2 6.4 4];
w2 = [7.1 -1.4 4.5 6.3 4.2 1.4 2.4 2.5 8.4 4.1; 4.2 -4.3 0 1.6 1.9 -3.2 -4 -6.1 3.7 -2.2];
w3 = [-3 .5 2.9 -.1 -4 -1.3 -3.4 -4.1 -5.1 1.9; -2.9 8.7 2.1 5.2 2.2 3.7 6.2 3.4 1.6 5.1];
w4 = [-2 -8.9 -4.2 -8.5 -6.7 -.5 -5.3 -8.7 -7.1 -8; -8.4 .2 -7.7 -3.2 -4 -9.2 -6.7 -6.4 -9.7 -6.3];

% W = [w1 w2 w3 w4]; group = [ones(1,size(w1,2)) 2*ones(1,size(w1,2)) 3*ones(1,size(w1,2)) 4*ones(1,size(w1,2))];
% figure;
% gscatter(W(1,:),W(2,:),group,'brkg','so*+'); grid on;

%% Implementing computer exercise 02
% Part (b)
W = [ones(1,size(w3,2)) ones(1,size(w2,2)); w3 w2; ones(1,size(w3,2)) -ones(1,size(w2,2))];
WaugNorm = [ones(1,size(w3,2)) -ones(1,size(w2,2)); w3 -w2; ones(1,size(w3,2)) -ones(1,size(w2,2))];
figure;
group = [ones(1,size(w3,2)) 2*ones(1,size(w2,2))];
gscatter(W(2,:),W(3,:),group,'br','so'); grid on; hold on;
eta = .1;
a = zeros(size(WaugNorm,1)-1,1);
theta = .001;
k = 1;
while true
    colorMap = rand(size(WaugNorm,2),3);
    for c1 = 1:size(WaugNorm,2)
        if a'*WaugNorm(1:end-1,c1)<=0
            a = a + eta*WaugNorm(1:end-1,c1);
        end
        h1 = ezplot(@(x1,x2) a(1)+a(2).*x1+a(3).*x2,[min(W(2,:))-1,max(W(2,:))+1,min(W(3,:))-1,max(W(3,:))+1]);
        h1.Color = colorMap(c1,:); h1.LineStyle = '--'; h1.LineWidth = 1;
        pause(.1);
    end
    k = k+1;
    if all(a'*WaugNorm(1:end-1,:)>0); break; end
end
title('Scattered Data from classes w3 and w2 with Plotted Decision Boundaries');
fprintf('The number of iterations required for convergence for classes w3 and w2 is:\t%d\n',k);
figure;
gscatter(W(2,:),W(3,:),group,'br','so'); grid on; hold on;
h2 = ezplot(@(x1,x2) a(1)+a(2).*x1+a(3).*x2,[min(W(2,:))-1,max(W(2,:))+1,min(W(3,:))-1,max(W(3,:))+1]);
h2.Color = 'r'; h2.LineStyle = '-'; h2.LineWidth = 2;
title('Scattered Data from classes w3 and w2 with Plotted Decision Boundaries');
legend('w3','w2','Decision Boundary','location','southeast');

