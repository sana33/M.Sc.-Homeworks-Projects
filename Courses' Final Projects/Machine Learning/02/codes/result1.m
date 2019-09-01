function [classifAccPropMeth,trainTimePropMeth] = result1(trDS,tsDS,Kval,xLim,dsName)

classifAccPropMeth = zeros(1,length(Kval));
trainTimePropMeth = zeros(1,length(Kval));
for jj = 1:length(Kval)
    while true
        trDSreduc = svmRedun(trDS,Kval(jj));
        if ~isempty(trDSreduc); break; end
    end
    tic
    t = templateSVM('BoxConstraint',10,'KernelFunction','gaussian');
    svmModel = fitcecoc(trDSreduc(:,1:end-1),trDSreduc(:,end),'Learners',t);
    trainTimePropMeth(jj) = toc;
    svmPredTest = predict(svmModel,tsDS(:,1:end-1));
    classifAccPropMeth(jj) = (sum(svmPredTest==tsDS(:,end))/size(tsDS,1))*100;
end

figure;
plot(Kval,classifAccPropMeth,'-*r','LineWidth',1.5); grid on;
xlabel(['Number of initial clusters K in the ',dsName]); xlim(xLim);
ylabel('Classification accuracy'); ylim([0 100]);
legend('Our Proposed Method');

figure;
plot(Kval,trainTimePropMeth,'-*r','LineWidth',1.5); grid on;
xlabel(['Number of initial clusters K in the ',dsName]); xlim(xLim);
ylabel('Training time(seconds)'); ylim auto;
legend('Our Proposed Method');

end

