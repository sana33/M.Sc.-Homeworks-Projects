function [bestSubset,Jopt] = J_Optimal(Z,o)

X = Z{1,1}(:,1:end-1);
featFreq = Z{1,2};
if all(o~=1:10); o=10; end
n = size(X,1);
m = size(X,2);
switch o
    case 1
        Jopt = inf;
        for j1 = 1:n
            candidSet = j1;
            ol = X(candidSet,:);
            featFreq_new = featFreq;
            for k1 = 1:m
                for k2 = ol(:,k1)'
                    featIdx = featFreq{1,k1}(:,1)==k2;
                    featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                end
            end
            [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
            if WHL < Jopt
                Jopt = WHL;
                bestSubset = candidSet;
            end
        end
    case 2
        Jopt = inf;
        for j1 = 1:n-1
            for j2 = j1+1:n
                candidSet = [j1 j2];
                ol = X(candidSet,:);
                featFreq_new = featFreq;
                for k1 = 1:m
                    for k2 = ol(:,k1)'
                        featIdx = featFreq{1,k1}(:,1)==k2;
                        featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                    end
                end
                [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                if WHL < Jopt
                    Jopt = WHL;
                    bestSubset = candidSet;
                end
            end
        end
    case 3
        Jopt = inf;
        for j1 = 1:n-2
            for j2 = j1+1:n-1
                for j3 = j2+1:n
                    candidSet = [j1 j2 j3];
                    ol = X(candidSet,:);
                    featFreq_new = featFreq;
                    for k1 = 1:m
                        for k2 = ol(:,k1)'
                            featIdx = featFreq{1,k1}(:,1)==k2;
                            featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                        end
                    end
                    [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                    if WHL < Jopt
                        Jopt = WHL;
                        bestSubset = candidSet;
                    end
                end
            end
        end
    case 4
        Jopt = inf;
        for j1 = 1:n-3
            for j2 = j1+1:n-2
                for j3 = j2+1:n-1
                    for j4 = j3+1:n
                        candidSet = [j1 j2 j3 j4];
                        ol = X(candidSet,:);
                        featFreq_new = featFreq;
                        for k1 = 1:m
                            for k2 = ol(:,k1)'
                                featIdx = featFreq{1,k1}(:,1)==k2;
                                featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                            end
                        end
                        [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                        if WHL < Jopt
                            Jopt = WHL;
                            bestSubset = candidSet;
                        end
                    end
                end
            end
        end
    case 5
        Jopt = inf;
        for j1 = 1:n-4
            for j2 = j1+1:n-3
                for j3 = j2+1:n-2
                    for j4 = j3+1:n-1
                        for j5 = j4+1:n
                            candidSet = [j1 j2 j3 j4 j5];
                            ol = X(candidSet,:);
                            featFreq_new = featFreq;
                            for k1 = 1:m
                                for k2 = ol(:,k1)'
                                    featIdx = featFreq{1,k1}(:,1)==k2;
                                    featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                                end
                            end
                            [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                            if WHL < Jopt
                                Jopt = WHL;
                                bestSubset = candidSet;
                            end
                        end
                    end
                end
            end
        end
    case 6
        Jopt = inf;
        for j1 = 1:n-5
            for j2 = j1+1:n-4
                for j3 = j2+1:n-3
                    for j4 = j3+1:n-2
                        for j5 = j4+1:n-1
                            for j6 = j5+1:n
                                candidSet = [j1 j2 j3 j4 j5 j6];
                                ol = X(candidSet,:);
                                featFreq_new = featFreq;
                                for k1 = 1:m
                                    for k2 = ol(:,k1)'
                                        featIdx = featFreq{1,k1}(:,1)==k2;
                                        featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                                    end
                                end
                                [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                                if WHL < Jopt
                                    Jopt = WHL;
                                    bestSubset = candidSet;
                                end
                            end
                        end
                    end
                end
            end
        end
    case 7
        Jopt = inf;
        for j1 = 1:n-6
            for j2 = j1+1:n-5
                for j3 = j2+1:n-4
                    for j4 = j3+1:n-3
                        for j5 = j4+1:n-2
                            for j6 = j5+1:n-1
                                for j7 = j6+1:n
                                    candidSet = [j1 j2 j3 j4 j5 j6 j7];
                                    ol = X(candidSet,:);
                                    featFreq_new = featFreq;
                                    for k1 = 1:m
                                        for k2 = ol(:,k1)'
                                            featIdx = featFreq{1,k1}(:,1)==k2;
                                            featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                                        end
                                    end
                                    [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                                    if WHL < Jopt
                                        Jopt = WHL;
                                        bestSubset = candidSet;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    case 8
        Jopt = inf;
        for j1 = 1:n-7
            for j2 = j1+1:n-6
                for j3 = j2+1:n-5
                    for j4 = j3+1:n-4
                        for j5 = j4+1:n-3
                            for j6 = j5+1:n-2
                                for j7 = j6+1:n-1
                                    for j8 = j7+1:n
                                        candidSet = [j1 j2 j3 j4 j5 j6 j7 j8];
                                        ol = X(candidSet,:);
                                        featFreq_new = featFreq;
                                        for k1 = 1:m
                                            for k2 = ol(:,k1)'
                                                featIdx = featFreq{1,k1}(:,1)==k2;
                                                featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                                            end
                                        end
                                        [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                                        if WHL < Jopt
                                            Jopt = WHL;
                                            bestSubset = candidSet;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    case 9
        Jopt = inf;
        for j1 = 1:n-8
            for j2 = j1+1:n-7
                for j3 = j2+1:n-6
                    for j4 = j3+1:n-5
                        for j5 = j4+1:n-4
                            for j6 = j5+1:n-3
                                for j7 = j6+1:n-2
                                    for j8 = j7+1:n-1
                                        for j9 = j8+1:n
                                            candidSet = [j1 j2 j3 j4 j5 j6 j7 j8 j9];
                                            ol = X(candidSet,:);
                                            featFreq_new = featFreq;
                                            for k1 = 1:m
                                                for k2 = ol(:,k1)'
                                                    featIdx = featFreq{1,k1}(:,1)==k2;
                                                    featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                                                end
                                            end
                                            [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                                            if WHL < Jopt
                                                Jopt = WHL;
                                                bestSubset = candidSet;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    case 10
        Jopt = inf;
        for j1 = 1:n-9
            for j2 = j1+1:n-8
                for j3 = j2+1:n-7
                    for j4 = j3+1:n-6
                        for j5 = j4+1:n-5
                            for j6 = j5+1:n-4
                                for j7 = j6+1:n-3
                                    for j8 = j7+1:n-2
                                        for j9 = j8+1:n-1
                                            for j10 = j9+1:n
                                                candidSet = [j1 j2 j3 j4 j5 j6 j7 j8 j9 j10];
                                                ol = X(candidSet,:);
                                                featFreq_new = featFreq;
                                                for k1 = 1:m
                                                    for k2 = ol(:,k1)'
                                                        featIdx = featFreq{1,k1}(:,1)==k2;
                                                        featFreq_new{1,k1}(featIdx,2) = featFreq_new{1,k1}(featIdx,2)-1;
                                                    end
                                                end
                                                [~,~,~,WHL] = WHL_Calc(featFreq_new,1);
                                                if WHL < Jopt
                                                    Jopt = WHL;
                                                    bestSubset = candidSet;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
end

end