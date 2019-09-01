warning off;

snakeImg = imread('inputs/snake.jpg');
filtersArray = cell(0);
nameArray = char('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p');

A = ones(3)./9; filtersArray{1} = A;
B = ones(3)./18; filtersArray{2} = B;
C = ones(3)./7; filtersArray{3} = C;
D = [-1 -1 -1; -1 9 -1; -1 -1 -1]; filtersArray{4} = D;
E = [-1 -1 -1; -1 18 -1; -1 -1 -1]; filtersArray{5} = E;
F = [0 -1 0; -1 5 -1; 0 -1 0]; filtersArray{6} = F;
G = [1 0 0; 0 0 0; 0 0 -1]; filtersArray{7} = G;
H = [0 0 -1; 0 0 0; 1 0 0]; filtersArray{8} = H;
I = [0 1 0; 0 0 0; 0 -1 0]; filtersArray{9} = I;
J = [0 0 0; -1 0 1; 0 0 0]; filtersArray{10} = J;
K = [1 1 1; 1 -8 1; 1 1 1]; filtersArray{11} = K;
L = [-1 -1 -1; 0 0 0; 1 1 1]; filtersArray{12} = L;
M = [-1 -1 -1; 0 1 0; 1 1 1]; filtersArray{13} = M;
N = [-1 0 0; 0 2 0; 0 0 -1]; filtersArray{14} = N;
O = [0 0 -1; 0 2 0; -1 0 0]; filtersArray{15} = O;
P = [0 1/3 0; 0 1/3 0; 0 1/3 0]; filtersArray{16} = P;

for c1 = 1:length(filtersArray)
    snakeFilt = imfilter(snakeImg, filtersArray{c1});
    figure; imshow(snakeFilt);
    imwrite(snakeFilt, sprintf('outputs/ex09_snake_%s.jpg',nameArray(c1)));
end
