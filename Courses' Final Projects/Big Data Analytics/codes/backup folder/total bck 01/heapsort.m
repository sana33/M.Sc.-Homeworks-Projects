function x = heapsort(x)
%--------------------------------------------------------------------------
% Syntax:       sx = heapsort(x);
%               
% Inputs:       x is a vector of length n
%               
% Outputs:      sx is the sorted (ascending) version of x
%               
% Description:  This function sorts the input array x in ascending order
%               using the heapsort algorithm
%               
% Complexity:   O(n * log(n))    best-case performance
%               O(n * log(n))    average-case performance
%               O(n * log(n))    worst-case performance
%               O(1)             auxiliary space
%               
% Author:       Brian Moore
%               brimoor@umich.edu
%               
% Date:         January 5, 2014
%--------------------------------------------------------------------------

% Build max-heap from x
n = length(x);
x = buildmaxheap(x,n);

% Heapsort
heapsize = n;
for i = n:-1:2
    % Put (n + 1 - i)th largest element in place
    x = swap(x,1,i);
    
    % Max-heapify x(1:heapsize)
    heapsize = heapsize - 1;
    x = maxheapify(x,1,heapsize);
end

end

function x = buildmaxheap(x,n)
% Build max-heap out of x
% Note: In practice, x xhould be passed by reference

for i = floor(n / 2):-1:1
    % Put children of x(i) in max-heap order
    x = maxheapify(x,i,n);
end

end

function x = maxheapify(x,i,heapsize)
% Put children of x(i) in max-heap order
% Note: In practice, x xhould be passed by reference

% Compute left/right children indices
ll = 2 * i; % Note: In practice, use left bit shift
rr = ll + 1; % Note: In practice, use left bit shift, then add 1 to LSB

% Max-heapify
if ((ll <= heapsize) && (x(ll) > x(i)))
    largest = ll;
else
    largest = i;
end
if ((rr <= heapsize) && (x(rr) > x(largest)))
    largest = rr;
end
if (largest ~= i)
    x = swap(x,i,largest);
    x = maxheapify(x,largest,heapsize);
end

end

function x = swap(x,i,j)
% Swap x(i) and x(j)
% Note: In practice, x xhould be passed by reference

val = x(i);
x(i) = x(j);
x(j) = val;

end