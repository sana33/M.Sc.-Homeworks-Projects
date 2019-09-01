warning off;

%% Loading variables

% Considering LFR1
load('results_LFR1.mat'); load('CPM_results.mat');
DBLC_NMI_LFR1 = DBLC_NMIvec_LFR1;
DBLC_prec_LFR1 = DBLC_precision_LFR1;
DBLC_reca_LFR1 = DBLC_recall_LFR1;
DBLC_Fsco_LFR1 = DBLC_Fscore_LFR1;

CPM_NMI_LFR1 = CPM_NMIvec_LFR1;
CPM_prec_LFR1 = CPM_precision_LFR1;
CPM_reca_LFR1 = CPM_recall_LFR1;
CPM_Fsco_LFR1 = CPM_Fscore_LFR1;

save('finRes.mat','DBLC_NMI_LFR1','DBLC_prec_LFR1','DBLC_reca_LFR1','DBLC_Fsco_LFR1', ...
    'CPM_NMI_LFR1','CPM_prec_LFR1','CPM_reca_LFR1','CPM_Fsco_LFR1');
clear;

% Considering LFR2
load('results_LFR2.mat'); load('CPM_results.mat');
DBLC_NMI_LFR2 = DBLC_NMIvec_LFR2;
DBLC_prec_LFR2 = DBLC_precision_LFR2;
DBLC_reca_LFR2 = DBLC_recall_LFR2;
DBLC_Fsco_LFR2 = DBLC_Fscore_LFR2;

CPM_NMI_LFR2 = CPM_NMIvec_LFR2;
CPM_prec_LFR2 = CPM_precision_LFR2;
CPM_reca_LFR2 = CPM_recall_LFR2;
CPM_Fsco_LFR2 = CPM_Fscore_LFR2;

save('finRes.mat','DBLC_NMI_LFR2','DBLC_prec_LFR2','DBLC_reca_LFR2','DBLC_Fsco_LFR2', ...
    'CPM_NMI_LFR2','CPM_prec_LFR2','CPM_reca_LFR2','CPM_Fsco_LFR2','-append');
clear;

% Considering LFR3
load('results_LFR3.mat'); load('CPM_results.mat');
DBLC_NMI_LFR3 = DBLC_NMIvec_LFR3;
DBLC_prec_LFR3 = DBLC_precision_LFR3;
DBLC_reca_LFR3 = DBLC_recall_LFR3;
DBLC_Fsco_LFR3 = DBLC_Fscore_LFR3;

CPM_NMI_LFR3 = CPM_NMIvec_LFR3;
CPM_prec_LFR3 = CPM_precision_LFR3;
CPM_reca_LFR3 = CPM_recall_LFR3;
CPM_Fsco_LFR3 = CPM_Fscore_LFR3;

save('finRes.mat','DBLC_NMI_LFR3','DBLC_prec_LFR3','DBLC_reca_LFR3','DBLC_Fsco_LFR3', ...
    'CPM_NMI_LFR3','CPM_prec_LFR3','CPM_reca_LFR3','CPM_Fsco_LFR3','-append');
clear;

% Considering LFR4
load('results_LFR4.mat'); load('CPM_results.mat');
DBLC_NMI_LFR4 = DBLC_NMIvec_LFR4;
DBLC_prec_LFR4 = DBLC_precision_LFR4;
DBLC_reca_LFR4 = DBLC_recall_LFR4;
DBLC_Fsco_LFR4 = DBLC_Fscore_LFR4;

CPM_NMI_LFR4 = CPM_NMIvec_LFR4;
CPM_prec_LFR4 = CPM_precision_LFR4;
CPM_reca_LFR4 = CPM_recall_LFR4;
CPM_Fsco_LFR4 = CPM_Fscore_LFR4;

save('finRes.mat','DBLC_NMI_LFR4','DBLC_prec_LFR4','DBLC_reca_LFR4','DBLC_Fsco_LFR4', ...
    'CPM_NMI_LFR4','CPM_prec_LFR4','CPM_reca_LFR4','CPM_Fsco_LFR4','-append');
clear;

% Considering LFR5
load('results_LFR5.mat'); load('CPM_results.mat');
DBLC_NMI_LFR5 = DBLC_NMIvec_LFR5;
DBLC_prec_LFR5 = DBLC_precision_LFR5;
DBLC_reca_LFR5 = DBLC_recall_LFR5;
DBLC_Fsco_LFR5 = DBLC_Fscore_LFR5;

CPM_NMI_LFR5 = CPM_NMIvec_LFR5;
CPM_prec_LFR5 = CPM_precision_LFR5;
CPM_reca_LFR5 = CPM_recall_LFR5;
CPM_Fsco_LFR5 = CPM_Fscore_LFR5;

