% clc;
% close all;
warning off

% loading simulated data sets
load('..\datasets\Simulated data set\trDS.mat','trDS');
load('..\datasets\Simulated data set\tsDS.mat','tsDS');


Kval = 2:5:120;
classifAccPropMeth = zeros(1,length(Kval));
trainTimePropMeth = zeros(1,length(Kval));
classifAccClustSVM = zeros(1,length(Kval));
trainTimeClustSVM = zeros(1,length(Kval));
for jj = 1:length(Kval)
    while true
        trDSreduc = svmRedun(trDS,Kval(jj));
        if ~isempty(trDSreduc); break; end
    end
    jj
    tic
    t = templateSVM('BoxConstraint',10,'KernelFunction','gaussian');
    svmModel = fitcecoc(trDSreduc(:,1:end-1),trDSreduc(:,end),'Learners',t);
    trainTimePropMeth(jj) = toc;
    svmPredTest = predict(svmModel,tsDS(:,1:end-1));
    classifAccPropMeth(jj) = (sum(svmPredTest==tsDS(:,end))/size(tsDS,1))*100;
    
    data.X = tsDS(:,1:end-1)';
    data.y = tsDS(:,end)';
    options = struct('method','CG','ker','rbf','arg',1,'C',10,'k',Kval(jj));
    tic
    svcModel = svc(data,options);
    trainTimeClustSVM(jj) = toc;
    svcPredTest = svcModel.cluster_labels';
    classifAccClustSVM(jj) = (sum(svcPredTest==tsDS(:,end))/size(tsDS,1))*100;
end

figure;
plot(Kval,classifAccPropMeth,'-*r','LineWidth',1.5); grid on;
xlabel('Number of initial clusters K in the simulated data set'); xlim([0 120]);
ylabel('Classification accuracy'); ylim([60 100]);
legend('Our Proposed Method');

figure;
plot(Kval,trainTimePropMeth,'-*r','LineWidth',1.5); grid on;
xlabel('Number of initial clusters K in the simulated data set'); xlim([0 120]);
ylabel('Training time(seconds)'); ylim auto;
legend('Our Proposed Method');


