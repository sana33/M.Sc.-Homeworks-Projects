
figure;
h1=ezplot(@(x,y)y-2.*(1-(1+exp(-x)).^-1),[0,10,0,1]); grid on;
h1.LineWidth=2; h1.Color='r'; title('\fontsize{25} Reverse Sigmoid Function: f(x)=2(1-1/(1+exp(-H_{X}(y_{i}))))');
xlabel('\fontsize{15} \bf H_{X}(y_{i})'); ylabel('\fontsize{15} \bf w_{X}(y_{i})');

figure;
h1=ezplot(@(x,y)y-(x-1).*log2(x-1)+x.*log2(x),[1,10,-6,0]); grid on;
h1.LineWidth=2; h1.Color='r'; title('\fontsize{25} Delta Function: \delta(x)=(x-1)log2(x-1)-xlog2(x)');
xlabel('\fontsize{15} \bf n(x_{o,i})'); ylabel('\fontsize{15} \bf \delta[n(x_{o,i})]');