save('finRes.mat','DBLC_NMI_LFR5','DBLC_prec_LFR5','DBLC_reca_LFR5','DBLC_Fsco_LFR5', ...
    'CPM_NMI_LFR5','CPM_prec_LFR5','CPM_reca_LFR5','CPM_Fsco_LFR5','-append');
clear;

% Considering LFR6
load('results_LFR6.mat'); load('CPM_results.mat');
DBLC_NMI_LFR6 = DBLC_NMIvec_LFR6;
DBLC_prec_LFR6 = DBLC_precision_LFR6;
DBLC_reca_LFR6 = DBLC_recall_LFR6;
DBLC_Fsco_LFR6 = DBLC_Fscore_LFR6;

CPM_NMI_LFR6 = CPM_NMIvec_LFR6;
CPM_prec_LFR6 = CPM_precision_LFR6;
CPM_reca_LFR6 = CPM_recall_LFR6;
CPM_Fsco_LFR6 = CPM_Fscore_LFR6;

save('finRes.mat','DBLC_NMI_LFR6','DBLC_prec_LFR6','DBLC_reca_LFR6','DBLC_Fsco_LFR6', ...
    'CPM_NMI_LFR6','CPM_prec_LFR6','CPM_reca_LFR6','CPM_Fsco_LFR6','-append');
clear;

load('finRes.mat');

%% Considering the NMI comparison results

fig_NMI = figure;

ax1 = subplot(3,2,1);
plot(DBLC_NMI_LFR1,'-sk'); grid on; hold on;
plot(CPM_NMI_LFR1,'-or');
xlabel(ax1,'Om'); ylabel(ax1,'NMI'); title(ax1,'LFR1');
legend(ax1,'DBLC','CPM','location','best');

ax2 = subplot(3,2,3);
plot(DBLC_NMI_LFR2,'-sk'); grid on; hold on;
plot(CPM_NMI_LFR2,'-or');
xlabel(ax2,'Om'); ylabel(ax2,'NMI'); title(ax2,'LFR2');
legend(ax2,'DBLC','CPM','location','best');

ax3 = subplot(3,2,5);
plot(DBLC_NMI_LFR3,'-sk'); grid on; hold on;
plot(CPM_NMI_LFR3,'-or');
xlabel(ax3,'Om'); ylabel(ax3,'NMI'); title(ax3,'LFR3');
legend(ax3,'DBLC','CPM','location','best');

ax4 = subplot(3,2,2);
plot(DBLC_NMI_LFR4,'-sk'); grid on; hold on;
plot(CPM_NMI_LFR4,'-or');
xlabel(ax4,'Om'); ylabel(ax4,'NMI'); title(ax4,'LFR4');
legend(ax4,'DBLC','CPM','location','best');

ax5 = subplot(3,2,4);
plot(DBLC_NMI_LFR5,'-sk'); grid on; hold on;
plot(CPM_NMI_LFR5,'-or');
xlabel(ax5,'Om'); ylabel(ax5,'NMI'); title(ax5,'LFR5');
legend(ax5,'DBLC','CPM','location','best');

ax6 = subplot(3,2,6);
plot(DBLC_NMI_LFR6,'-sk'); grid on; hold on;
plot(CPM_NMI_LFR6,'-or');
xlabel(ax6,'Om'); ylabel(ax6,'NMI'); title(ax6,'LFR6');
legend(ax6,'DBLC','CPM','location','best');

%% Considering the Precision comparison results

fig_prec = figure;

ax1 = subplot(3,2,1);
plot(DBLC_prec_LFR1,'-sk'); grid on; hold on;
plot(CPM_prec_LFR1,'-or');
xlabel(ax1,'Om'); ylabel(ax1,'Precision'); title(ax1,'LFR1');
legend(ax1,'DBLC','CPM','location','best');

ax2 = subplot(3,2,3);
plot(DBLC_prec_LFR2,'-sk'); grid on; hold on;
plot(CPM_prec_LFR2,'-or');
xlabel(ax2,'Om'); ylabel(ax2,'Precision'); title(ax2,'LFR2');
legend(ax2,'DBLC','CPM','location','best');

ax3 = subplot(3,2,5);
plot(DBLC_prec_LFR3,'-sk'); grid on; hold on;
plot(CPM_prec_LFR3,'-or');
xlabel(ax3,'Om'); ylabel(ax3,'Precision'); title(ax3,'LFR3');
legend(ax3,'DBLC','CPM','location','best');

ax4 = subplot(3,2,2);
plot(DBLC_prec_LFR4,'-sk'); grid on; hold on;
plot(CPM_prec_LFR4,'-or');
xlabel(ax4,'Om'); ylabel(ax4,'Precision'); title(ax4,'LFR4');
legend(ax4,'DBLC','CPM','location','best');

