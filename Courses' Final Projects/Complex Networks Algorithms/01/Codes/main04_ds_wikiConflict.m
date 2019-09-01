clear; close all; clc; warning off

% Loading dataset ds_caHepPh
ds_wikiConflict = load('ds_wikiConflict.mat'); ds_wikiConflict = ds_wikiConflict.ds_wikiConflict; ds_wikiConflict = double(ds_wikiConflict);
ds_wikiConflict = [ds_wikiConflict; [ds_wikiConflict(:,2), ds_wikiConflict(:,1), ds_wikiConflict(:,3:4)]];
ssNo = 31;
% evolvSpeed = [1 3 7 10];
evolvSpeed = [1 5 20 25];
ssArray = cell(1,length(evolvSpeed));
msConvType = 'minute';
for c1 = 1:length(evolvSpeed)
    ssArray{c1} = snapShot_create(ds_wikiConflict, ssNo, evolvSpeed(c1), msConvType);
end

nodesNo = max([ds_wikiConflict(:,1); ds_wikiConflict(:,2)]);
commIndsArr = cell(ssNo, length(evolvSpeed));
commArray = cell(ssNo, length(evolvSpeed));
modulArrProp = zeros(ssNo, length(evolvSpeed));
modulArrTrad = zeros(ssNo, length(evolvSpeed));

metricType = 'symmetric'; recurr = 0; selfLoop = 1; ph1SC = 3; passSC = 2;
blondelArgs = struct('metricType', metricType, 'recurr', recurr, ...
    'selfLoop', selfLoop, 'ph1SC', ph1SC, 'passSC', passSC);

for c1 = 1:length(evolvSpeed)
    edgesNo = length(ssArray{c1}{1});
    A = sparse(ssArray{c1}{1}(:,1),ssArray{c1}{1}(:,2),ssArray{c1}{1}(:,3),nodesNo,nodesNo);
    [~, commInds] = BlondelSparse(A, metricType, recurr, selfLoop, ph1SC, passSC);
    commIndsArr{1,c1} = commInds;
    commArray{1,c1} = commArrayMaker(commInds);
    modulArrProp(1,c1) = modulCalc(A, 'symmetric', commArray{1,c1});
    modulArrTrad(1,c1) = modulArrProp(1,c1);
end

for c1 = 1:length(evolvSpeed)
    for c2 = 2:ssNo
        t0_A = sparse(ssArray{c1}{c2-1}(:,1),ssArray{c1}{c2-1}(:,2),ssArray{c1}{c2-1}(:,3),nodesNo,nodesNo);
        t0_dv = sum(t0_A);
        t1_A = sparse(ssArray{c1}{c2-1}(:,1),ssArray{c1}{c2-1}(:,2),ssArray{c1}{c2-1}(:,3),nodesNo,nodesNo);
        t1_dv = sum(t1_A);
        [~, commIndsArr{c2,c1}] = smallNet_create(t0_dv, t1_dv, t1_A, commIndsArr{c2-1,c1}, blondelArgs);
        commArray{c2,c1} = commArrayMaker(commIndsArr{c2,c1});
        modulArrProp(c2,c1) = modulCalc(t1_A, 'symmetric', commArray{c2,c1});
        [~, commIndsTrad] = BlondelSparse(t1_A, metricType, recurr, selfLoop, ph1SC, passSC);
        commArrTrad = commArrayMaker(commIndsTrad);
        modulArrTrad(c2,c1) = modulCalc(t1_A, 'symmetric', commArrTrad);
    end
end

%% Plotting final figures
figure;
plot(1:ssNo,modulArrProp(:,1),'b',1:5:ssNo,modulArrProp(1:5:ssNo,1),'bo', ...
    1:ssNo,modulArrTrad(:,1),'g',1:5:ssNo,modulArrTrad(1:5:ssNo,1),'gs'); xlim([1 31]); ylim([0 1]);
xlabel(['SnapShots: 31; EvolvSpeed: ',num2str(evolvSpeed(1))],'FontSize',12,'FontWeight','bold','Color','r');
ylabel('Modularity','FontSize',12,'FontWeight','bold','Color','r');
title('wikiConflict Dataset Results Using Both Proposed & Traditional Methods');

figure;
plot(1:ssNo,modulArrProp(:,2),'b',1:5:ssNo,modulArrProp(1:5:ssNo,2),'bo', ...
    1:ssNo,modulArrTrad(:,2),'g',1:5:ssNo,modulArrTrad(1:5:ssNo,2),'gs'); xlim([1 31]); ylim([0 1]);
xlabel(['SnapShots: 31; EvolvSpeed: ',num2str(evolvSpeed(2))],'FontSize',12,'FontWeight','bold','Color','r');
ylabel('Modularity','FontSize',12,'FontWeight','bold','Color','r');
title('wikiConflict Dataset Results Using Both Proposed & Traditional Methods');

figure;
plot(1:ssNo,modulArrProp(:,3),'b',1:5:ssNo,modulArrProp(1:5:ssNo,3),'bo', ...
    1:ssNo,modulArrTrad(:,3),'g',1:5:ssNo,modulArrTrad(1:5:ssNo,3),'gs'); xlim([1 31]); ylim([0 1]);
xlabel(['SnapShots: 31; EvolvSpeed: ',num2str(evolvSpeed(3))],'FontSize',12,'FontWeight','bold','Color','r');
ylabel('Modularity','FontSize',12,'FontWeight','bold','Color','r');
title('wikiConflict Dataset Results Using Both Proposed & Traditional Methods');

figure;
plot(1:ssNo,modulArrProp(:,4),'b',1:5:ssNo,modulArrProp(1:5:ssNo,4),'bo', ...
    1:ssNo,modulArrTrad(:,4),'g',1:5:ssNo,modulArrTrad(1:5:ssNo,4),'gs'); xlim([1 31]); ylim([0 1]);
xlabel(['SnapShots: 31; EvolvSpeed: ',num2str(evolvSpeed(4))],'FontSize',12,'FontWeight','bold','Color','r');
ylabel('Modularity','FontSize',12,'FontWeight','bold','Color','r');
title('wikiConflict Dataset Results Using Both Proposed & Traditional Methods');
