clear;
clc;

A = [6 -1 1; 
     1 -2 3; 
     3 4 4];

B = [0; 1; -1];

det_A = det(A)
rank_A = rank(A)
norm_A = norm(A)

% Число обусловленности матрицы коэффициентов
cond_A = cond(A)

% Решение обртаной матрицей
X_inv_matrix = inv(A)*B

% Решение linsolve
X_linsolve = linsolve(A, B)

% проверка точности решения
accuracy_check = (A * X_inv_matrix - B);

fprintf('Точность решения\n');
fprintf('%14.5e\n', accuracy_check);
