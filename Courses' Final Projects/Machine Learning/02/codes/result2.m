function [classifAccPropMeth,trainTimePropMeth] = result2(trDS,tsDS,K,trSizeIntv)

% trSizeIntv = 500:5000:9e4;
classifAccPropMeth = zeros(1,length(trSizeIntv));
trainTimePropMeth = zeros(1,length(trSizeIntv));
classifAccLIBSVM = zeros(1,length(trSizeIntv));
trainTimeLIBSVM = zeros(1,length(trSizeIntv));
for jj = 1:length(trSizeIntv)
    while true
        trDSreduc = svmRedun(trDS(1:trSizeIntv(jj),:),K);
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
    svmModel = fitcecoc(trDS(1:trSizeIntv(jj),1:end-1),trDS(1:trSizeIntv(jj),end),'Learners',t);
    trainTimeLIBSVM(jj) = toc;
    svmPredTest = predict(svmModel,tsDS(:,1:end-1));
    classifAccLIBSVM(jj) = (sum(svmPredTest==tsDS(:,end))/size(tsDS,1))*100;
end

figure;
plot(1:length(trSizeIntv),classifAccPropMeth,'-*r','LineWidth',1.5, ...
    1:length(trSizeIntv),classifAccLIBSVM,'-+b','LineWidth',1.5); grid on;
xlabel('Number of training data of the coverType data set'); xlim([1 length(trSizeIntv)]);
ylabel('Classification accuracy'); ylim auto;
legend('Our Proposed Method','LIBSVM');

figure;
plot(1:length(trSizeIntv),trainTimePropMeth,'-*r','LineWidth',1.5, ...
    1:length(trSizeIntv),trainTimeLIBSVM,'-+b','LineWidth',1.5); grid on;
xlabel('Number of training data of the coverType data set'); xlim([1 length(trSizeIntv)]);
ylabel('Training time(seconds)'); ylim auto;
legend('Our Proposed Method','LIBSVM');

end

