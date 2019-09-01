clc; warning off

%% considering effectiveness test - evaluation of approximation
load('soybean-small.mat');

ITBSP_OSidx = cell(10,1);
ITBSP_Jopt = zeros(10,1);
for o = 1:10
    [~,ITBSP_OSidx{o,1},ITBSP_Jopt(o,1),~,UO] = ITB_SP(soybeanSm,o,1);
end
soybeanSm_ITBSP = struct('ITBSP_OSidx',ITBSP_OSidx,'ITBSP_Jopt',ITBSP_Jopt,'UO',UO);

ITBSS_OSidx = cell(10,1);
ITBSS_Jopt = zeros(10,1);
for o = 1:10
    [~,ITBSS_OSidx{o,1},ITBSS_Jopt(o,1),~,UO] = ITB_SS(soybeanSm,o,1);
end
soybeanSm_ITBSS = struct('ITBSS_OSidx',ITBSS_OSidx,'ITBSS_Jopt',ITBSS_Jopt,'UO',UO);

save('exp01_soybeanSm_res.mat','soybeanSm_ITBSP','soybeanSm_ITBSS');

fprintf('\n');
fprintf('----------------------------------------------------------------------------------------------------------------\n');
fprintf('o\tITB-SP\t\t\t\t\t\t\t\t\t\tJx(Y,o)\t\tITB-SS\t\t\t\t\t\t\t\t\t\tJx(Y,o)\t\n');
fprintf('----------------------------------------------------------------------------------------------------------------\n');
for k1 = 1:10
    bsT = '';
    for k2=1:12-k1; bsT=[bsT,'\t']; end
    fprintf(['%d:\t%s',bsT,'%0.3f\t\t%s',bsT,'%0.3f\t\n'], ...
        k1,num2str(ITBSP_OSidx{k1,1}'),ITBSP_Jopt(k1),num2str(ITBSS_OSidx{k1,1}'),ITBSS_Jopt(k1));
end
fprintf('----------------------------------------------------------------------------------------------------------------\n');
