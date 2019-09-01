clear
close all
clc
warning off

gamma = .8;

%% Considering synthetic dataset LFR1

DBLC_NMIvec_LFR1 = zeros(1,5);
DBLC_Fscore_LFR1 = zeros(1,5);
DBLC_precision_LFR1 = zeros(1,5);
DBLC_recall_LFR1 = zeros(1,5);

% LFR1 with Om=2
LFR1_Om2_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om2.dat');
LFR1_Om2_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om2.dat');
LFR1_Om2_Com = LFR1_Om2_Com(:,2:end);
nodNo = max(LFR1_Om2_Net(:));

[bestEpsi_LFR12,bestMu_LFR12,bestNodMembMat_LFR12] = paramSel(LFR1_Om2_Net, gamma);
DBLC_NMIvec_LFR1(1) = NMI_calc(commCelArrMaker(LFR1_Om2_Com),commCelArrMaker(bestNodMembMat_LFR12),nodNo);

[DBLC_Fscore_LFR1(1),DBLC_precision_LFR1(1),DBLC_recall_LFR1(1)] = Fscore_Calc(LFR1_Om2_Com,bestNodMembMat_LFR12);

% LFR1 with Om=3
LFR1_Om3_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om3.dat');
LFR1_Om3_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om3.dat');
LFR1_Om3_Com = LFR1_Om3_Com(:,2:end);
nodNo = max(LFR1_Om3_Net(:));

[bestEpsi_LFR13,bestMu_LFR13,bestNodMembMat_LFR13] = paramSel(LFR1_Om3_Net, gamma);
DBLC_NMIvec_LFR1(2) = NMI_calc(commCelArrMaker(LFR1_Om3_Com),commCelArrMaker(bestNodMembMat_LFR13),nodNo);

[DBLC_Fscore_LFR1(2),DBLC_precision_LFR1(2),DBLC_recall_LFR1(2)] = Fscore_Calc(LFR1_Om3_Com,bestNodMembMat_LFR13);

% LFR1 with Om=4
LFR1_Om4_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om4.dat');
LFR1_Om4_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om4.dat');
LFR1_Om4_Com = LFR1_Om4_Com(:,2:end);
nodNo = max(LFR1_Om4_Net(:));

[bestEpsi_LFR14,bestMu_LFR14,bestNodMembMat_LFR14] = paramSel(LFR1_Om4_Net, gamma);
DBLC_NMIvec_LFR1(3) = NMI_calc(commCelArrMaker(LFR1_Om4_Com),commCelArrMaker(bestNodMembMat_LFR14),nodNo);

[DBLC_Fscore_LFR1(3),DBLC_precision_LFR1(3),DBLC_recall_LFR1(3)] = Fscore_Calc(LFR1_Om4_Com,bestNodMembMat_LFR14);

% LFR1 with Om=5
LFR1_Om5_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om5.dat');
LFR1_Om5_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om5.dat');
LFR1_Om5_Com = LFR1_Om5_Com(:,2:end);
nodNo = max(LFR1_Om5_Net(:));

[bestEpsi_LFR15,bestMu_LFR15,bestNodMembMat_LFR15] = paramSel(LFR1_Om5_Net, gamma);
DBLC_NMIvec_LFR1(4) = NMI_calc(commCelArrMaker(LFR1_Om5_Com),commCelArrMaker(bestNodMembMat_LFR15),nodNo);

[DBLC_Fscore_LFR1(4),DBLC_precision_LFR1(4),DBLC_recall_LFR1(4)] = Fscore_Calc(LFR1_Om5_Com,bestNodMembMat_LFR15);

% LFR1 with Om=6
LFR1_Om6_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om6.dat');
LFR1_Om6_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om6.dat');
LFR1_Om6_Com = LFR1_Om6_Com(:,2:end);
nodNo = max(LFR1_Om6_Net(:));

[bestEpsi_LFR16,bestMu_LFR16,bestNodMembMat_LFR16] = paramSel(LFR1_Om6_Net, gamma);
DBLC_NMIvec_LFR1(5) = NMI_calc(commCelArrMaker(LFR1_Om6_Com),commCelArrMaker(bestNodMembMat_LFR16),nodNo);

[DBLC_Fscore_LFR1(5),DBLC_precision_LFR1(5),DBLC_recall_LFR1(5)] = Fscore_Calc(LFR1_Om6_Com,bestNodMembMat_LFR16);

