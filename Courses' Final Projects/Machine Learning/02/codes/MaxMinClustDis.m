function [RS1] = MaxMinClustDis(UC,UMC,labels,gamma,hypPlnInf)

RS1 = UMC;
ii = 1;
M = length(labels);
while ii<=M
    UMCmaxDist = [];
    for c1 = 1:length(UMC)
        if unique(UMC{c1,1}(:,end))==labels(ii)
            DDk = zeros(size(UMC{c1,1},1),1);
            for c2 = 1:size(UMC{c1,1},1)
                distTemp = inf;
                for c3 = 1:M
                    if isempty(hypPlnInf{ii,c3}); continue; end
                    hpInf = hypPlnInf{ii,c3};
                    y = sum(hpInf{1,1} .* hpInf{2,1} .* exp(-gamma.*sum((repmat(UMC{c1,1}(c2,1:end-1), ...
                        size(hpInf{3,1},1),1)-hpInf{3,1}).^2,2))) + hpInf{4,1};
                    if abs(y)/hpInf{5,1}<distTemp; distTemp=abs(y)/hpInf{5,1}; end
                end
                DDk(c2,1) = distTemp;
            end
            UMCmaxDist = [UMCmaxDist; max(DDk)];
        end
    end
    CMax = max(UMCmaxDist);
    
    for c1 = 1:length(UC)
        if unique(UC{c1,1}(:,end))==labels(ii)
            UDk = zeros(size(UC{c1,1},1),1);
            for c2 = 1:size(UC{c1,1},1)
                distTemp = inf;
                for c3 = 1:M
                    if isempty(hypPlnInf{ii,c3}); continue; end
                    hpInf = hypPlnInf{ii,c3};
                    y = sum(hpInf{1,1} .* hpInf{2,1} .* exp(-gamma.*sum((repmat(UC{c1,1}(c2,1:end-1), ...
                        size(hpInf{3,1},1),1)-hpInf{3,1}).^2,2))) + hpInf{4,1};
                    if abs(y)/hpInf{5,1}<distTemp; distTemp=abs(y)/hpInf{5,1}; end
                end
                UDk(c2,1) = distTemp;
            end
            CMin = min(UDk);
            if CMin<=CMax
                RS1 = cellCat(RS1,UC{c1,1},'ver');
            end
        end
    end
    ii = ii+1;
end

end

