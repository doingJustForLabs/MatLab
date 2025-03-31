% заданная матрица
A = [2 4 2 6;
     3 10 4 2;
     1 4 8 3;
     2 4 1 5];

b = [64;
     108;
     81;
     56];

% преобразуем матрицу А с диагональным преобладанием
[A, b] = diag_domin(A, b);
detA = det(A);
rankA = rank(A);
normA = norm(A);
condA = cond(A);
% fprintf("Матрица коэффициентов:\nОпределитель: %.3f\nРанг: %d\nНорма: %.3f\n\n", ...
%     detA, rankA, normA);
% fprintf('\nОбусловленность матрицы коэффициентов %.5f\n\n', condA);

acc = 1e-5;
fprintf('Точность задания: %.3e\n\n', acc);

x = linsolve(A, b);
fprintf('Решение linsolve:\n');
fprintf('%10.4f\n\n', x);

[x_jacobi, iter_jacobi] = jacobi(A, b, acc);

% Решение методом Зейделя
[x_seidel, iter_seidel] = seidel(A, b, acc);

t = 0.03;
[x_mpi, iter_mpi] = mpi(A, b, t, acc);

check_convergence(A);

function [x, iter] = jacobi(A, b, acc)
    n = length(b);
    x = zeros(n, 1);  % Начальное приближение
    D = diag(diag(A));
    L = tril(A, -1);  % Нижняя треугольная часть A
    U = triu(A, 1);  % Верхняя треугольная часть A
    B = -D \ (L + U);  % Матрица итераций
    F = D \ b;  % Вектор итераций
    
    iter = 0;
    while true
        x_new = B * x + F;
        iter = iter + 1;
        
        if norm(x_new - x) < acc
            break;
        end
        
        x = x_new;  % Обновляем решение
    end
    
    fprintf('Метод Якоби: x = \n');
    disp(x);
    fprintf('Количество итераций: %d\n', iter);
end

function [x, iter] = seidel(A, b, acc)
    n = length(b);
    x = zeros(n, 1);
    D = diag(diag(A));
    L = tril(A, -1); 
    U = triu(A, 1);  
    M = L + D;  % Матрица (L + D)
    B = -M \ U;
    F = M \ b;
    
    iter = 0;
    while true
        x_new = B * x + F;
        iter = iter + 1;
        
        if norm(x_new - x) < acc
            break;
        end
        
        x = x_new;  % Обновляем решение
    end
    
    fprintf('Метод Зейделя: x = \n');
    disp(x);
    fprintf('Количество итераций: %d\n', iter);
end

function [x, iter] = mpi(A, b, t, acc)
    n = length(b);
    x = zeros(n, 1);
    E = eye(n);
    B = E - t * A;
    F = t * b;

    iter = 0;
    while true
        x_new = B * x + F;
        iter = iter + 1;

        if norm(x_new - x) < acc
            break;
        end

        x = x_new;
    end
    fprintf('Метод простых итераций: u = \n');
    disp(x);
    fprintf('Количество итераций: %d\n', iter);
end
