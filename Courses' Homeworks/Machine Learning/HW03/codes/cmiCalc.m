function [cmi] = cmiCalc(featNo1,featNo2,classNo,trainDS)
    cmi = 0;
    trainNo = size(trainDS,1);
    classLength = sum(trainDS(:,1)==classNo);
    tdsTmp = trainDS(:,[1 featNo1+1 featNo2+1]);
    for c1 = 1:3
        pXC = sum(tdsTmp(:,1)==classNo & tdsTmp(:,2)==c1) / classLength;
        for c2 = 1:3
            pYC = sum(tdsTmp(:,1)==classNo & tdsTmp(:,3)==c2) / classLength;
            pXYC = sum(tdsTmp(:,1)==classNo & tdsTmp(:,2)==c1 & tdsTmp(:,3)==c2) / trainNo;
            pXYgC = sum(tdsTmp(:,1)==classNo & tdsTmp(:,2)==c1 & tdsTmp(:,3)==c2) / classLength;
            tmp2 = pXYC * log2(pXYgC / (pXC * pYC));
            if isnan(tmp2); tmp2=0; end;
            cmi = cmi + tmp2;
        end
    end
