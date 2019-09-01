function [bSeArray] = bSeDefine()
bSeArray = cell(1,8);

bSeArray(1) = {[-1 -1 -1; 0 1 0; 1 1 1]};
bSeArray(2) = {[0 -1 -1; 1 1 -1; 1 1 0]};
bSeArray(3) = {[1 0 -1; 1 1 -1; 1 0 -1]};
bSeArray(4) = {[1 1 0; 1 1 -1; 0 -1 -1]};
bSeArray(5) = {[1 1 1; -1 1 -1; 0 -1 0]};
bSeArray(6) = {[0 1 1; -1 1 1; -1 -1 0]};
bSeArray(7) = {[-1 0 1; -1 1 1; -1 0 1]};
bSeArray(8) = {[-1 -1 0; -1 1 1; 0 1 1]};

end

