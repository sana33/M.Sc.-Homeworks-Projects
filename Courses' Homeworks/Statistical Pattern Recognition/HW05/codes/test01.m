img01 = reshape(V(:,12),50,[]);
% imshow(uint8(reshape(Yts(randi(size(Yts,1)),:),50,[])));

c = double(min(img01(:))); d = double(max(img01(:)));
b = 255; a = 0;
img01_strch01 = (double(img01) - c) * (b - a) / (d - c) + a;
% img01_strch01 = cast(img01_strch01, 'like', img01);
img01_strch01 = cast(img01_strch01,'uint8');
figure; 
% subplot(1,2,1);
imshow(img01_strch01); title('Q01-Part b; Image after stretching contrast');
% subplot(1,2,2);
% imhist(img01_strch01, 256); title('Q01-Part b; Image Histogram Stretched');
