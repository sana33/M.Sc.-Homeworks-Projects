function [NMI] = NMI_calc(commArr1,commArr2,nodNo)

commSz1 = numel(commArr1);
commSz2 = numel(commArr2);
Nh = sparse(commSz1,1);
Nl = sparse(commSz2,1);
Nhl = sparse(commSz1,commSz2);

for c1 = 1:commSz1
    Nh(c1) = numel(commArr1{c1});
end
for c1 = 1:commSz2
    Nl(c1) = numel(commArr2{c1});
end

for c1 = 1:commSz1
    comm1 = commArr1{c1};
    for c2 = 1:commSz2
        comm2 = commArr2{c2};
        Nhl(c1,c2) = numel(intersect(comm1,comm2));
    end
end

H1 = Nh.*log2(Nh/nodNo);
H1 = sum(H1);
H2 = Nl.*log2(Nl/nodNo);
H2 = sum(H2);
MI = log2((nodNo*Nhl)./(Nh*transpose(Nl)));
MI(isinf(MI))=0; MI(isnan(MI))=0;
MI = sum(sum(Nhl.*MI));

NMI = full(-2*MI/(H1+H2));

end
