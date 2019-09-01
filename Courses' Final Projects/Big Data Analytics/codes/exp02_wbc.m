clear; clc; warning off

%% Considering effectiveness test - test on real dataset wbc
load('wbc.mat');
% Performing experiments
% Considering unweighted ITB_SP
[OS,OSidx,Jopt,OF,UO] = ITB_SP(wbc,size(wbc{1,1},1),0);
[X,Y,~,AUC] = perfcurve(wbc{1,1}(:,end),OF,4);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('WBC Dataset ROC with unweighted ITB-SP with AUC = %0.3f',AUC));

wbc_ITBSPu = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering weighted ITB_SP
[OS,OSidx,Jopt,OF,UO] = ITB_SP(wbc,size(wbc{1,1},1),1);
[X,Y,~,AUC] = perfcurve(wbc{1,1}(:,end),OF,4);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('WBC Dataset ROC with weighted ITB-SP with AUC = %0.3f',AUC));

wbc_ITBSPw = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering unweighted ITB_SS
[OS,OSidx,Jopt,OF,UO] = ITB_SS(wbc,size(wbc{1,1},1),0);
[X,Y,~,AUC] = perfcurve(wbc{1,1}(:,end),OF,4);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('WBC Dataset ROC with unweighted ITB-SS with AUC = %0.3f',AUC));

wbc_ITBSSu = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering weighted ITB_SS
[OS,OSidx,Jopt,OF,UO] = ITB_SS(wbc,size(wbc{1,1},1),1);
[X,Y,~,AUC] = perfcurve(wbc{1,1}(:,end),OF,4);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('WBC Dataset ROC with weighted ITB-SS with AUC = %0.3f',AUC));

wbc_ITBSSw = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

save('exp02_wbc_res.mat','wbc_ITBSPu','wbc_ITBSPw','wbc_ITBSSu','wbc_ITBSSw');

