function [distEst] = histEst(dist, nbins)

dim = size(dist,2);
switch dim
    case 1
        [N,~,bin] = histcounts(dist,nbins,'Normalization','pdf');
        distEst = N(bin);
        figure;
        histogram(dist,nbins,'Normalization','pdf'); hold on; grid on;
        title(['f(x) estimate by histogram density estimation with cellsNo = ',num2str(nbins)]);
    case 2
        [N,~,~,binX,binY] = histcounts2(dist(:,1),dist(:,2),nbins,'Normalization','pdf');
        distEst = N(binX,binY);
        figure;
        histogram2(dist(:,1),dist(:,2),nbins,'Normalization','pdf'); grid on;
        title(['f(x) estimate by histogram density estimation with cellsNo = ',num2str(nbins^2)]);
    otherwise
        fprintf('Dataset cannot be evaluated!\n');
end

