struct_matrix = [1, 3, 0, 0;
                0, 2, 1, 0;
                1, 5, 1, 0;
                0, 0, 2, 1;
                2, 8, 3, 1;
                1, 5, 3, 1]

rank_struct = rank(struct_matrix);

fprintf('Ранк структурной матрицы = %d\n\n', rank_struct);

submatrices = {};
[m, n] = size(struct_matrix);
% проходим по всем подматрицам размерности ранга и ищем невырожденные
for row = nchoosek(1:m, rank_struct)'
    for col = nchoosek(1:n, rank_struct)'
        sub_matrix = struct_matrix(row, col);
        if det(sub_matrix) ~= 0
            submatrices{end+1} = sub_matrix;
        end
    end
end


for k = 1:length(submatrices)
    fprintf('Невырожденная подматрица %d:\n', k);
    disp(submatrices{k});
end
