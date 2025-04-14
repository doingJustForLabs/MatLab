function optimal_degree = create_diff_table(x, y, n) 
    diff_table = zeros(n, n);
    diff_table(:, 1) = y(:);
    
    for j = 2:n
        for i = 1:n - j + 1
            diff_table(i, j) = diff_table(i + 1, j - 1) - diff_table(i, j - 1);
        end
    end
    disp("Таблица конечных разностей")
    disp(diff_table);

    d = max(diff_table, [], 1) - min(diff_table, [], 1);
    disp(d);
    
    [~, optimal_degree] = min(d(2:end)); 
    optimal_degree = optimal_degree + 1;
    fprintf('Оптимальная степень полинома: %d\n', optimal_degree);
end
