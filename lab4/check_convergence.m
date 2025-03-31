function is_convergent = check_convergence(A)

    D = diag(diag(A));
    L = tril(A, -1);  % Нижняя треугольная часть A
    U = triu(A, 1);  % Верхняя треугольная часть A
    B = -D \ (L + U);  % Матрица итераций

    % Вычисляем норму матрицы B
    norm_B = norm(B, 2);

    % Проверяем условие сходимости
    if norm_B < 1
        is_convergent = true;
        fprintf('Условие сходимости выполняется: ||B|| = %.4f < 1\n', norm_B);
    else
        is_convergent = false;
        fprintf('Условие сходимости НЕ выполняется: ||B|| = %.4f >= 1\n', norm_B);
    end
end