%% Considering synthetic dataset LFR2

DBLC_NMIvec_LFR2 = zeros(1,5);
DBLC_Fscore_LFR2 = zeros(1,5);
DBLC_precision_LFR2 = zeros(1,5);
DBLC_recall_LFR2 = zeros(1,5);

% LFR2 with Om=2
LFR2_Om2_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om2.dat');
LFR2_Om2_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om2.dat');
LFR2_Om2_Com = LFR2_Om2_Com(:,2:end);
nodNo = max(LFR2_Om2_Net(:));

[bestEpsi_LFR22,bestMu_LFR22,bestNodMembMat_LFR22] = paramSel(LFR2_Om2_Net, gamma);
DBLC_NMIvec_LFR2(1) = NMI_calc(commCelArrMaker(LFR2_Om2_Com),commCelArrMaker(bestNodMembMat_LFR22),nodNo);

[DBLC_Fscore_LFR2(1),DBLC_precision_LFR2(1),DBLC_recall_LFR2(1)] = Fscore_Calc(LFR2_Om2_Com,bestNodMembMat_LFR22);

% LFR2 with Om=3
LFR2_Om3_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om3.dat');
LFR2_Om3_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om3.dat');
LFR2_Om3_Com = LFR2_Om3_Com(:,2:end);
nodNo = max(LFR2_Om3_Net(:));

[bestEpsi_LFR23,bestMu_LFR23,bestNodMembMat_LFR23] = paramSel(LFR2_Om3_Net, gamma);
DBLC_NMIvec_LFR2(2) = NMI_calc(commCelArrMaker(LFR2_Om3_Com),commCelArrMaker(bestNodMembMat_LFR23),nodNo);

[DBLC_Fscore_LFR2(2),DBLC_precision_LFR2(2),DBLC_recall_LFR2(2)] = Fscore_Calc(LFR2_Om3_Com,bestNodMembMat_LFR23);

% LFR2 with Om=4
LFR2_Om4_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om4.dat');
LFR2_Om4_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om4.dat');
LFR2_Om4_Com = LFR2_Om4_Com(:,2:end);
nodNo = max(LFR2_Om4_Net(:));

[bestEpsi_LFR24,bestMu_LFR24,bestNodMembMat_LFR24] = paramSel(LFR2_Om4_Net, gamma);
DBLC_NMIvec_LFR2(3) = NMI_calc(commCelArrMaker(LFR2_Om4_Com),commCelArrMaker(bestNodMembMat_LFR24),nodNo);

[DBLC_Fscore_LFR2(3),DBLC_precision_LFR2(3),DBLC_recall_LFR2(3)] = Fscore_Calc(LFR2_Om4_Com,bestNodMembMat_LFR24);

% LFR2 with Om=5
LFR2_Om5_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om5.dat');
LFR2_Om5_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om5.dat');
LFR2_Om5_Com = LFR2_Om5_Com(:,2:end);
nodNo = max(LFR2_Om5_Net(:));

[bestEpsi_LFR25,bestMu_LFR25,bestNodMembMat_LFR25] = paramSel(LFR2_Om5_Net, gamma);
DBLC_NMIvec_LFR2(4) = NMI_calc(commCelArrMaker(LFR2_Om5_Com),commCelArrMaker(bestNodMembMat_LFR25),nodNo);

[DBLC_Fscore_LFR2(4),DBLC_precision_LFR2(4),DBLC_recall_LFR2(4)] = Fscore_Calc(LFR2_Om5_Com,bestNodMembMat_LFR25);

% LFR2 with Om=6
LFR2_Om6_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om6.dat');
LFR2_Om6_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om6.dat');
LFR2_Om6_Com = LFR2_Om6_Com(:,2:end);
nodNo = max(LFR2_Om6_Net(:));

[bestEpsi_LFR26,bestMu_LFR26,bestNodMembMat_LFR26] = paramSel(LFR2_Om6_Net, gamma);
DBLC_NMIvec_LFR2(5) = NMI_calc(commCelArrMaker(LFR2_Om6_Com),commCelArrMaker(bestNodMembMat_LFR26),nodNo);

[DBLC_Fscore_LFR2(5),DBLC_precision_LFR2(5),DBLC_recall_LFR2(5)] = Fscore_Calc(LFR2_Om6_Com,bestNodMembMat_LFR26);

