function [neighbors] = pixNeighbors(pixRow, pixCol, imHeight, imWidth, neighbRad)
neighbors = [];
for l2 = 1:imWidth
    for l1 = 1:imHeight
        if norm([pixRow - l1, pixCol - l2]) <= neighbRad
            neighbors = [neighbors; l1 l2];
        end
    end
end
