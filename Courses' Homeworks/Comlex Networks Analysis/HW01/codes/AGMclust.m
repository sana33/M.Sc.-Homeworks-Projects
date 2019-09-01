function [commArrayOL, commArrayOLnot, commMembStrMat] = AGMclust(adjMat, commNo)
    nodesNo = length(adjMat);
%     commMembStrMat = ones(nodesNo, commNo) ./ commNo;
    commMembStrMat = rand(nodesNo, commNo);
%     commMembStrMatForSave = rand(nodesNo, commNo);
    changeMeasure = 1;
    eta = .001;
    maxEpoch = 0;
    while changeMeasure > .0001
        changeMeasure = 0;
        for c1 = 1:nodesNo
            grad = 0;
            for c2 = 1:nodesNo
                if adjMat(c1,c2)~=0
                    tmp1 = -commMembStrMat(c1,:) * transpose(commMembStrMat(c2,:));
                    tmp2 = exp(tmp1) ./ (1 - exp(tmp1));
                    if isinf(tmp2) || isnan(tmp2); tmp2=0; end;
                    grad = grad + commMembStrMat(c2,:) .* tmp2;
                else
                    grad =  grad - commMembStrMat(c2,:);
                    grad(isnan(grad)) = 0;
                end
            end
            tmp3 = commMembStrMat(c1,:);
            commMembStrMat(c1,:) = commMembStrMat(c1,:) + eta .* grad;
            changeMeasure = norm(commMembStrMat(c1,:) - tmp3);
%             changeMeasure = changeMeasure + sum(grad .^ 2);
        end
%         changeMeasure = sqrt(changeMeasure);        
        changeMeasure
        commMembStrMat(commMembStrMat<0) = 0;
        commMembStrMat(isnan(commMembStrMat)) = 0;
        commMembStrMat(isinf(commMembStrMat)) = 0;
        maxEpoch = maxEpoch + 1;
        if maxEpoch>500; break; end;
    end
    % Computing communities with overlapping
    clustThresh = max(max(commMembStrMat))/4;
    commArrayOL = cell(1,commNo);
    for c1 = 1:commNo
        commArrayOL(c1) = {find(commMembStrMat(:,c1)>=clustThresh)};
    end
    commLessNodes = [];
    for c1 = 1:size(commMembStrMat,1)
        if commMembStrMat(c1,:)<=clustThresh; commLessNodes = [commLessNodes c1]; end;
    end
    commArrayOL(commNo) = {[cell2mat(commArrayOL(commNo)); commLessNodes']};
    % Computing communities without overlapping
    commArrayOLnot = cell(1,commNo);
    for c1 = 1:size(commMembStrMat,1)
        if commMembStrMat(c1,:)==0
            commArrayOLnot(commNo) = {[cell2mat(commArrayOLnot(commNo)); c1]};
        else
            [~,commSlctNo] = max(transpose(commMembStrMat(c1,:)));
            commArrayOLnot(commSlctNo) = {[cell2mat(commArrayOLnot(commSlctNo)); c1]};
        end
    end
end