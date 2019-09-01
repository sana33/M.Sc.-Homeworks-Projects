function [ssArray] = snapShot_create(tempNet, ssNo, evolvSpeed, msConvType)
% 

    msConvType = lower(msConvType);
    switch msConvType
        case 'minute'
            tempNet(:,4) = tempNet(:,4) ./ 6e4;
        case 'hour'
            tempNet(:,4) = tempNet(:,4) ./ 36e5;
        case 'day'
            tempNet(:,4) = tempNet(:,4) ./ 864e5;
    end
    ssArray = cell(ssNo,1);
    tempNet = sortrows(tempNet,4);
    for c1 = 1:ssNo
        ssArray{c1} = tempNet(tempNet(:,4) >= (min(tempNet(:,4))+(c1-1)*evolvSpeed) & ...
            tempNet(:,4) <= (max(tempNet(:,4))-(ssNo-c1)*evolvSpeed),:);
    end

end

