clear; clc; warning off

%% Considering effectiveness test - test on real dataset autos
load('autos.mat');
% Performing experiments
% Considering unweighted ITB_SP
[OS,OSidx,Jopt,OF,UO] = ITB_SP(autos,size(autos{1,1},1),0);
[X,Y,~,AUC] = perfcurve(autos{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Autos Dataset ROC with unweighted ITB-SP with AUC = %0.3f',AUC));

autos_ITBSPu = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering weighted ITB_SP
[OS,OSidx,Jopt,OF,UO] = ITB_SP(autos,size(autos{1,1},1),1);
[X,Y,~,AUC] = perfcurve(autos{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Autos Dataset ROC with weighted ITB-SP with AUC = %0.3f',AUC));

autos_ITBSPw = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering unweighted ITB_SS
[OS,OSidx,Jopt,OF,UO] = ITB_SS(autos,size(autos{1,1},1),0);
[X,Y,~,AUC] = perfcurve(autos{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Autos Dataset ROC with unweighted ITB-SS with AUC = %0.3f',AUC));

autos_ITBSSu = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering weighted ITB_SS
[OS,OSidx,Jopt,OF,UO] = ITB_SS(autos,size(autos{1,1},1),1);
[X,Y,~,AUC] = perfcurve(autos{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Autos Dataset ROC with weighted ITB-SS with AUC = %0.3f',AUC));

autos_ITBSSw = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

save('exp02_autos_res.mat','autos_ITBSPu','autos_ITBSPw','autos_ITBSSu','autos_ITBSSw');

