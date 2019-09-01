function [m_f,M_inv,W,hFP] = GK_clust(X,k,alpha,stopCond,maxIter,rho,hFP,hObject,handles)

Colors = hsv(k);
[m,n] = size(X);
W = rand(k,n);
D = zeros(k,n);
m_f = zeros(m,k);
P_f = zeros(m,m,k);
M_inv = zeros(m,m,k);
for c1 = 1:k
    m_f(:,c1) = sum(repmat(W(c1,:).^alpha,m,1).*X,2)/sum(W(c1,:).^alpha);
%     m_f(:,c1) = [0; 0];
    P_f(:,:,c1) = (repmat(W(c1,:),m,1).*(X-repmat(m_f(:,c1),1,n)))*transpose((X-repmat(m_f(:,c1),1,n)))./ ...
        sum(W(c1,:).^alpha);
    M_inv(:,:,c1) = P_f(:,:,c1)/((rho(c1)*det(P_f(:,:,c1)))^(1/m));
%     M_inv(:,:,c1) = inv(P_f(:,:,c1))/((rho(c1)*det(P_f(:,:,c1)))^(1/m));
end

axes(hFP);
t = 1;
while true
    W_Temp = W;
    for c1 = 1:k
        for c2 = 1:n
            D(c1,c2) = transpose(X(:,c2)-m_f(:,c1))*M_inv(:,:,c1)*(X(:,c2)-m_f(:,c1));
        end
    end
    W = ((D.^(1/(alpha-1))).*repmat(sum((1./D).^(1/(alpha-1))),k,1)).^-1;
    [rowDz,colDz] = find(D==0);
    idxDz = sub2ind(size(D),rowDz,colDz);
    W(:,colDz) = 0;
    W(idxDz) = 1;
    for c1 = 1:k
        m_f(:,c1) = sum(repmat(W(c1,:).^alpha,m,1).*X,2)/sum(W(c1,:).^alpha);
        P_f(:,:,c1) = (repmat(W(c1,:),m,1).*(X-repmat(m_f(:,c1),1,n)))*transpose((X-repmat(m_f(:,c1),1,n)))./ ...
            sum(W(c1,:).^alpha);
        M_inv(:,:,c1) = P_f(:,:,c1)/((rho(c1)*det(P_f(:,:,c1)))^(1/m));
%         M_inv(:,:,c1) = inv(P_f(:,:,c1))/((rho(c1)*det(P_f(:,:,c1)))^(1/m));
    end
    
    clustFuzzyPlot(W,X,Colors,hFP);
    
%     if sum(sum((W-W_Temp).^2))<stopCond || t>=maxIter
    if all(all((W-W_Temp)<stopCond)) || t>=maxIter
        break;
    else
        set(handles.iterNoGK_statText,'String',t);
        t = t+1;
    end
end

guidata(hObject,handles);
end

