function [nmiValue] = NMIcompute(commArr1,commArr2,nodesNo)
    nh = zeros(length(commArr1),1);
    nl = zeros(length(commArr2),1);
    nhl = zeros(length(commArr1),length(commArr2));

    for c1 = 1:length(commArr1); nh(c1) = length(cell2mat(commArr1(c1))); end;
    for c1 = 1:length(commArr2); nl(c1) = length(cell2mat(commArr2(c1))); end;

    for c1 = 1:length(commArr1)
        g1 = cell2mat(commArr1(c1));
        for c2 = 1:length(commArr2)
            g2 = cell2mat(commArr2(c2));
            nhl(c1,c2) = intersectCal(g1,g2);
        end
    end
    
    nh2 = nh .* log2(nh./nodesNo);
    nl2 = nl .* log2(nl./nodesNo);
    tmp1 = log2((nodesNo.*nhl) ./ (nh*transpose(nl))); tmp1(isinf(tmp1))=0;
    nhl2 = nhl .* tmp1;
    nmiValue = sum(sum(nhl2)) ./ sqrt(sum(nh2).*sum(nl2));
end

function [intscSum] = intersectCal(g1,g2)
    intscSum = 0;
    for c1 = 1:length(g1); intscSum = intscSum + sum(g2==g1(c1)); end;
end