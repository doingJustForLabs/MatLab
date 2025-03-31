% lab3_2

% данная СЛАУ
A = [9.1 5.6 7.8; 
    3.8 5.1 2.8; 
    4.1 5.7 1.2];

B = [9.8; 6.7; 5.8];

det_A = det(A);
rank_A = rank(A);
norm_A = norm(A);

% число обусловленности матрицы коэффициентов
cond_A = cond(A);

% решение методом Гаусса
X_Gauss = A\B;
% с помощью linsolve
X_linsolve = linsolve(A, B);

% проверка точности решения
accuracy_check = (A * X_Gauss - B);
disp("Матрица коэффициентов");
disp(A);
fprintf("Матрица коэффициентов:\nОпределитель: %.3f\nРанг: %d\nНорма: %.3f\n\n", ...
    det_A, rank_A, norm_A);

fprintf('X (Метод Гаусса):\n');
fprintf('%10.5f\n', X_Gauss);

fprintf('\nX (linsolve):\n');
fprintf('%10.5f\n', X_linsolve);

fprintf('\nОбусловленность матрицы коэффициентов %.5f\n\n', cond_A);

fprintf('Точность решения\n');
fprintf('%14.5e\n', accuracy_check);