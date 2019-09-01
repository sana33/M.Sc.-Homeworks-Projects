function [distEst] = KNN_Est(dist, kVal, stepLength)

samplesNo = size(dist,1);
dim = size(dist,2);

switch dim
    case 1
        distStd = std(dist);
        x = min(dist)-distStd:stepLength:max(dist)+distStd;
        distEst = sparse(1,length(x));
        for c1 = 1:length(x)
            distance = pdist2(x(c1),dist);
            [~, sDistInd] = sort(distance,2);
            kNghbInd = sDistInd(kVal);
            if x(c1)<dist(kNghbInd), R = dist(kNghbInd)-x(c1); else, R = x(c1)-dist(kNghbInd); end
            distEst(c1) = kVal/(samplesNo*2*R);
        end
        figure;
        plot(x,distEst,'r','LineWidth',1.2); grid on;
        xlim auto; ylim auto; xlabel('x'); ylabel('pHat(x)');
        title(['K-NN Estimate of f(x) with k = ',num2str(kVal)]);
    case 2
        distStd1 = std(dist(:,1)); distStd2 = std(dist(:,2));
        x1 = min(dist(:,1))-distStd1:stepLength:max(dist(:,1))+distStd1;
        x2 = min(dist(:,2))-distStd2:stepLength:max(dist(:,2))+distStd2;
        [X1,X2] = meshgrid(x1,x2); X = [X1(:) X2(:)];
        distEst = sparse(length(x2),length(x1));
        for c1 = 1:length(X)
            distance = pdist2(X(c1,:),dist);
            [sDist, ~] = sort(distance,2);
            R = sDist(kVal);
            distEst(c1) = kVal/(samplesNo*pi*(R^2));
        end
        figure; surf(x1,x2,distEst);
        title(['K-NN Estimate of f(x) with k = ',num2str(kVal)]);
    otherwise
        fprintf('Dataset cannot be evaluated!\n');
end

end

