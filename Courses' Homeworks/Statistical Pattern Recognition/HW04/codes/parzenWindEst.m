function [distEst] = parzenWindEst(dist, h, stepLength, kernelType)

samplesNo = size(dist,1);
dim = size(dist,2);
V = h^dim;
coef = (samplesNo*V)^-1;
hh = h/(2*stepLength); hh = ceil(hh);

switch dim
    case 1
        x = min(dist)-hh-1:stepLength:max(dist)+hh+1;
        distEst = sparse(1,length(x));
        for c1 = 1:samplesNo
            pos = find(abs(x-dist(c1))<.01);
            if length(pos)>1; pos=pos(1); end
            switch kernelType
                case 'rectangular'
                    distEst(1,pos-hh:pos+hh-1) = distEst(1,pos-hh:pos+hh-1) + ...
                        coef*1; % x*1 just for realizing the main formula
                case 'gaussian'
                    distEst(1,pos-hh:pos+hh-1) = distEst(1,pos-hh:pos+hh-1) + ...
                        coef*normpdf(x(pos-hh:pos+hh-1),x(pos));                    
            end
        end
        figure; plot(x,distEst,'b','LineWidth',1.3); grid on; xlim auto;
        title(['Parzen Window Estimate of f(x) with h = ',num2str(h),' & kernelType = ',kernelType]);
    case 2
        x1 = min(dist(:,1))-2*hh:stepLength:max(dist(:,1))+2*hh;
        x2 = min(dist(:,2))-2*hh:stepLength:max(dist(:,2))+2*hh;
        [X1,X2] = meshgrid(x1,x2); X = [X1(:) X2(:)];
        distEst = sparse(length(x2),length(x1));
        for c1 = 1:samplesNo
            pos = find(sum((X-dist(c1,:)).^2,2)<.01);
            if length(pos)>1; pos=pos(1); end
            [I,J] = ind2sub([length(x2) length(x1)],pos);
            switch kernelType
                case 'rectangular'
                    distEst(I-hh:I+hh-1,J-hh:J+hh-1) = distEst(I-hh:I+hh-1,J-hh:J+hh-1) + ...
                        coef*1; % x*1 just for realizing the main formula
                case 'gaussian'
                    neighbX1 = X1(I-hh:I+hh-1,J-hh:J+hh-1);
                    neighbX2 = X2(I-hh:I+hh-1,J-hh:J+hh-1);
                    neighbX = [neighbX1(:) neighbX2(:)];
                    gaussValues = mvnpdf(neighbX,X(pos,:));
                    gaussValues = reshape(gaussValues,2*hh,[]);
                    if numel(gaussValues)~=0
                        distEst(I-hh:I+hh-1,J-hh:J+hh-1) = distEst(I-hh:I+hh-1,J-hh:J+hh-1) + coef*gaussValues;
                    end
            end
        end
        figure; surf(x1,x2,distEst);
        title(['Parzen Window Estimate of f(x) with h = ',num2str(h),' & kernelType = ',kernelType]);
    otherwise
        fprintf('Dataset cannot be evaluated!\n');
end

end

