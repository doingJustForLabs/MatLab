clear;
clc;

A = [9.1 5.6 7.8; 
    3.8 5.1 2.8; 
    4.1 5.7 1.2];

B = [9.8; 6.7; 5.8];

det_A = det(A)
rank_A = rank(A)
norm_A = norm(A)

% Число обусловленности матрицы коэффициентов
cond_A = cond(A)

% Решение методом Гаусса
X_Gauss = A\B
% Решение с помощью linsolve
X_linsolve = linsolve(A, B)

% Проверка точности решения
accuracy_check = (A * X_Gauss - B);

fprintf('Точность решения\n');
fprintf('%14.5e\n', accuracy_check);
