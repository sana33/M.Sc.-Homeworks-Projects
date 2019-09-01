function neighbors=HexagonNeighborhood(center,MaxX,MaxY,radious)
%   inputs:
%       center     :	center of Neighborhood
%       MaxX       :	Height of map
%       MaxY       :	Width of map
%       radious    :	Width of hexagon
%   outputs:
%       neighbors  :   array of all neighbors 
%   Example:
%       radious=2;
%       MaxX=10;MaxY=10;
%       center=[3;7];
%       neighbors=HexagonNeighborhood(center,MaxX,MaxY,radious)
neighbors=[];
HexagonalWidths=1+radious*2;
for kk=1:(1+radious*2)/2
    HexagonalWidths=[(HexagonalWidths(1)-1) HexagonalWidths (HexagonalWidths(end)-1)];
end
HeightIndex=1;
for i=center(1)-radious:center(1)+radious
    EvenOrOdd=mod(HexagonalWidths(HeightIndex),2);
    if EvenOrOdd~=0
        radious=floor(HexagonalWidths(HeightIndex)/2);
        for j=center(2)-radious:center(2)+radious
            if i>0 && i<=MaxX && j>0 && j<=MaxY
                neighbors=[neighbors;
                            i j];
            end 
        end
    else
        radious=HexagonalWidths(HeightIndex)/2;
        for j=center(2)-radious:center(2)+(radious-1)
            if i>0 && i<=MaxX && j>0 && j<=MaxY
                 neighbors=[neighbors;
                            i j];
            end 
        end
    end
    HeightIndex=HeightIndex+1;
end