%% Considering synthetic dataset LFR3

DBLC_NMIvec_LFR3 = zeros(1,5);
DBLC_Fscore_LFR3 = zeros(1,5);
DBLC_precision_LFR3 = zeros(1,5);
DBLC_recall_LFR3 = zeros(1,5);

% LFR3 with Om=2
LFR3_Om2_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om2.dat');
LFR3_Om2_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om2.dat');
LFR3_Om2_Com = LFR3_Om2_Com(:,2:end);
nodNo = max(LFR3_Om2_Net(:));

[bestEpsi_LFR32,bestMu_LFR32,bestNodMembMat_LFR32] = paramSel(LFR3_Om2_Net, gamma);
DBLC_NMIvec_LFR3(1) = NMI_calc(commCelArrMaker(LFR3_Om2_Com),commCelArrMaker(bestNodMembMat_LFR32),nodNo);

[DBLC_Fscore_LFR3(1),DBLC_precision_LFR3(1),DBLC_recall_LFR3(1)] = Fscore_Calc(LFR3_Om2_Com,bestNodMembMat_LFR32);

% LFR3 with Om=3
LFR3_Om3_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om3.dat');
LFR3_Om3_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om3.dat');
LFR3_Om3_Com = LFR3_Om3_Com(:,2:end);
nodNo = max(LFR3_Om3_Net(:));

[bestEpsi_LFR33,bestMu_LFR33,bestNodMembMat_LFR33] = paramSel(LFR3_Om3_Net, gamma);
DBLC_NMIvec_LFR3(2) = NMI_calc(commCelArrMaker(LFR3_Om3_Com),commCelArrMaker(bestNodMembMat_LFR33),nodNo);

[DBLC_Fscore_LFR3(2),DBLC_precision_LFR3(2),DBLC_recall_LFR3(2)] = Fscore_Calc(LFR3_Om3_Com,bestNodMembMat_LFR33);

% LFR3 with Om=4
LFR3_Om4_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om4.dat');
LFR3_Om4_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om4.dat');
LFR3_Om4_Com = LFR3_Om4_Com(:,2:end);
nodNo = max(LFR3_Om4_Net(:));

[bestEpsi_LFR34,bestMu_LFR34,bestNodMembMat_LFR34] = paramSel(LFR3_Om4_Net, gamma);
DBLC_NMIvec_LFR3(3) = NMI_calc(commCelArrMaker(LFR3_Om4_Com),commCelArrMaker(bestNodMembMat_LFR34),nodNo);

[DBLC_Fscore_LFR3(3),DBLC_precision_LFR3(3),DBLC_recall_LFR3(3)] = Fscore_Calc(LFR3_Om4_Com,bestNodMembMat_LFR34);

% LFR3 with Om=5
LFR3_Om5_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om5.dat');
LFR3_Om5_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om5.dat');
LFR3_Om5_Com = LFR3_Om5_Com(:,2:end);
nodNo = max(LFR3_Om5_Net(:));

[bestEpsi_LFR35,bestMu_LFR35,bestNodMembMat_LFR35] = paramSel(LFR3_Om5_Net, gamma);
DBLC_NMIvec_LFR3(4) = NMI_calc(commCelArrMaker(LFR3_Om5_Com),commCelArrMaker(bestNodMembMat_LFR35),nodNo);

[DBLC_Fscore_LFR3(4),DBLC_precision_LFR3(4),DBLC_recall_LFR3(4)] = Fscore_Calc(LFR3_Om5_Com,bestNodMembMat_LFR35);

% LFR3 with Om=6
LFR3_Om6_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om6.dat');
LFR3_Om6_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om6.dat');
LFR3_Om6_Com = LFR3_Om6_Com(:,2:end);
nodNo = max(LFR3_Om6_Net(:));

[bestEpsi_LFR36,bestMu_LFR36,bestNodMembMat_LFR36] = paramSel(LFR3_Om6_Net, gamma);
DBLC_NMIvec_LFR3(5) = NMI_calc(commCelArrMaker(LFR3_Om6_Com),commCelArrMaker(bestNodMembMat_LFR36),nodNo);

[DBLC_Fscore_LFR3(5),DBLC_precision_LFR3(5),DBLC_recall_LFR3(5)] = Fscore_Calc(LFR3_Om6_Com,bestNodMembMat_LFR36);

