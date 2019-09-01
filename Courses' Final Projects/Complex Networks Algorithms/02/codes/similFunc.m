function [sim1,sim2,simF] = similFunc(A,v,w,gamma)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

sim1 = full(sum(A(v,:) & A(w,:))/(sum(A(v,:) | A(w,:))+2-2*A(v,w)));
sim1(isinf(sim1)) = 0; sim1(isnan(sim1)) = 0;

intSect = find(A(v,:) & A(w,:));
EcommSz = full(sum(sum(A(intSect,intSect))));
sim2 = full((2*EcommSz)/(sum(A(v,:) & A(w,:))*(sum(A(v,:) & A(w,:))-1)));
sim2(isinf(sim2)) = 0; sim2(isnan(sim2)) = 0;

simF = full(gamma*sim1 + (1-gamma)*sim2);

end

