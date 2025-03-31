nameReag = {'N';
            'H';
            'O';
            'C'};

% NH3; H2O; NH4OH; CO2; (NH4)2CO3; NH4HCO3
structMatrix = [1, 3, 0, 0;
                0, 2, 1, 0;
                1, 5, 1, 0;
                0, 0, 2, 1;
                2, 8, 3, 1;
                1, 5, 3, 1]

fprintf('Ранк структурной матрицы = %d\n\n', rank(structMatrix));

submatrices = {};       % массив невырожденных подматриц
[rows, cols] = size(structMatrix);
sub_rows = rank(structMatrix);
sub_cols = rank(structMatrix);
for i = 1:(rows - sub_rows + 1)
    for j = 1:(cols - sub_cols + 1)
        submatrix = structMatrix(i:i+sub_rows-1, j:j+sub_cols-1);

        if det(submatrix) ~= 0
            submatrices{end + 1} = submatrix;   % добавление невырожденной матрицы
            fprintf('Невырожденная подматрица с (%d, %d):\n', i, j);
            disp(submatrix);
            fprintf('Определитель подматрицы = %d\n\n\n', det(submatrix));
        end
    end
end

% for k = 1:length(submatrices)
%     fprintf('Подматрица %d:\n', k);
%     disp(submatrices{k});
% end