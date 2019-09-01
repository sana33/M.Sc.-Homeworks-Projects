clear, close all, clc, warning off

X = [.01 .12 .19 .32 .41 .48]; samplesNo = length(X);
K = 3;
stepLngth = 1e-4;
x = -.3:stepLngth:.8;
yy = zeros(1,length(x));

for c1 = 1:length(x)
    dist = pdist2(x(c1),X');
    [sDist, sDistInd] = sort(dist,2);
    if any(x(c1)==X)
        kNghbDist = sDist(K+1); kNghbInd = sDistInd(K+1);
    else
        kNghbDist = sDist(K); kNghbInd = sDistInd(K);
    end
    if x(c1)<X(kNghbInd), R = X(kNghbInd)-x(c1); else, R = x(c1)-X(kNghbInd); end
    yy(c1) = K/(samplesNo*2*R);
end

figure;
plot(x,yy,'r','LineWidth',1.2); grid on;
xlim auto; ylim auto; xlabel('x'); ylabel('pHat(x)'); title('K-NN Estimate of f(x) with k=3');
