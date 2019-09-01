function adjMat = gml_read(fileName)
    inputfile = fopen(fileName);
    adjMat=[];
    l=0;
    k=1;
    while 1
        % Get a line from the input file
        tline = fgetl(inputfile);
        % Quit if end of file
        if ~ischar(tline)
            break
        end
        nums = regexp(tline,'\d+','match'); %get number from string
        if length(nums)
            if l==1
                l=0;
                adjMat(k,2)=str2num(nums{1});
                k=k+1;
                continue;
            end
            adjMat(k,1)=str2num(nums{1});
            l=1;
        else
            l=0;
            continue;
        end
    end
end