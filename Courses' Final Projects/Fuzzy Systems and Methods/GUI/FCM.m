function [V,W,hFP] = FCM(X,k,alpha,stopCond,maxIter,hFP,hObject,handles)

Colors = hsv(k);
[m,n] = size(X);
W = rand(k,n);
D = zeros(k,n);
V = zeros(m,k);

axes(hFP);
t = 1;
while true
    W_Temp = W;
    for c1 = 1:k
        V(:,c1) = sum(repmat(W(c1,:).^alpha,m,1).*X,2)/sum(W(c1,:).^alpha);
    end
    for c1 = 1:k
        D(c1,:) = sqrt(sum((X-repmat(V(:,c1),1,n)).^2));
    end
    W = ((D.^(2/(alpha-1))).*repmat(sum((1./D).^(2/(alpha-1))),k,1)).^-1;
    [rowDz,colDz] = find(D==0);
    idxDz = sub2ind(size(D),rowDz,colDz);
    W(:,colDz) = 0;
    W(idxDz) = 1;
    
    clustFuzzyPlot(W,X,Colors,hFP);
    
%     if sqrt(sum(sum((W-W_Temp).^2)))<stopCond || t>=maxIter
    if all(all((W-W_Temp)<stopCond)) || t>=maxIter
        break;
    else
        set(handles.iterNoFCM_statText,'String',t);
        t = t+1;
    end
end

guidata(hObject,handles);
end