%% Considering synthetic dataset LFR4

DBLC_NMIvec_LFR4 = zeros(1,5);
DBLC_Fscore_LFR4 = zeros(1,5);
DBLC_precision_LFR4 = zeros(1,5);
DBLC_recall_LFR4 = zeros(1,5);

% LFR4 with Om=2
LFR4_Om2_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om2.dat');
LFR4_Om2_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om2.dat');
LFR4_Om2_Com = LFR4_Om2_Com(:,2:end);
nodNo = max(LFR4_Om2_Net(:));

[bestEpsi_LFR42,bestMu_LFR42,bestNodMembMat_LFR42] = paramSel(LFR4_Om2_Net, gamma);
DBLC_NMIvec_LFR4(1) = NMI_calc(commCelArrMaker(LFR4_Om2_Com),commCelArrMaker(bestNodMembMat_LFR42),nodNo);

[DBLC_Fscore_LFR4(1),DBLC_precision_LFR4(1),DBLC_recall_LFR4(1)] = Fscore_Calc(LFR4_Om2_Com,bestNodMembMat_LFR42);

% LFR4 with Om=3
LFR4_Om3_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om3.dat');
LFR4_Om3_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om3.dat');
LFR4_Om3_Com = LFR4_Om3_Com(:,2:end);
nodNo = max(LFR4_Om3_Net(:));

[bestEpsi_LFR43,bestMu_LFR43,bestNodMembMat_LFR43] = paramSel(LFR4_Om3_Net, gamma);
DBLC_NMIvec_LFR4(2) = NMI_calc(commCelArrMaker(LFR4_Om3_Com),commCelArrMaker(bestNodMembMat_LFR43),nodNo);

[DBLC_Fscore_LFR4(2),DBLC_precision_LFR4(2),DBLC_recall_LFR4(2)] = Fscore_Calc(LFR4_Om3_Com,bestNodMembMat_LFR43);

% LFR4 with Om=4
LFR4_Om4_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om4.dat');
LFR4_Om4_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om4.dat');
LFR4_Om4_Com = LFR4_Om4_Com(:,2:end);
nodNo = max(LFR4_Om4_Net(:));

[bestEpsi_LFR44,bestMu_LFR44,bestNodMembMat_LFR44] = paramSel(LFR4_Om4_Net, gamma);
DBLC_NMIvec_LFR4(3) = NMI_calc(commCelArrMaker(LFR4_Om4_Com),commCelArrMaker(bestNodMembMat_LFR44),nodNo);

[DBLC_Fscore_LFR4(3),DBLC_precision_LFR4(3),DBLC_recall_LFR4(3)] = Fscore_Calc(LFR4_Om4_Com,bestNodMembMat_LFR44);

% LFR4 with Om=5
LFR4_Om5_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om5.dat');
LFR4_Om5_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om5.dat');
LFR4_Om5_Com = LFR4_Om5_Com(:,2:end);
nodNo = max(LFR4_Om5_Net(:));

[bestEpsi_LFR45,bestMu_LFR45,bestNodMembMat_LFR45] = paramSel(LFR4_Om5_Net, gamma);
DBLC_NMIvec_LFR4(4) = NMI_calc(commCelArrMaker(LFR4_Om5_Com),commCelArrMaker(bestNodMembMat_LFR45),nodNo);

[DBLC_Fscore_LFR4(4),DBLC_precision_LFR4(4),DBLC_recall_LFR4(4)] = Fscore_Calc(LFR4_Om5_Com,bestNodMembMat_LFR45);

% LFR4 with Om=6
LFR4_Om6_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om6.dat');
LFR4_Om6_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om6.dat');
LFR4_Om6_Com = LFR4_Om6_Com(:,2:end);
nodNo = max(LFR4_Om6_Net(:));

[bestEpsi_LFR46,bestMu_LFR46,bestNodMembMat_LFR46] = paramSel(LFR4_Om6_Net, gamma);
DBLC_NMIvec_LFR4(5) = NMI_calc(commCelArrMaker(LFR4_Om6_Com),commCelArrMaker(bestNodMembMat_LFR46),nodNo);

[DBLC_Fscore_LFR4(5),DBLC_precision_LFR4(5),DBLC_recall_LFR4(5)] = Fscore_Calc(LFR4_Om6_Com,bestNodMembMat_LFR46);

