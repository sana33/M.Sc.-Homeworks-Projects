function A = gml_read(fileName)
  %Extracting edges from gml file graph
  inputfile = fopen(fileName);
  T=[];
  l=0;
  k=1;
  while 1
    % Get a line from the input file
    tline = fgetl(inputfile);
    % Quit if end of file
    if ~ischar(tline)
      break
    end
    nums = regexp(tline,'\d+','match');
    if length(nums)
      if l==1
        l=0;
        T(k,2)=str2num(nums{1});  
        k=k+1;
        continue;
      end
      T(k,1)=str2num(nums{1});
      l=1;
    else
      l=0;
      continue;
    end
  end

  T = T - min(T(:)) + 1;
  N = max(T(:));
  A = zeros(N);
  for i=1:size(T, 1)
    A(T(i, 1), T(i, 2)) = 1;
    A(T(i, 2), T(i, 1)) = 1;
  end
end