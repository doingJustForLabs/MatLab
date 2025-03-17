clc; clear;

% Определение коэффициентов матрицы A и вектора b
A = [2  2 -3  3;
     3  2 -3  1;
     1  1 -2  2;
     2  4 -3  2];

b = [-3; -3; -1; -3];

% Определение детерминанта, ранга, нормы и числа обусловленности
detA = det(A);
rankA = rank(A);
normA = norm(A);
condA = cond(A);

function [new_A, new_b] = make_diagonally_dominant(A, b)
    % Выберем диагонально доминирующую матрицу D
    n = size(A, 1);
    D = diag([4 4 4 4]); % Диагональная матрица с диагональным преобладанием
    D(D == 0) = 1;
    
    new_A = D; 
    
    % Преобразуем вектор b
    new_b = new_A * inv(A) * b;
    return;
end

[A, b] = make_diagonally_dominant(A, b);

diag_dom = all(2*abs(diag(A)) >= sum(abs(A), 2));
if ~diag_dom
    disp('Матрица не обладает диагональным преобладанием. Методы Якоби и Зейделя могут не сойтись.');
end

fprintf('Детерминант матрицы A: %f\n', detA);
fprintf('Ранг матрицы A: %d\n', rankA);
fprintf('Норма матрицы A: %f\n', normA);
fprintf('Число обусловленности матрицы A: %f\n\n', condA);

% Задаём точность и максимальное количество итераций
accuracy = 1e-6;

% Начальное приближение
x0 = zeros(size(b));

% --- Метод Якоби ---
[x_jacobi, iter_jacobi] = jacobi_method(A, b, x0, accuracy);
fprintf('Метод Якоби сошёлся за %d итераций.\n', iter_jacobi);
disp('Решение методом Якоби:');
disp(x_jacobi);

% --- Метод Зейделя ---
[x_zeidel, iter_zeidel] = seidel_method(A, b, x0, accuracy);
fprintf('Метод Зейделя сошёлся за %d итераций.\n', iter_zeidel);
disp('Решение методом Зейделя:');
disp(x_zeidel);

% --- Метод простой итерации ---

tau = 0.1;

[x_simple, iter_simple] = simple_iterations(A, b, x0, tau, accuracy);
fprintf('Метод простой итерации сошёлся за %d итераций.\n', iter_simple);
disp('Решение методом простой итерации:');
disp(x_simple);

% --- Решение через встроенную функцию linsolve ---

x_linsolve = linsolve(A, b);
disp('Решение с использованием linsolve:');
disp(x_linsolve);

% --- Функция метода Якоби ---
function [x, iter] = jacobi_method(A, b, x0, accuracy)
    n = length(b);

    % [A, b] = make_diagonally_dominant(A, b);

    D = diag(diag(A)); % Диагональная часть
    L = tril(A, -1);   % Нижняя треугольная часть (без диагонали)
    U = triu(A, 1);    % Верхняя треугольная часть (без диагонали)

    iter = 0;
    x1 = D \ (b - (L + U) * x0); % Первое приближение

    while norm(x1 - x0, inf) > accuracy
        x0 = x1;
        x1 = D \ (b - (L + U) * x0); % Новое приближение
        iter = iter + 1;
    end

    x = x1; % Возвращаем решение
end

% --- Функция метода Зейделя ---
function [x, iter] = seidel_method(A, b, x0, accuracy)
    n = length(b);

    % [A, b] = make_diagonally_dominant(A, b);

    D = diag(diag(A)); % Диагональная часть
    L = tril(A, -1);   % Нижняя треугольная часть (без диагонали)
    U = triu(A, 1);    % Верхняя треугольная часть (без диагонали)

    x1 = -(L + D) \ (U * x0) + (L + D) \ b;
    iter = 0;

    while norm(x1 - x0, inf) >= accuracy
        x0 = x1;
        x1 = -(L + D) \ (U * x0) + (L + D) \ b;
        iter = iter + 1;
    end
    x = x1;
end

% --- Функция метода простой итерации ---
function [x, iter] = simple_iterations(A, b, x0, tau, accuracy)
    n = length(b);

    % [A, b] = make_diagonally_dominant(A, b);

    E = eye(n); % Единичная матрица
    B = E - tau * A; % Матрица B
    F = tau * b; % Вектор F

    x1 = B * x0 + F;
    iter = 0;

    while norm(x1 - x0, inf) >= accuracy
        x0 = x1;
        x1 = B * x0 + F;
        iter = iter + 1;
    end
    x = x1;
end
