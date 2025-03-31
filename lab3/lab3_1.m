% lab3_1

% данная СЛАУ
A = [6 -1 1; 
    1 -2 3; 
    3 4 4];

B = [0; 1; -1];

det_A = det(A);
rank_A = rank(A);
norm_A = norm(A);

% число обусловленности матрицы коэффициентов
cond_A = cond(A);

% решение обртаной матрицей и с помощью linsolve
X_obratn_matrix = inv(A)*B;
X_linsolve = linsolve(A, B);

% проверка точности решения
accuracy_check = (A * X_obratn_matrix - B);

disp("Матрица коэффициентов");
disp(A);

fprintf("Матрица коэффициентов:\nОпределитель: %.3f\nРанг: %d\nНорма: %.3f\n\n", ...
    det_A, rank_A, norm_A);

fprintf('X (Метод с обратной матрицей):\n');
fprintf('%10.5f\n', X_obratn_matrix);

fprintf('\nX (linsolve):\n');
fprintf('%10.5f\n', X_linsolve);

fprintf('\nОбусловленность матрицы коэффициентов %.5f\n\n', cond_A);
% fprintf('%10.5f\n', cond_A1);

fprintf('Точность решения\n');
fprintf('%14.5e\n', accuracy_check);