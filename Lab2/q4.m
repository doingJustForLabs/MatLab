clear;
clc;

 
X = [
%   P N O H  
    4 0 10 0;  % P4O10
    0 0 1 2;   % H2O
    1 0 4 3;   % H3PO4
    0 1 0 3;   % NH3
    1 1 4 6;   % NH4H2PO4
    1 2 4 9;   % (NH4)2HPO4
    0 1 1 5;   % NH4OH
];


r = rank(X);
[n, m] = size(X);
res = {};
count = 0;

for i = 1:(n - r + 1) 
    for j = 1:(m - r + 1) 
        window = X(i:i+r-1, j:j+r-1); 
        if det(window) ~= 0
            res{end+1} = window;
            count = count + 1;
        end
    end
end

res{1:4}
count