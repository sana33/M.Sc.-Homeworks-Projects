function [svDot] = svDotCalc(SVs)

SVcount = size(SVs,1);
svDot = zeros(SVcount);
for c1 = 1:SVcount
    for c2 = c1:SVcount
        svDot(c1,c2) = dot(SVs(c1,:),SVs(c2,:));
    end
end
svDot = svDot + triu(svDot,1)';

end