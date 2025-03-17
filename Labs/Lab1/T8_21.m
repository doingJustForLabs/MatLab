clear;
clc;

% CaF2; H2SO4; CaSO4; HF; SiF4; H2SiF6; CaO; H2O
% Матрица: каждая строка представляет вещество, каждый столбец - элемент

% Структурная матрица:
A = [
  %Ca  S  H  O  F  Si
    1  0  0  0  2  0;  % CaF₂
    0  1  2  4  0  0;  % H₂SO₄
    1  1  0  4  0  0;  % CaSO₄
    0  0  1  0  1  0;  % HF
    0  0  0  0  4  1;  % SiF₄
    0  0  2  0  6  1;  % H₂SiF₆
    1  0  0  1  0  0;  % CaO
    0  0  2  1  0  0   % H₂O
];

%1.

[n, m] = size(A);
rank_A = rank(A);
res = {};

rows = nchoosek(1:n, rank_A);
cols = nchoosek(1:m, rank_A);

for i = 1:size(cols)
    for j = 1:size(rows)
        sub = A(rows(j, :), cols(i, :));
        if det(sub) ~= 0
            res{end+1} = sub;
        end
    end
end

res{1:3}
