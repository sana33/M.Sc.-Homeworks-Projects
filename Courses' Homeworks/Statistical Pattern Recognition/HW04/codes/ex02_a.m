clear, close all, clc, warning off

X = [.01 .12 .19 .32 .41 .48];
D = 1; h1 = .1; V1 = h1^D; h2 = .01; V2 = h2^D;
coef1 = (length(X)*V1)^-1; coef2 = (length(X)*V2)^-1;
stepLngth = 1e-7;
hh1 = h1/(2*stepLngth); hh2 = h2/(2*stepLngth);
x = -.1:stepLngth:.6;
y1 = zeros(length(X),length(x));
y2 = zeros(length(X),length(x));

for c1 = 1:length(X)
    pos = find(x==X(c1));
    y1(c1,pos-hh1:pos+hh1-1) = y1(c1,pos-hh1:pos+hh1-1) + coef1*normpdf(x(pos-hh1:pos+hh1-1),x(pos));
end

for c1 = 1:length(X)
    pos = find(x==X(c1));
    y2(c1,pos-hh2:pos+hh2-1) = y2(c1,pos-hh2:pos+hh2-1) + coef2*normpdf(x(pos-hh2:pos+hh2-1),x(pos));
end

y1f = sum(y1); y2f = sum(y2);

figure;
subplot(2,1,1); plot(x,y1f,'b','LineWidth',1.3); grid on;
xlim auto; ylim auto; xlabel('x'); ylabel('pHat(x)'); title('Parzen Window Estimate of f(x) with h=.1');
subplot(2,1,2); plot(x,y2f,'r','LineWidth',1.3); grid on;
xlim auto; ylim auto; xlabel('x'); ylabel('pHat(x)'); title('Parzen Window Estimate of f(x) with h=.01');

