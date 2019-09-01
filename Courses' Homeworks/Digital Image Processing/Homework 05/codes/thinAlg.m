function  y = thinAlg(x,bSeArray)
for c1 = 1:length(bSeArray)
    x = thinFunc(x,cell2mat(bSeArray(c1)));
end
y = x;
end

function z = thinFunc(x,b)
z = x & ~(bwhitmiss(x,b));
end