function [commArray] = commArrayMaker(commInds)

    commNo = max(commInds);
    commArray = cell(commNo,1);
    for c1 = 1:commNo
        commArray{c1} = find(commInds==c1);
    end

end