%% Considering synthetic dataset LFR5

DBLC_NMIvec_LFR5 = zeros(1,5);
DBLC_Fscore_LFR5 = zeros(1,5);
DBLC_precision_LFR5 = zeros(1,5);
DBLC_recall_LFR5 = zeros(1,5);

% LFR5 with Om=2
LFR5_Om2_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om2.dat');
LFR5_Om2_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om2.dat');
LFR5_Om2_Com = LFR5_Om2_Com(:,2:end);
nodNo = max(LFR5_Om2_Net(:));

[bestEpsi_LFR52,bestMu_LFR52,bestNodMembMat_LFR52] = paramSel(LFR5_Om2_Net, gamma);
DBLC_NMIvec_LFR5(1) = NMI_calc(commCelArrMaker(LFR5_Om2_Com),commCelArrMaker(bestNodMembMat_LFR52),nodNo);

[DBLC_Fscore_LFR5(1),DBLC_precision_LFR5(1),DBLC_recall_LFR5(1)] = Fscore_Calc(LFR5_Om2_Com,bestNodMembMat_LFR52);

% LFR5 with Om=3
LFR5_Om3_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om3.dat');
LFR5_Om3_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om3.dat');
LFR5_Om3_Com = LFR5_Om3_Com(:,2:end);
nodNo = max(LFR5_Om3_Net(:));

[bestEpsi_LFR53,bestMu_LFR53,bestNodMembMat_LFR53] = paramSel(LFR5_Om3_Net, gamma);
DBLC_NMIvec_LFR5(2) = NMI_calc(commCelArrMaker(LFR5_Om3_Com),commCelArrMaker(bestNodMembMat_LFR53),nodNo);

[DBLC_Fscore_LFR5(2),DBLC_precision_LFR5(2),DBLC_recall_LFR5(2)] = Fscore_Calc(LFR5_Om3_Com,bestNodMembMat_LFR53);

% LFR5 with Om=4
LFR5_Om4_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om4.dat');
LFR5_Om4_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om4.dat');
LFR5_Om4_Com = LFR5_Om4_Com(:,2:end);
nodNo = max(LFR5_Om4_Net(:));

[bestEpsi_LFR54,bestMu_LFR54,bestNodMembMat_LFR54] = paramSel(LFR5_Om4_Net, gamma);
DBLC_NMIvec_LFR5(3) = NMI_calc(commCelArrMaker(LFR5_Om4_Com),commCelArrMaker(bestNodMembMat_LFR54),nodNo);

[DBLC_Fscore_LFR5(3),DBLC_precision_LFR5(3),DBLC_recall_LFR5(3)] = Fscore_Calc(LFR5_Om4_Com,bestNodMembMat_LFR54);

% LFR5 with Om=5
LFR5_Om5_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om5.dat');
LFR5_Om5_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om5.dat');
LFR5_Om5_Com = LFR5_Om5_Com(:,2:end);
nodNo = max(LFR5_Om5_Net(:));

[bestEpsi_LFR55,bestMu_LFR55,bestNodMembMat_LFR55] = paramSel(LFR5_Om5_Net, gamma);
DBLC_NMIvec_LFR5(4) = NMI_calc(commCelArrMaker(LFR5_Om5_Com),commCelArrMaker(bestNodMembMat_LFR55),nodNo);

[DBLC_Fscore_LFR5(4),DBLC_precision_LFR5(4),DBLC_recall_LFR5(4)] = Fscore_Calc(LFR5_Om5_Com,bestNodMembMat_LFR55);

% LFR5 with Om=6
LFR5_Om6_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om6.dat');
LFR5_Om6_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om6.dat');
LFR5_Om6_Com = LFR5_Om6_Com(:,2:end);
nodNo = max(LFR5_Om6_Net(:));

[bestEpsi_LFR56,bestMu_LFR56,bestNodMembMat_LFR56] = paramSel(LFR5_Om6_Net, gamma);
DBLC_NMIvec_LFR5(5) = NMI_calc(commCelArrMaker(LFR5_Om6_Com),commCelArrMaker(bestNodMembMat_LFR56),nodNo);

[DBLC_Fscore_LFR5(5),DBLC_precision_LFR5(5),DBLC_recall_LFR5(5)] = Fscore_Calc(LFR5_Om6_Com,bestNodMembMat_LFR56);