ax5 = subplot(3,2,4);
plot(DBLC_prec_LFR5,'-sk'); grid on; hold on;
plot(CPM_prec_LFR5,'-or');
xlabel(ax5,'Om'); ylabel(ax5,'Precision'); title(ax5,'LFR5');
legend(ax5,'DBLC','CPM','location','best');

ax6 = subplot(3,2,6);
plot(DBLC_prec_LFR6,'-sk'); grid on; hold on;
plot(CPM_prec_LFR6,'-or');
xlabel(ax6,'Om'); ylabel(ax6,'Precision'); title(ax6,'LFR6');
legend(ax6,'DBLC','CPM','location','best');

%% Considering the Recall comparison results

fig_reca = figure;

ax1 = subplot(3,2,1);
plot(DBLC_reca_LFR1,'-sk'); grid on; hold on;
plot(CPM_reca_LFR1,'-or');
xlabel(ax1,'Om'); ylabel(ax1,'Recall'); title(ax1,'LFR1');
legend(ax1,'DBLC','CPM','location','best');

ax2 = subplot(3,2,3);
plot(DBLC_reca_LFR2,'-sk'); grid on; hold on;
plot(CPM_reca_LFR2,'-or');
xlabel(ax2,'Om'); ylabel(ax2,'Recall'); title(ax2,'LFR2');
legend(ax2,'DBLC','CPM','location','best');

ax3 = subplot(3,2,5);
plot(DBLC_reca_LFR3,'-sk'); grid on; hold on;
plot(CPM_reca_LFR3,'-or');
xlabel(ax3,'Om'); ylabel(ax3,'Recall'); title(ax3,'LFR3');
legend(ax3,'DBLC','CPM','location','best');

ax4 = subplot(3,2,2);
plot(DBLC_reca_LFR4,'-sk'); grid on; hold on;
plot(CPM_reca_LFR4,'-or');
xlabel(ax4,'Om'); ylabel(ax4,'Recall'); title(ax4,'LFR4');
legend(ax4,'DBLC','CPM','location','best');

ax5 = subplot(3,2,4);
plot(DBLC_reca_LFR5,'-sk'); grid on; hold on;
plot(CPM_reca_LFR5,'-or');
xlabel(ax5,'Om'); ylabel(ax5,'Recall'); title(ax5,'LFR5');
legend(ax5,'DBLC','CPM','location','best');

ax6 = subplot(3,2,6);
plot(DBLC_reca_LFR6,'-sk'); grid on; hold on;
plot(CPM_reca_LFR6,'-or');
xlabel(ax6,'Om'); ylabel(ax6,'Recall'); title(ax6,'LFR6');
legend(ax6,'DBLC','CPM','location','best');

%% Considering the Fscore comparison results

fig_Fsco = figure;

ax1 = subplot(3,2,1);
plot(DBLC_Fsco_LFR1,'-sk'); grid on; hold on;
plot(CPM_Fsco_LFR1,'-or');
xlabel(ax1,'Om'); ylabel(ax1,'Fscore'); title(ax1,'LFR1');
legend(ax1,'DBLC','CPM','location','best');

ax2 = subplot(3,2,3);
plot(DBLC_Fsco_LFR2,'-sk'); grid on; hold on;
plot(CPM_Fsco_LFR2,'-or');
xlabel(ax2,'Om'); ylabel(ax2,'Fscore'); title(ax2,'LFR2');
legend(ax2,'DBLC','CPM','location','best');

ax3 = subplot(3,2,5);
plot(DBLC_Fsco_LFR3,'-sk'); grid on; hold on;
plot(CPM_Fsco_LFR3,'-or');
xlabel(ax3,'Om'); ylabel(ax3,'Fscore'); title(ax3,'LFR3');
legend(ax3,'DBLC','CPM','location','best');

ax4 = subplot(3,2,2);
plot(DBLC_Fsco_LFR4,'-sk'); grid on; hold on;
plot(CPM_Fsco_LFR4,'-or');
xlabel(ax4,'Om'); ylabel(ax4,'Fscore'); title(ax4,'LFR4');
legend(ax4,'DBLC','CPM','location','best');

ax5 = subplot(3,2,4);
plot(DBLC_Fsco_LFR5,'-sk'); grid on; hold on;
plot(CPM_Fsco_LFR5,'-or');
xlabel(ax5,'Om'); ylabel(ax5,'Fscore'); title(ax5,'LFR5');
legend(ax5,'DBLC','CPM','location','best');

ax6 = subplot(3,2,6);
plot(DBLC_Fsco_LFR6,'-sk'); grid on; hold on;
plot(CPM_Fsco_LFR6,'-or');
xlabel(ax6,'Om'); ylabel(ax6,'Fscore'); title(ax6,'LFR6');
legend(ax6,'DBLC','CPM','location','best');

