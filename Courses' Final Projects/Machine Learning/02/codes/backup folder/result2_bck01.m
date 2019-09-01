function [classifAccPropMeth,trainTimePropMeth] = result2(trDS,tsDS,K)

trSize = 5e4:5e4:55e4;
classifAccPropMeth = zeros(1,length(trSize));
trainTimePropMeth = zeros(1,length(trSize));
classifAccLIBSVM = zeros(1,length(trSize));
trainTimeLIBSVM = zeros(1,length(trSize));
for jj = 1:length(trSize)
    while true
        trDSreduc = svmRedun(trDS(1:trSize(jj),:),K);
        if ~isempty(trDSreduc); break; end
    end
    tic
    t = templateSVM('BoxConstraint',10,'KernelFunction','gaussian');
    svmModel = fitcecoc(trDSreduc(:,1:end-1),trDSreduc(:,end),'Learners',t);
    trainTimePropMeth(jj) = toc;
    svmPredTest = predict(svmModel,tsDS(:,1:end-1));
    classifAccPropMeth(jj) = (sum(svmPredTest==tsDS(:,end))/size(tsDS,1))*100;
    
    tic
    t = templateSVM('BoxConstraint',10,'KernelFunction','gaussian');
    svmModel = fitcecoc(trDS(1:trSize(jj),1:end-1),trDS(1:trSize(jj),end),'Learners',t);
    trainTimeLIBSVM(jj) = toc;
    svmPredTest = predict(svmModel,tsDS(:,1:end-1));
    classifAccLIBSVM(jj) = (sum(svmPredTest==tsDS(:,end))/size(tsDS,1))*100;
end

figure;
plot(1:length(trSize),classifAccPropMeth,'-*r','LineWidth',1.5, ...
    1:length(trSize),classifAccLIBSVM,'-+b','LineWidth',1.5); grid on;
xlabel('Number of training data of the coverType data set'); xlim([1 length(trSize)]);
ylabel('Classification accuracy'); ylim auto;
legend('Our Proposed Method','LIBSVM');

figure;
plot(1:length(trSize),trainTimePropMeth,'-*r','LineWidth',1.5, ...
    1:length(trSize),trainTimeLIBSVM,'-+b','LineWidth',1.5); grid on;
xlabel('Number of training data of the coverType data set'); xlim([1 length(trSize)]);
ylabel('Training time(seconds)'); ylim auto;
legend('Our Proposed Method','LIBSVM');

end

