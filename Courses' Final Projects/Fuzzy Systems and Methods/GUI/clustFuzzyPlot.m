function [] = clustFuzzyPlot(W,X,Colors,h)

m = size(X,1);
k = size(W,1);
[~,idx] = sort(W,'descend');
labels = idx(1,:);
cents = zeros(m,k);
for c1 = 1:k
    cents(:,c1) = mean(X(:,labels==c1),2);
end

axes(h);
gscatter(X(1,:),X(2,:),labels,Colors); grid on; hold on;
for e1 = 1:k
    plot(cents(1,e1),cents(2,e1),'Marker','s','MarkerFaceColor',Colors(e1,:), ...
        'MarkerEdgeColor','k','MarkerSize',7,'LineWidth',1.5);
end
hold off;
pause(.01);

end