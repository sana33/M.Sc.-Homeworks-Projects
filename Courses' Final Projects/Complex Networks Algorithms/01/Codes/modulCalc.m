function modul = modulCalc(A, metricType, commArray)
% A: a full or sparse matrix

metricType = lower(metricType);
switch metricType
    case 'symmetric'
        degVec = sum(A);
    case 'asymmetric'
        degVec = sum(A+A');
end
degSum = full(sum(degVec));

modul = 0;
for c1 = 1:length(commArray)
    comm = commArray{c1};
    commSz = length(comm);
    B = A(comm,comm);
    degMult = repmat(degVec(comm),commSz,1) .* repmat(degVec(comm)',1,commSz);
    modul = modul + sum(sum(B - degMult./degSum));
end
modul = modul / degSum;

end
