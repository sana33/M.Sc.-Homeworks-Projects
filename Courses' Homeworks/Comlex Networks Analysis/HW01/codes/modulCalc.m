function modul = modulCalc(adjMat, commArray)
degVec = sum(adjMat);
degSum = sum(degVec);
modul = 0;
for c1 = 1:length(commArray)
    community = cell2mat(commArray(c1));
    for c2 = 1:length(community)
        for c3 = 1:length(community)
            modul = modul + (adjMat(community(c2),community(c3)) - ...
                degVec(community(c2))*degVec(community(c3))/degSum);
        end
    end
end
modul = modul / degSum;
