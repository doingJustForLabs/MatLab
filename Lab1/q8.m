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

row_combinations = nchoosek(1:n, r);
col_combinations = nchoosek(1:m, r);

res = {};

for i = 1:size(col_combinations, 1)
    for j = 1:size(row_combinations, 1)
        submatrix = X(row_combinations(j, :), col_combinations(i, :));
        if det(submatrix) ~= 0
            res{end+1} = submatrix;
        end
    end
end

fprintf('Ранг структурной матрицы: %d\n', r);
disp('Пример невырожденных подматриц: ');
res{1:3}

%   P     N     O
% | 4     0    10|
% | 0     0     1| = P4O10 + 6H2O -> 4H3PO4
% | 0     1     0|