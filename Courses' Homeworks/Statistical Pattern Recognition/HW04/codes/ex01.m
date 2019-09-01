clear, close all, clc, warning off

w1 = [1 4 5]; w2 = [2 3];
D = 1; h1 = 1; V1 = h1^D; h2 = 1; V2 = h2^D;
coef1 = (length(w1)*V1)^-1; coef2 = (length(w2)*V2)^-1;
stepLngth = 1e-6;
hh1 = h1/(2*stepLngth); hh2 = h2/(2*stepLngth);
x = 0:stepLngth:6;
y1 = zeros(length(w1),length(x));
y2 = zeros(length(w2),length(x));

for c1 = 1:length(w1)
    pos = find(x==w1(c1));
    y1(c1,pos-hh1:pos+hh1-1) = y1(c1,pos-hh1:pos+hh1-1) + coef1*1; % x*1 just for realizing the main formula
end

for c1 = 1:length(w2)
    pos = find(x==w2(c1));
    y2(c1,pos-hh2:pos+hh2-1) = y2(c1,pos-hh2:pos+hh2-1) + coef2*1; % x*1 just for realizing the main formula
end

y1f = sum(y1); y2f = sum(y2);

figure;
subplot(2,1,1); plot(x,y1f,'b','LineWidth',1.3); grid on; xlim auto; ylim auto;
title('pHat(x|w1) by histogram density estimation with h=1');
subplot(2,1,2); plot(x,y2f,'r','LineWidth',1.3); grid on; xlim auto; ylim auto;
title('pHat(x|w2) by histogram density estimation with h=1');

