function [cellsCat] = cellCat(cellArray, cellNew, dir)

cellSz = length(cellArray);
dir = lower(dir);
switch dir
    case 'hor'
        cellsCat = cell(1,cellSz+1);
        for c1 = 1:cellSz
            cellsCat{c1} = cellArray{c1};
        end
        cellsCat{end} = cellNew;
    case 'ver'
        cellsCat = cell(cellSz+1,1);
        for c1 = 1:cellSz
            cellsCat{c1} = cellArray{c1};
        end
        cellsCat{end} = cellNew;
end

end
