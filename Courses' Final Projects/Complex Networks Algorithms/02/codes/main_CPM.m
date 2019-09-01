clear
close all
clc
warning off


%% Considering synthetic dataset LFR1

CPM_NMIvec_LFR1 = zeros(1,5);
CPM_Fscore_LFR1 = zeros(1,5);
CPM_precision_LFR1 = zeros(1,5);
CPM_recall_LFR1 = zeros(1,5);

% LFR1 with Om=2
LFR1_Om2_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om2.dat');
LFR1_Om2_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om2.dat');
LFR1_Om2_Com = LFR1_Om2_Com(:,2:end);
nodNo = max(LFR1_Om2_Net(:));

NMIvec_LFR12 = zeros(1,3);
for l1 = 3:5
    CPM_LFR12 = dlmread(['..\datasets\binary_networks\LFR1\networ_LFR1_Om2.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR12] = comm2nod_MembMat(CPM_LFR12);
    NMIvec_LFR12(l1) = NMI_calc(commCelArrMaker(LFR1_Om2_Com),commCelArrMaker(nodMembMat_LFR12),nodNo);
end

CPM_NMIvec_LFR1(1) = max(NMIvec_LFR12);

[CPM_Fscore_LFR1(1),CPM_precision_LFR1(1),CPM_recall_LFR1(1)] = Fscore_Calc(LFR1_Om2_Com,nodMembMat_LFR12);

% LFR1 with Om=3
LFR1_Om3_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om3.dat');
LFR1_Om3_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om3.dat');
LFR1_Om3_Com = LFR1_Om3_Com(:,2:end);
nodNo = max(LFR1_Om3_Net(:));

NMIvec_LFR13 = zeros(1,3);
for l1 = 3:5
    CPM_LFR13 = dlmread(['..\datasets\binary_networks\LFR1\networ_LFR1_Om3.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR13] = comm2nod_MembMat(CPM_LFR13);
    NMIvec_LFR13(l1) = NMI_calc(commCelArrMaker(LFR1_Om3_Com),commCelArrMaker(nodMembMat_LFR13),nodNo);
end

CPM_NMIvec_LFR1(2) = max(NMIvec_LFR13);

[CPM_Fscore_LFR1(2),CPM_precision_LFR1(2),CPM_recall_LFR1(2)] = Fscore_Calc(LFR1_Om3_Com,nodMembMat_LFR13);

% LFR1 with Om=4
LFR1_Om4_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om4.dat');
LFR1_Om4_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om4.dat');
LFR1_Om4_Com = LFR1_Om4_Com(:,2:end);
nodNo = max(LFR1_Om4_Net(:));

NMIvec_LFR14 = zeros(1,3);
for l1 = 3:5
    CPM_LFR14 = dlmread(['..\datasets\binary_networks\LFR1\networ_LFR1_Om4.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR14] = comm2nod_MembMat(CPM_LFR14);
    NMIvec_LFR14(l1) = NMI_calc(commCelArrMaker(LFR1_Om4_Com),commCelArrMaker(nodMembMat_LFR14),nodNo);
end

CPM_NMIvec_LFR1(3) = max(NMIvec_LFR14);

[CPM_Fscore_LFR1(3),CPM_precision_LFR1(3),CPM_recall_LFR1(3)] = Fscore_Calc(LFR1_Om4_Com,nodMembMat_LFR14);

% LFR1 with Om=5
LFR1_Om5_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om5.dat');
LFR1_Om5_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om5.dat');
LFR1_Om5_Com = LFR1_Om5_Com(:,2:end);
nodNo = max(LFR1_Om5_Net(:));

NMIvec_LFR15 = zeros(1,3);
for l1 = 3:5
    CPM_LFR15 = dlmread(['..\datasets\binary_networks\LFR1\networ_LFR1_Om5.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR15] = comm2nod_MembMat(CPM_LFR15);
    NMIvec_LFR15(l1) = NMI_calc(commCelArrMaker(LFR1_Om5_Com),commCelArrMaker(nodMembMat_LFR15),nodNo);
end

CPM_NMIvec_LFR1(4) = max(NMIvec_LFR15);

[CPM_Fscore_LFR1(4),CPM_precision_LFR1(4),CPM_recall_LFR1(4)] = Fscore_Calc(LFR1_Om5_Com,nodMembMat_LFR15);

% LFR1 with Om=6
LFR1_Om6_Net = load('..\datasets\binary_networks\LFR1\networ_LFR1_Om6.dat');
LFR1_Om6_Com = dlmread('..\datasets\binary_networks\LFR1\community_LFR1_Om6.dat');
LFR1_Om6_Com = LFR1_Om6_Com(:,2:end);
nodNo = max(LFR1_Om6_Net(:));

NMIvec_LFR16 = zeros(1,3);
for l1 = 3:5
    CPM_LFR16 = dlmread(['..\datasets\binary_networks\LFR1\networ_LFR1_Om6.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR16] = comm2nod_MembMat(CPM_LFR16);
    NMIvec_LFR16(l1) = NMI_calc(commCelArrMaker(LFR1_Om6_Com),commCelArrMaker(nodMembMat_LFR16),nodNo);
end

CPM_NMIvec_LFR1(5) = max(NMIvec_LFR16);

[CPM_Fscore_LFR1(5),CPM_precision_LFR1(5),CPM_recall_LFR1(5)] = Fscore_Calc(LFR1_Om6_Com,nodMembMat_LFR16);

%% Considering synthetic dataset LFR2

CPM_NMIvec_LFR2 = zeros(1,5);
CPM_Fscore_LFR2 = zeros(1,5);
CPM_precision_LFR2 = zeros(1,5);
CPM_recall_LFR2 = zeros(1,5);

% LFR2 with Om=2
LFR2_Om2_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om2.dat');
LFR2_Om2_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om2.dat');
LFR2_Om2_Com = LFR2_Om2_Com(:,2:end);
nodNo = max(LFR2_Om2_Net(:));

NMIvec_LFR22 = zeros(1,3);
for l1 = 3:5
    CPM_LFR22 = dlmread(['..\datasets\binary_networks\LFR2\networ_LFR2_Om2.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR22] = comm2nod_MembMat(CPM_LFR22);
    NMIvec_LFR22(l1) = NMI_calc(commCelArrMaker(LFR2_Om2_Com),commCelArrMaker(nodMembMat_LFR22),nodNo);
end

CPM_NMIvec_LFR2(1) = max(NMIvec_LFR22);

[CPM_Fscore_LFR2(1),CPM_precision_LFR2(1),CPM_recall_LFR2(1)] = Fscore_Calc(LFR2_Om2_Com,nodMembMat_LFR22);

% LFR2 with Om=3
LFR2_Om3_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om3.dat');
LFR2_Om3_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om3.dat');
LFR2_Om3_Com = LFR2_Om3_Com(:,2:end);
nodNo = max(LFR2_Om3_Net(:));

NMIvec_LFR23 = zeros(1,3);
for l1 = 3:5
    CPM_LFR23 = dlmread(['..\datasets\binary_networks\LFR2\networ_LFR2_Om3.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR23] = comm2nod_MembMat(CPM_LFR23);
    NMIvec_LFR23(l1) = NMI_calc(commCelArrMaker(LFR2_Om3_Com),commCelArrMaker(nodMembMat_LFR23),nodNo);
end

CPM_NMIvec_LFR2(2) = max(NMIvec_LFR23);

[CPM_Fscore_LFR2(2),CPM_precision_LFR2(2),CPM_recall_LFR2(2)] = Fscore_Calc(LFR2_Om3_Com,nodMembMat_LFR23);

% LFR2 with Om=4
LFR2_Om4_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om4.dat');
LFR2_Om4_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om4.dat');
LFR2_Om4_Com = LFR2_Om4_Com(:,2:end);
nodNo = max(LFR2_Om4_Net(:));

NMIvec_LFR24 = zeros(1,3);
for l1 = 3:5
    CPM_LFR24 = dlmread(['..\datasets\binary_networks\LFR2\networ_LFR2_Om4.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR24] = comm2nod_MembMat(CPM_LFR24);
    NMIvec_LFR24(l1) = NMI_calc(commCelArrMaker(LFR2_Om4_Com),commCelArrMaker(nodMembMat_LFR24),nodNo);
end

CPM_NMIvec_LFR2(3) = max(NMIvec_LFR24);

[CPM_Fscore_LFR2(3),CPM_precision_LFR2(3),CPM_recall_LFR2(3)] = Fscore_Calc(LFR2_Om4_Com,nodMembMat_LFR24);

% LFR2 with Om=5
LFR2_Om5_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om5.dat');
LFR2_Om5_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om5.dat');
LFR2_Om5_Com = LFR2_Om5_Com(:,2:end);
nodNo = max(LFR2_Om5_Net(:));

NMIvec_LFR25 = zeros(1,3);
for l1 = 3:5
    CPM_LFR25 = dlmread(['..\datasets\binary_networks\LFR2\networ_LFR2_Om5.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR25] = comm2nod_MembMat(CPM_LFR25);
    NMIvec_LFR25(l1) = NMI_calc(commCelArrMaker(LFR2_Om5_Com),commCelArrMaker(nodMembMat_LFR25),nodNo);
end

CPM_NMIvec_LFR2(4) = max(NMIvec_LFR25);

[CPM_Fscore_LFR2(4),CPM_precision_LFR2(4),CPM_recall_LFR2(4)] = Fscore_Calc(LFR2_Om5_Com,nodMembMat_LFR25);

% LFR2 with Om=6
LFR2_Om6_Net = load('..\datasets\binary_networks\LFR2\networ_LFR2_Om6.dat');
LFR2_Om6_Com = dlmread('..\datasets\binary_networks\LFR2\community_LFR2_Om6.dat');
LFR2_Om6_Com = LFR2_Om6_Com(:,2:end);
nodNo = max(LFR2_Om6_Net(:));

NMIvec_LFR26 = zeros(1,3);
for l1 = 3:5
    CPM_LFR26 = dlmread(['..\datasets\binary_networks\LFR2\networ_LFR2_Om6.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR26] = comm2nod_MembMat(CPM_LFR26);
    NMIvec_LFR26(l1) = NMI_calc(commCelArrMaker(LFR2_Om6_Com),commCelArrMaker(nodMembMat_LFR26),nodNo);
end

CPM_NMIvec_LFR2(5) = max(NMIvec_LFR26);

[CPM_Fscore_LFR2(5),CPM_precision_LFR2(5),CPM_recall_LFR2(5)] = Fscore_Calc(LFR2_Om6_Com,nodMembMat_LFR26);

%% Considering synthetic dataset LFR3

CPM_NMIvec_LFR3 = zeros(1,5);
CPM_Fscore_LFR3 = zeros(1,5);
CPM_precision_LFR3 = zeros(1,5);
CPM_recall_LFR3 = zeros(1,5);

% LFR3 with Om=2
LFR3_Om2_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om2.dat');
LFR3_Om2_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om2.dat');
LFR3_Om2_Com = LFR3_Om2_Com(:,2:end);
nodNo = max(LFR3_Om2_Net(:));

NMIvec_LFR32 = zeros(1,3);
for l1 = 3:5
    CPM_LFR32 = dlmread(['..\datasets\binary_networks\LFR3\network_LFR3_Om2.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR32] = comm2nod_MembMat(CPM_LFR32);
    NMIvec_LFR32(l1) = NMI_calc(commCelArrMaker(LFR3_Om2_Com),commCelArrMaker(nodMembMat_LFR32),nodNo);
end

CPM_NMIvec_LFR3(1) = max(NMIvec_LFR32);

[CPM_Fscore_LFR3(1),CPM_precision_LFR3(1),CPM_recall_LFR3(1)] = Fscore_Calc(LFR3_Om2_Com,nodMembMat_LFR32);

% LFR3 with Om=3
LFR3_Om3_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om3.dat');
LFR3_Om3_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om3.dat');
LFR3_Om3_Com = LFR3_Om3_Com(:,2:end);
nodNo = max(LFR3_Om3_Net(:));

NMIvec_LFR33 = zeros(1,3);
for l1 = 3:5
    CPM_LFR33 = dlmread(['..\datasets\binary_networks\LFR3\network_LFR3_Om3.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR33] = comm2nod_MembMat(CPM_LFR33);
    NMIvec_LFR33(l1) = NMI_calc(commCelArrMaker(LFR3_Om3_Com),commCelArrMaker(nodMembMat_LFR33),nodNo);
end

CPM_NMIvec_LFR3(2) = max(NMIvec_LFR33);

[CPM_Fscore_LFR3(2),CPM_precision_LFR3(2),CPM_recall_LFR3(2)] = Fscore_Calc(LFR3_Om3_Com,nodMembMat_LFR33);

% LFR3 with Om=4
LFR3_Om4_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om4.dat');
LFR3_Om4_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om4.dat');
LFR3_Om4_Com = LFR3_Om4_Com(:,2:end);
nodNo = max(LFR3_Om4_Net(:));

NMIvec_LFR34 = zeros(1,3);
for l1 = 3:5
    CPM_LFR34 = dlmread(['..\datasets\binary_networks\LFR3\network_LFR3_Om4.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR34] = comm2nod_MembMat(CPM_LFR34);
    NMIvec_LFR34(l1) = NMI_calc(commCelArrMaker(LFR3_Om4_Com),commCelArrMaker(nodMembMat_LFR34),nodNo);
end

CPM_NMIvec_LFR3(3) = max(NMIvec_LFR34);

[CPM_Fscore_LFR3(3),CPM_precision_LFR3(3),CPM_recall_LFR3(3)] = Fscore_Calc(LFR3_Om4_Com,nodMembMat_LFR34);

% LFR3 with Om=5
LFR3_Om5_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om5.dat');
LFR3_Om5_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om5.dat');
LFR3_Om5_Com = LFR3_Om5_Com(:,2:end);
nodNo = max(LFR3_Om5_Net(:));

NMIvec_LFR35 = zeros(1,3);
for l1 = 3:5
    CPM_LFR35 = dlmread(['..\datasets\binary_networks\LFR3\network_LFR3_Om5.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR35] = comm2nod_MembMat(CPM_LFR35);
    NMIvec_LFR35(l1) = NMI_calc(commCelArrMaker(LFR3_Om5_Com),commCelArrMaker(nodMembMat_LFR35),nodNo);
end

CPM_NMIvec_LFR3(4) = max(NMIvec_LFR35);

[CPM_Fscore_LFR3(4),CPM_precision_LFR3(4),CPM_recall_LFR3(4)] = Fscore_Calc(LFR3_Om5_Com,nodMembMat_LFR35);

% LFR3 with Om=6
LFR3_Om6_Net = load('..\datasets\binary_networks\LFR3\network_LFR3_Om6.dat');
LFR3_Om6_Com = dlmread('..\datasets\binary_networks\LFR3\community_LFR3_Om6.dat');
LFR3_Om6_Com = LFR3_Om6_Com(:,2:end);
nodNo = max(LFR3_Om6_Net(:));

NMIvec_LFR36 = zeros(1,3);
for l1 = 3:5
    CPM_LFR36 = dlmread(['..\datasets\binary_networks\LFR3\network_LFR3_Om6.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR36] = comm2nod_MembMat(CPM_LFR36);
    NMIvec_LFR36(l1) = NMI_calc(commCelArrMaker(LFR3_Om6_Com),commCelArrMaker(nodMembMat_LFR36),nodNo);
end

CPM_NMIvec_LFR3(5) = max(NMIvec_LFR36);

[CPM_Fscore_LFR3(5),CPM_precision_LFR3(5),CPM_recall_LFR3(5)] = Fscore_Calc(LFR3_Om6_Com,nodMembMat_LFR36);

%% Considering synthetic dataset LFR4

CPM_NMIvec_LFR4 = zeros(1,5);
CPM_Fscore_LFR4 = zeros(1,5);
CPM_precision_LFR4 = zeros(1,5);
CPM_recall_LFR4 = zeros(1,5);

% LFR4 with Om=2
LFR4_Om2_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om2.dat');
LFR4_Om2_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om2.dat');
LFR4_Om2_Com = LFR4_Om2_Com(:,2:end);
nodNo = max(LFR4_Om2_Net(:));

NMIvec_LFR42 = zeros(1,3);
for l1 = 3:5
    CPM_LFR42 = dlmread(['..\datasets\binary_networks\LFR4\network_LFR4_Om2.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR42] = comm2nod_MembMat(CPM_LFR42);
    NMIvec_LFR42(l1) = NMI_calc(commCelArrMaker(LFR4_Om2_Com),commCelArrMaker(nodMembMat_LFR42),nodNo);
end

CPM_NMIvec_LFR4(1) = max(NMIvec_LFR42);

[CPM_Fscore_LFR4(1),CPM_precision_LFR4(1),CPM_recall_LFR4(1)] = Fscore_Calc(LFR4_Om2_Com,nodMembMat_LFR42);

% LFR4 with Om=3
LFR4_Om3_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om3.dat');
LFR4_Om3_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om3.dat');
LFR4_Om3_Com = LFR4_Om3_Com(:,2:end);
nodNo = max(LFR4_Om3_Net(:));

NMIvec_LFR43 = zeros(1,3);
for l1 = 3:5
    CPM_LFR43 = dlmread(['..\datasets\binary_networks\LFR4\network_LFR4_Om3.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR43] = comm2nod_MembMat(CPM_LFR43);
    NMIvec_LFR43(l1) = NMI_calc(commCelArrMaker(LFR4_Om3_Com),commCelArrMaker(nodMembMat_LFR43),nodNo);
end

CPM_NMIvec_LFR4(2) = max(NMIvec_LFR43);

[CPM_Fscore_LFR4(2),CPM_precision_LFR4(2),CPM_recall_LFR4(2)] = Fscore_Calc(LFR4_Om3_Com,nodMembMat_LFR43);

% LFR4 with Om=4
LFR4_Om4_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om4.dat');
LFR4_Om4_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om4.dat');
LFR4_Om4_Com = LFR4_Om4_Com(:,2:end);
nodNo = max(LFR4_Om4_Net(:));

NMIvec_LFR44 = zeros(1,3);
for l1 = 3:5
    CPM_LFR44 = dlmread(['..\datasets\binary_networks\LFR4\network_LFR4_Om4.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR44] = comm2nod_MembMat(CPM_LFR44);
    NMIvec_LFR44(l1) = NMI_calc(commCelArrMaker(LFR4_Om4_Com),commCelArrMaker(nodMembMat_LFR44),nodNo);
end

CPM_NMIvec_LFR4(3) = max(NMIvec_LFR44);

[CPM_Fscore_LFR4(3),CPM_precision_LFR4(3),CPM_recall_LFR4(3)] = Fscore_Calc(LFR4_Om4_Com,nodMembMat_LFR44);

% LFR4 with Om=5
LFR4_Om5_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om5.dat');
LFR4_Om5_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om5.dat');
LFR4_Om5_Com = LFR4_Om5_Com(:,2:end);
nodNo = max(LFR4_Om5_Net(:));

NMIvec_LFR45 = zeros(1,3);
for l1 = 3:5
    CPM_LFR45 = dlmread(['..\datasets\binary_networks\LFR4\network_LFR4_Om5.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR45] = comm2nod_MembMat(CPM_LFR45);
    NMIvec_LFR45(l1) = NMI_calc(commCelArrMaker(LFR4_Om5_Com),commCelArrMaker(nodMembMat_LFR45),nodNo);
end

CPM_NMIvec_LFR4(4) = max(NMIvec_LFR45);

[CPM_Fscore_LFR4(4),CPM_precision_LFR4(4),CPM_recall_LFR4(4)] = Fscore_Calc(LFR4_Om5_Com,nodMembMat_LFR45);

% LFR4 with Om=6
LFR4_Om6_Net = load('..\datasets\binary_networks\LFR4\network_LFR4_Om6.dat');
LFR4_Om6_Com = dlmread('..\datasets\binary_networks\LFR4\community_LFR4_Om6.dat');
LFR4_Om6_Com = LFR4_Om6_Com(:,2:end);
nodNo = max(LFR4_Om6_Net(:));

NMIvec_LFR46 = zeros(1,3);
for l1 = 3:5
    CPM_LFR46 = dlmread(['..\datasets\binary_networks\LFR4\network_LFR4_Om6.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR46] = comm2nod_MembMat(CPM_LFR46);
    NMIvec_LFR46(l1) = NMI_calc(commCelArrMaker(LFR4_Om6_Com),commCelArrMaker(nodMembMat_LFR46),nodNo);
end

CPM_NMIvec_LFR4(5) = max(NMIvec_LFR46);

[CPM_Fscore_LFR4(5),CPM_precision_LFR4(5),CPM_recall_LFR4(5)] = Fscore_Calc(LFR4_Om6_Com,nodMembMat_LFR46);

%% Considering synthetic dataset LFR5

CPM_NMIvec_LFR5 = zeros(1,5);
CPM_Fscore_LFR5 = zeros(1,5);
CPM_precision_LFR5 = zeros(1,5);
CPM_recall_LFR5 = zeros(1,5);

% LFR5 with Om=2
LFR5_Om2_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om2.dat');
LFR5_Om2_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om2.dat');
LFR5_Om2_Com = LFR5_Om2_Com(:,2:end);
nodNo = max(LFR5_Om2_Net(:));

NMIvec_LFR52 = zeros(1,3);
for l1 = 3:5
    CPM_LFR52 = dlmread(['..\datasets\binary_networks\LFR5\network_LFR5_Om2.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR52] = comm2nod_MembMat(CPM_LFR52);
    NMIvec_LFR52(l1) = NMI_calc(commCelArrMaker(LFR5_Om2_Com),commCelArrMaker(nodMembMat_LFR52),nodNo);
end

CPM_NMIvec_LFR5(1) = max(NMIvec_LFR52);

[CPM_Fscore_LFR5(1),CPM_precision_LFR5(1),CPM_recall_LFR5(1)] = Fscore_Calc(LFR5_Om2_Com,nodMembMat_LFR52);

% LFR5 with Om=3
LFR5_Om3_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om3.dat');
LFR5_Om3_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om3.dat');
LFR5_Om3_Com = LFR5_Om3_Com(:,2:end);
nodNo = max(LFR5_Om3_Net(:));

NMIvec_LFR53 = zeros(1,3);
for l1 = 3:5
    CPM_LFR53 = dlmread(['..\datasets\binary_networks\LFR5\network_LFR5_Om3.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR53] = comm2nod_MembMat(CPM_LFR53);
    NMIvec_LFR53(l1) = NMI_calc(commCelArrMaker(LFR5_Om3_Com),commCelArrMaker(nodMembMat_LFR53),nodNo);
end

CPM_NMIvec_LFR5(2) = max(NMIvec_LFR53);

[CPM_Fscore_LFR5(2),CPM_precision_LFR5(2),CPM_recall_LFR5(2)] = Fscore_Calc(LFR5_Om3_Com,nodMembMat_LFR53);

% LFR5 with Om=4
LFR5_Om4_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om4.dat');
LFR5_Om4_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om4.dat');
LFR5_Om4_Com = LFR5_Om4_Com(:,2:end);
nodNo = max(LFR5_Om4_Net(:));

NMIvec_LFR54 = zeros(1,3);
for l1 = 3:5
    CPM_LFR54 = dlmread(['..\datasets\binary_networks\LFR5\network_LFR5_Om4.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR54] = comm2nod_MembMat(CPM_LFR54);
    NMIvec_LFR54(l1) = NMI_calc(commCelArrMaker(LFR5_Om4_Com),commCelArrMaker(nodMembMat_LFR54),nodNo);
end

CPM_NMIvec_LFR5(3) = max(NMIvec_LFR54);

[CPM_Fscore_LFR5(3),CPM_precision_LFR5(3),CPM_recall_LFR5(3)] = Fscore_Calc(LFR5_Om4_Com,nodMembMat_LFR54);

% LFR5 with Om=5
LFR5_Om5_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om5.dat');
LFR5_Om5_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om5.dat');
LFR5_Om5_Com = LFR5_Om5_Com(:,2:end);
nodNo = max(LFR5_Om5_Net(:));

NMIvec_LFR55 = zeros(1,3);
for l1 = 3:5
    CPM_LFR55 = dlmread(['..\datasets\binary_networks\LFR5\network_LFR5_Om5.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR55] = comm2nod_MembMat(CPM_LFR55);
    NMIvec_LFR55(l1) = NMI_calc(commCelArrMaker(LFR5_Om5_Com),commCelArrMaker(nodMembMat_LFR55),nodNo);
end

CPM_NMIvec_LFR5(4) = max(NMIvec_LFR55);

[CPM_Fscore_LFR5(4),CPM_precision_LFR5(4),CPM_recall_LFR5(4)] = Fscore_Calc(LFR5_Om5_Com,nodMembMat_LFR55);

% LFR5 with Om=6
LFR5_Om6_Net = load('..\datasets\binary_networks\LFR5\network_LFR5_Om6.dat');
LFR5_Om6_Com = dlmread('..\datasets\binary_networks\LFR5\community_LFR5_Om6.dat');
LFR5_Om6_Com = LFR5_Om6_Com(:,2:end);
nodNo = max(LFR5_Om6_Net(:));

NMIvec_LFR56 = zeros(1,3);
for l1 = 3:5
    CPM_LFR56 = dlmread(['..\datasets\binary_networks\LFR5\network_LFR5_Om6.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR56] = comm2nod_MembMat(CPM_LFR56);
    NMIvec_LFR56(l1) = NMI_calc(commCelArrMaker(LFR5_Om6_Com),commCelArrMaker(nodMembMat_LFR56),nodNo);
end

CPM_NMIvec_LFR5(5) = max(NMIvec_LFR56);

[CPM_Fscore_LFR5(5),CPM_precision_LFR5(5),CPM_recall_LFR5(5)] = Fscore_Calc(LFR5_Om6_Com,nodMembMat_LFR56);

%% Considering synthetic dataset LFR6

CPM_NMIvec_LFR6 = zeros(1,5);
CPM_Fscore_LFR6 = zeros(1,5);
CPM_precision_LFR6 = zeros(1,5);
CPM_recall_LFR6 = zeros(1,5);

% LFR6 with Om=2
LFR6_Om2_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om2.dat');
LFR6_Om2_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om2.dat');
LFR6_Om2_Com = LFR6_Om2_Com(:,2:end);
nodNo = max(LFR6_Om2_Net(:));

NMIvec_LFR62 = zeros(1,3);
for l1 = 3:5
    CPM_LFR62 = dlmread(['..\datasets\binary_networks\LFR6\network_LFR6_Om2.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR62] = comm2nod_MembMat(CPM_LFR62);
    NMIvec_LFR62(l1) = NMI_calc(commCelArrMaker(LFR6_Om2_Com),commCelArrMaker(nodMembMat_LFR62),nodNo);
end

CPM_NMIvec_LFR6(1) = max(NMIvec_LFR62);

[CPM_Fscore_LFR6(1),CPM_precision_LFR6(1),CPM_recall_LFR6(1)] = Fscore_Calc(LFR6_Om2_Com,nodMembMat_LFR62);

% LFR6 with Om=3
LFR6_Om3_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om3.dat');
LFR6_Om3_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om3.dat');
LFR6_Om3_Com = LFR6_Om3_Com(:,2:end);
nodNo = max(LFR6_Om3_Net(:));

NMIvec_LFR63 = zeros(1,3);
for l1 = 3:5
    CPM_LFR63 = dlmread(['..\datasets\binary_networks\LFR6\network_LFR6_Om3.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR63] = comm2nod_MembMat(CPM_LFR63);
    NMIvec_LFR63(l1) = NMI_calc(commCelArrMaker(LFR6_Om3_Com),commCelArrMaker(nodMembMat_LFR63),nodNo);
end

CPM_NMIvec_LFR6(2) = max(NMIvec_LFR63);

[CPM_Fscore_LFR6(2),CPM_precision_LFR6(2),CPM_recall_LFR6(2)] = Fscore_Calc(LFR6_Om3_Com,nodMembMat_LFR63);

% LFR6 with Om=4
LFR6_Om4_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om4.dat');
LFR6_Om4_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om4.dat');
LFR6_Om4_Com = LFR6_Om4_Com(:,2:end);
nodNo = max(LFR6_Om4_Net(:));

NMIvec_LFR64 = zeros(1,3);
for l1 = 3:5
    CPM_LFR64 = dlmread(['..\datasets\binary_networks\LFR6\network_LFR6_Om4.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR64] = comm2nod_MembMat(CPM_LFR64);
    NMIvec_LFR64(l1) = NMI_calc(commCelArrMaker(LFR6_Om4_Com),commCelArrMaker(nodMembMat_LFR64),nodNo);
end

CPM_NMIvec_LFR6(3) = max(NMIvec_LFR64);

[CPM_Fscore_LFR6(3),CPM_precision_LFR6(3),CPM_recall_LFR6(3)] = Fscore_Calc(LFR6_Om4_Com,nodMembMat_LFR64);

% LFR6 with Om=5
LFR6_Om5_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om5.dat');
LFR6_Om5_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om5.dat');
LFR6_Om5_Com = LFR6_Om5_Com(:,2:end);
nodNo = max(LFR6_Om5_Net(:));

NMIvec_LFR65 = zeros(1,3);
for l1 = 3:5
    CPM_LFR65 = dlmread(['..\datasets\binary_networks\LFR6\network_LFR6_Om5.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR65] = comm2nod_MembMat(CPM_LFR65);
    NMIvec_LFR65(l1) = NMI_calc(commCelArrMaker(LFR6_Om5_Com),commCelArrMaker(nodMembMat_LFR65),nodNo);
end

CPM_NMIvec_LFR6(4) = max(NMIvec_LFR65);

[CPM_Fscore_LFR6(4),CPM_precision_LFR6(4),CPM_recall_LFR6(4)] = Fscore_Calc(LFR6_Om5_Com,nodMembMat_LFR65);

% LFR6 with Om=6
LFR6_Om6_Net = load('..\datasets\binary_networks\LFR6\network_LFR6_Om6.dat');
LFR6_Om6_Com = dlmread('..\datasets\binary_networks\LFR6\community_LFR6_Om6.dat');
LFR6_Om6_Com = LFR6_Om6_Com(:,2:end);
nodNo = max(LFR6_Om6_Net(:));

NMIvec_LFR66 = zeros(1,3);
for l1 = 3:5
    CPM_LFR66 = dlmread(['..\datasets\binary_networks\LFR6\network_LFR6_Om6.dat_files_0.0_w_0.0\k=', ... 
        num2str(l1),'\communities'],' ',7,1);
    [nodMembMat_LFR66] = comm2nod_MembMat(CPM_LFR66);
    NMIvec_LFR66(l1) = NMI_calc(commCelArrMaker(LFR6_Om6_Com),commCelArrMaker(nodMembMat_LFR66),nodNo);
end

CPM_NMIvec_LFR6(5) = max(NMIvec_LFR66);

[CPM_Fscore_LFR6(5),CPM_precision_LFR6(5),CPM_recall_LFR6(5)] = Fscore_Calc(LFR6_Om6_Com,nodMembMat_LFR66);

