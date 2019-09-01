function [] = MaxMinClustDis(UC,UMC,lables)

ii = 1;
M = length(labels);
while ii<=M
    for c1 = 1:length(UMC)
        for c2 = 1:length(UMC{c1,1})
            if unique(UMC{c1,1}{1,c2}(:,end))==labels(ii)
                for c3 = 1:length(UMC{c1,1})
                    if c3~=c2
                        dsTemp = [UMC{c1,1}{1,c2}; UMC{c1,1}{1,c3}];
                        svmMdl = fitcsvm(dsTemp(:,1:end-1),dsTemp(:,end),'BoxConstraint',10,'KernelFunction','rbf');
                        
                    end
                end
            end
        end
    end
end


end