%% Considering synthetic dataset LFR6

DBLC_NMIvec_LFR6 = zeros(1,5);
DBLC_Fscore_LFR6 = zeros(1,5);
DBLC_precision_LFR6 = zeros(1,5);
DBLC_recall_LFR6 = zeros(1,5);

% LFR6 with Om=2
LFR6_Om2_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om2.dat');
LFR6_Om2_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om2.dat');
LFR6_Om2_Com = LFR6_Om2_Com(:,2:end);
nodNo = max(LFR6_Om2_Net(:));

[bestEpsi_LFR62,bestMu_LFR62,bestNodMembMat_LFR62] = paramSel(LFR6_Om2_Net, gamma);
DBLC_NMIvec_LFR6(1) = NMI_calc(commCelArrMaker(LFR6_Om2_Com),commCelArrMaker(bestNodMembMat_LFR62),nodNo);

[DBLC_Fscore_LFR6(1),DBLC_precision_LFR6(1),DBLC_recall_LFR6(1)] = Fscore_Calc(LFR6_Om2_Com,bestNodMembMat_LFR62);

% LFR6 with Om=3
LFR6_Om3_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om3.dat');
LFR6_Om3_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om3.dat');
LFR6_Om3_Com = LFR6_Om3_Com(:,2:end);
nodNo = max(LFR6_Om3_Net(:));

[bestEpsi_LFR63,bestMu_LFR63,bestNodMembMat_LFR63] = paramSel(LFR6_Om3_Net, gamma);
DBLC_NMIvec_LFR6(2) = NMI_calc(commCelArrMaker(LFR6_Om3_Com),commCelArrMaker(bestNodMembMat_LFR63),nodNo);

[DBLC_Fscore_LFR6(2),DBLC_precision_LFR6(2),DBLC_recall_LFR6(2)] = Fscore_Calc(LFR6_Om3_Com,bestNodMembMat_LFR63);

% LFR6 with Om=4
LFR6_Om4_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om4.dat');
LFR6_Om4_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om4.dat');
LFR6_Om4_Com = LFR6_Om4_Com(:,2:end);
nodNo = max(LFR6_Om4_Net(:));

[bestEpsi_LFR64,bestMu_LFR64,bestNodMembMat_LFR64] = paramSel(LFR6_Om4_Net, gamma);
DBLC_NMIvec_LFR6(3) = NMI_calc(commCelArrMaker(LFR6_Om4_Com),commCelArrMaker(bestNodMembMat_LFR64),nodNo);

[DBLC_Fscore_LFR6(3),DBLC_precision_LFR6(3),DBLC_recall_LFR6(3)] = Fscore_Calc(LFR6_Om4_Com,bestNodMembMat_LFR64);

% LFR6 with Om=5
LFR6_Om5_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om5.dat');
LFR6_Om5_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om5.dat');
LFR6_Om5_Com = LFR6_Om5_Com(:,2:end);
nodNo = max(LFR6_Om5_Net(:));

[bestEpsi_LFR65,bestMu_LFR65,bestNodMembMat_LFR65] = paramSel(LFR6_Om5_Net, gamma);
DBLC_NMIvec_LFR6(4) = NMI_calc(commCelArrMaker(LFR6_Om5_Com),commCelArrMaker(bestNodMembMat_LFR65),nodNo);

[DBLC_Fscore_LFR6(4),DBLC_precision_LFR6(4),DBLC_recall_LFR6(4)] = Fscore_Calc(LFR6_Om5_Com,bestNodMembMat_LFR65);

% LFR6 with Om=6
LFR6_Om6_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om6.dat');
LFR6_Om6_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om6.dat');
LFR6_Om6_Com = LFR6_Om6_Com(:,2:end);
nodNo = max(LFR6_Om6_Net(:));

[bestEpsi_LFR66,bestMu_LFR66,bestNodMembMat_LFR66] = paramSel(LFR6_Om6_Net, gamma);
DBLC_NMIvec_LFR6(5) = NMI_calc(commCelArrMaker(LFR6_Om6_Com),commCelArrMaker(bestNodMembMat_LFR66),nodNo);

[DBLC_Fscore_LFR6(5),DBLC_precision_LFR6(5),DBLC_recall_LFR6(5)] = Fscore_Calc(LFR6_Om6_Com,bestNodMembMat_LFR66);

