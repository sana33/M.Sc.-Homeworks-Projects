clear; close all; clc; warning off

%% Part b
% reading train data
fileID = fopen('./faces/train.txt');
C = textscan(fileID,'%s %u');
fclose(fileID);

Xtr = zeros(length(C{1,1}),numel(imread(C{1,1}{1,1})));
for c1 = 1:length(C{1,1})
    imTr = imread(C{1,1}{c1,1});
    Xtr(c1,:) = imTr(:)';
end
XtrLab = double(C{1,2});
figure; imshow(uint8(reshape(Xtr(randi(size(Xtr,1)),:),50,[])));
title('Randomly selected train image');

% reading test data
fileID = fopen('./faces/test.txt');
C = textscan(fileID,'%s %u');
fclose(fileID);

Xts = zeros(length(C{1,1}),numel(imread(C{1,1}{1,1})));
for c1 = 1:length(C{1,1})
    imTs = imread(C{1,1}{c1,1});
    Xts(c1,:) = imTs(:)';
end
XtsLab = double(C{1,2});
figure; imshow(uint8(reshape(Xts(randi(size(Xts,1)),:),50,[])));
title('Randomly selected test image');

%% Part c
XtrMu = mean(Xtr);
figure; imshow(uint8(reshape(XtrMu,50,[])));
title('Train Average Face');

XtsMu = mean(Xts);
figure; imshow(uint8(reshape(XtsMu,50,[])));
title('Test Average Face');

%% Part d
Ytr = Xtr - repmat(XtrMu,size(Xtr,1),1);
figure; imshow(uint8(reshape(Ytr(randi(size(Ytr,1)),:),50,[])));
title('Train randomly selected mean-subtracted image');

Yts = Xts - repmat(XtsMu,size(Xts,1),1);
figure; imshow(uint8(reshape(Yts(randi(size(Yts,1)),:),50,[])));
title('Test randomly selected mean-subtracted image');

%% Part e
[U,S,V] = svd(Xtr,'econ');
figure;
for c1 = 1:10
    eigface = reshape(V(:,c1),50,[]);
    c = double(min(eigface(:))); d = double(max(eigface(:)));
    b = 255; a = 0;
    eigfaceStrch = (double(eigface) - c) * (b - a) / (d - c) + a;
    eigfaceStrch = cast(eigfaceStrch,'uint8');
    subplot(2,5,c1);
    imshow(eigfaceStrch); title(sprintf('Eigenface No. %d',c1));
end

%% Part f
rankRappErr = zeros(1,200);
for r = 1:200
    Xrhat = U(:,1:r)*S(1:r,1:r)*V(:,1:r)';
    rankRappErr(r) = sum(sqrt(sum((Xtr-Xrhat).^2,2)));
end
figure; plot(rankRappErr,'-r'); grid on;
xlabel('Rank Value'); ylabel('Rank Approximation Error'); title('Low-Rank Approximation');

%% Part h
r = 10;
Ftr = eigFaceFeat(Xtr,r);
Fts = eigFaceFeat(Xts,r);

B = mnrfit(Ftr,XtrLab);
pihat = mnrval(B,Fts);

[~,predInd] = max(pihat,[],2);
incorrClsTS = sum(XtsLab~=predInd);
corrClsTS = sum(XtsLab==predInd);
fprintf('Classification accuracy on the test set with low-rank=%d is:\n\t# of incorrectly classified items:\t%d\n\t# of correctly classified items:\t%d\n',r,incorrClsTS,corrClsTS);

tic
incorrClsPerc = zeros(1,200);
for r = 1:200
    Ftr = eigFaceFeat(Xtr,r);
    Fts = eigFaceFeat(Xts,r);

    B = mnrfit(Ftr,XtrLab);
    pihat = mnrval(B,Fts);

    [~,predInd] = max(pihat,[],2);
    incorrClsPerc(r) = sum(XtsLab~=predInd)/length(XtsLab);
end
figure; plot(incorrClsPerc,'-r'); grid on;
xlabel('# of extracted features'); ylabel('Incorrectly classified percentage of test items'); title('Face Recognition Accuracy For Test Dataset');
toc

