clear; clc; warning off

%% Considering effectiveness test - test on real dataset web-advertisement
load('webAd.mat');
% Performing experiments
% Considering unweighted ITB_SP
[OS,OSidx,Jopt,OF,UO] = ITB_SP(webAd,size(webAd{1,1},1),0);
[X,Y,~,AUC] = perfcurve(webAd{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Web-Ad Dataset ROC with unweighted ITB-SP with AUC = %0.3f',AUC));

webAd_ITBSPu = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering weighted ITB_SP
[OS,OSidx,Jopt,OF,UO] = ITB_SP(webAd,size(webAd{1,1},1),1);
[X,Y,~,AUC] = perfcurve(webAd{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Web-Ad Dataset ROC with weighted ITB-SP with AUC = %0.3f',AUC));

webAd_ITBSPw = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering unweighted ITB_SS
[OS,OSidx,Jopt,OF,UO] = ITB_SS(webAd,size(webAd{1,1},1),0);
[X,Y,~,AUC] = perfcurve(webAd{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Web-Ad Dataset ROC with unweighted ITB-SS with AUC = %0.3f',AUC));

webAd_ITBSSu = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

% Considering weighted ITB_SS
tic
[OS,OSidx,Jopt,OF,UO] = ITB_SS(webAd,size(webAd{1,1},1),1);
webAd_ITBSSw_elapsTime = toc
[X,Y,~,AUC] = perfcurve(webAd{1,1}(:,end),OF,1);
figure; plot(X,Y,'r','LineWidth',1.5); grid on;
xlabel('FP'); ylabel('TP'); title(sprintf('Web-Ad Dataset ROC with weighted ITB-SS with AUC = %0.3f',AUC));

webAd_ITBSSw = struct('OS',OS,'OSidx',OSidx,'Jopt',Jopt,'OF',OF,'UO',UO,'rocX',X,'rocY',Y,'AUC',AUC);

save('exp02_webAd_res.mat','webAd_ITBSPu','webAd_ITBSPw','webAd_ITBSSu','webAd_ITBSSw');

