% lab3_3

% СЛАУ
A = [2.34 -1.42 -0.54 0.21; 
    1.44 -0.53 1.43 -1.27;
    0.63 -1.32 -0.65 1.43;
    0.54 0.88 -.67 -2.38];

B = [0.66;
    -1.44;
    0.94;
    0.73];

det_A = det(A);
rank_A = rank(A);
norm_A = norm(A);

% число обусловленности матрицы коэффициентов
cond_A1 = cond(A);

% Решение через LU разложение
[L, U] = lu(A);
y = L\B;
x_LU = U\y;
% с помощью linsolve
x_linsolve = linsolve(A, B);

% проверка точности решения
accuracy_check = (A * x_LU - B);

disp("Матрица коэффициентов");
disp(A);
fprintf("Матрица коэффициентов:\nОпределитель: %.3f\nРанг: %d\nНорма: %.3f\n\n", ...
    det_A, rank_A, norm_A);

fprintf('Решение СЛАУ с помощью LU разложения X:\n');
fprintf('%10.5f\n', X_obratn_matrix);

fprintf('\nX (linsolve):\n');
fprintf('%10.5f\n', X_linsolve);

fprintf('\nОбусловленность матрицы коэффициентов %.5f\n\n', cond_A);
% fprintf('%10.5f\n', cond_A1);

fprintf('Точность решения\n');
fprintf('%10.1e\n', accuracy_check);
