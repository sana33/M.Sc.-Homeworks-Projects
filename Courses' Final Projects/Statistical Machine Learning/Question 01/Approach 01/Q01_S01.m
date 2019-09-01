
dataSetTrain = read_dataset('../Dataset/ml-100k/u3.base',0);
dataSetTest = read_dataset('../Dataset/ml-100k/u3.test',0);
dataSetTrain = dataSetTrain(1:3, :)';
dataSetTest = dataSetTest(1:3, :)';
dataSetTrain = sortrows(dataSetTrain, [1 2]);
dataSetTest = sortrows(dataSetTest, [1 2]);

userIdMax = input('Please enter the maxID for userID between 1 & 943:\n');
indexOnUserIdTrain = dataSetTrain(:,1)<=userIdMax;
dataSetTrain = dataSetTrain(indexOnUserIdTrain, :);
movieIdMax = max(dataSetTrain(:, 2));
indexOnUserIdTest = dataSetTest(:,1)<=userIdMax;
indexOnMovieIdTest = dataSetTest(indexOnUserIdTest,2)<=movieIdMax;
dataSetTest = dataSetTest(indexOnMovieIdTest, :);

moviesNoTrain = max(dataSetTrain(:, 2));
moviesPrior = zeros(moviesNoTrain, 5);
usersTrain = unique(dataSetTrain(:, 1));
usersTrainNo = length(usersTrain);
for c1 = 1:moviesNoTrain
    movieIndex = dataSetTrain(:, 2)==c1;
    moviesPrior(c1, :) = histcounts(dataSetTrain(movieIndex,3), 5);
end
moviesPrior = moviesPrior ./ usersTrainNo;

jointProb = zeros(moviesNoTrain, moviesNoTrain, 5);

for c2 = 1:length(usersTrain)
    usersKnownTrain = dataSetTrain(:,1)==usersTrain(c2);
    moviesKnownTrain = dataSetTrain(usersKnownTrain, 2);
    for c3 = 1:length(moviesKnownTrain)
        for c4 = c3+1:length(moviesKnownTrain)
            indexUser = dataSetTrain(:, 1)==usersTrain(c2);
            indexMovie1 = dataSetTrain(:, 2)==moviesKnownTrain(c3);
            indexMovie2 = dataSetTrain(:, 2)==moviesKnownTrain(c4);
            indexFinal1 = indexUser & indexMovie1;
            indexFinal2 = indexUser & indexMovie2;
            for c5 = 1:5
                if dataSetTrain(indexFinal1, 3)==c5 && dataSetTrain(indexFinal2, 3)==c5
                    jointProb(moviesKnownTrain(c3), moviesKnownTrain(c4), c5) = jointProb(moviesKnownTrain(c3), moviesKnownTrain(c4), c5) + 1;
                end
            end
        end
    end
end
for c6 = 1:5
    jointProb(:, :, c6) = jointProb(:, :, c6) + triu(jointProb(:, :, c6), 1)';
end
jointProb = jointProb ./ usersTrainNo;

usersTest = unique(dataSetTest(:, 1));
% usersTestIndex = min(usersTest);
% usersTestNo = length(unique(dataSetTest(:, 1)));
maeError = 0;
mseError = 0;

for k1 = 1:length(usersTest)
    usersRecomTest = dataSetTest(:,1)==usersTest(k1);
    moviesRecomTest = dataSetTest(usersRecomTest, 2);
    for k2 = 1:length(moviesRecomTest)
        temp1 = moviesPrior(moviesRecomTest(k2), :);
        index2knownTest = dataSetTrain(:,1)==usersTest(k1);
        moviesKnownInterest = dataSetTrain(index2knownTest, 2);
        for k3 = 1:length(moviesKnownInterest)
            temp1 = temp1 .* ((squeeze(jointProb(moviesKnownInterest(k3), moviesRecomTest(k2), :))' ./ ...
                (moviesPrior(moviesKnownInterest(k3), :) .* moviesPrior(moviesRecomTest(k2), :))) .^ (3 ./ length(moviesKnownInterest)));
            for k4 = 1:length(temp1); if isnan(temp1(k4)); temp1(k4) = 0; end; end
        end
        index1mae = dataSetTest(:, 1)==usersTest(k1);
        index2mae = dataSetTest(:, 2)==moviesRecomTest(k2);
        [M, I] = max(temp1');
        maeErrorChange = abs(dataSetTest(index1mae & index2mae, 3) - I);
        mseErrorChange = (dataSetTest(index1mae & index2mae, 3) - I).^2;
        if isempty(maeErrorChange); maeErrorChange = 0; end
        if isempty(mseErrorChange); mseErrorChange = 0; end
        maeError = maeError + maeErrorChange;
        mseError = mseError + mseErrorChange;
    end
end
maeError = maeError ./ length(dataSetTest);
mseError = mseError ./ length(dataSetTest);
rmseError = sqrt(mseError);
fprintf('\nThe final MAE error rate is:\n\t%7.4f\nThe final MSE error rate is:\n\t%7.4f\nThe final RMSE error rate is:\n\t%7.4f\n', ...
    maeError, mseError, rmseError);
