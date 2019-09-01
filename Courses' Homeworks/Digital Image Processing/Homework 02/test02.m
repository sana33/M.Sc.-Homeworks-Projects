% img1_man = imread('./inputs/man.jpg');
% % figure(7);
% % imshow(img1_man);
% % drawnow;
% % 
% % h = figure(8);
% % imhist(img1_man,256);
% % title('256-bin Histogram','FontName','Times New Roman','FontSize',11.5);
% % drawnow;
% % saveas(h,['./output/','man_hist_part_e_before.bmp'],'jpg');
% 
% % Part f
% img2_man = img1_man;
% 
% R = max(img1_man(:));
% d = (255/log(double(1+R)));
% for i = 1: size(img1_man,1)
%     for j = 1:size(img1_man,2)
%         
%         pixel = img1_man(i,j);
%         
%         img2_man(i,j) = d*log(double(1+double(pixel)));
%     
%     end
% end
% 
% h=figure(9);
% imshow(img2_man);
% title('Logarithmic Stretching Way','FontName','Times New Roman','FontSize',11.5);
% drawnow;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Histogram Equalization

% clc
% A=input('please enter image adress: ','s');
% GIm=imread(A);
% [x, y ,m]=size(GIm);
% if m==3
%     GIm=rgb2gray(GIm);
% end
% inf=whos('GIm');
% Isize=0;
% if inf.class=='uint8'
%     Isize=256;
%     else if inf.class=='uint68'
%         Isize=65565;
%         end
% end
% HIm=uint8(zeros(size(GIm,1),size(GIm,2)));
% freq=zeros(256,1);
% probf=zeros(256,1);
% probc=zeros(256,1);
% cum=zeros(256,1);
% output=zeros(256,1);
% freq=imhist(GIm);%histogram
% sum=0;
% no_bins=255;
% probc=cumsum(freq)/numel(GIm);
% output=round(probc*no_bins);
% HIm(:)=output(GIm(:)+1);
% %show
% figure
% subplot(2,2,1)
% imshow(GIm);
% title('original image');
% subplot(2,2,2)
% imshow(HIm);
% title('Image equalization');
% subplot(2,2,3)
% imhist(GIm);
% title('origina');
% subplot(2,2,4)
% imhist(HIm);
% title('histogram equalization');
% figure
% subplot(2,2,1)
% imshow(histeq(GIm));
% title('matlab equalization');
% subplot(2,2,2)
% imshow(HIm);
% title('my code equalization');
% subplot(2,2,3)
% imhist(histeq(GIm));
% title('hist matlab eq');
% subplot(2,2,4)
% imhist(HIm);
% title('hist my code eq');
% figure
% subplot(2,2,1)
% imshow(GIm);
% title('origina');
% subplot(2,2,2)
% imshow(HIm);
% title('Image equalization');
% x=(1:Isize);
% subplot(2,2,3)
% plot(x,output);
% title('transform function');
% subplot(2,2,4)
% plot(x,freq);
% title('transform function');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Image Detection
face1 = imread('inputs/face1.pgm');
eye1 = imread('inputs\eye1.pgm');
mouth1 = imread('inputs\mouth1.pgm');
nose1 = imread('inputs\nose1.pgm');

face2 = imread('inputs/face2.pgm');
eye2 = imread('inputs\eye2.pgm');
mouth2 = imread('inputs\mouth2.pgm');
nose2 = imread('inputs\nose2.pgm');

% imshowpair(face1,nose1,'montage')
c = normxcorr2(nose1,face1); figure(1), surf(c), shading flat 
figure(2); imshowpair(face1,nose1,'montage')
[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(nose1,1);
xoffSet = xpeak-size(nose1,2); 
hAx = axes; 
imshow(face1, 'Parent', hAx); 
imrect(hAx, [xoffSet, yoffSet, size(nose1,2), size(nose1,1)]);

