clear; close all; clc; warning off

%% Part A
A = [8	17	4	10	15	12;
    10	12	15	7	3	10;
    15	10	50	5	3	12;
    4	8	11	4	1	8;
    16	7	4	3	0	7;
    16	24	19	3	20	10];
outputA = pseudoMedian(A);

B = [1	1	2	5	3	1;
    3	20	5	6	4	6;
    4	6	4	20	2	2;
    4	3	3	5	1	5;
    6	5	20	2	20	2;
    6	3	1	4	1	2];
outputB = pseudoMedian(B);

%% Part B
kid1 = imread('inputs/kid1.jpg');
kid2 = imread('inputs/kid2.jpg');

kid1PsuMed = uint8(pseudoMedian(kid1));
kid2PsuMed = uint8(pseudoMedian(kid2));

figure;
subplot(2,2,1);
imshow(kid1); title('Kid1 - Original')
subplot(2,2,2);
imshow(kid1PsuMed); title('Kid1 - After Applying PseudoMedian')
subplot(2,2,3);
imshow(kid2); title('Kid2 - Original')
subplot(2,2,4);
imshow(kid2PsuMed); title('Kid2 - After Applying PseudoMedian')

