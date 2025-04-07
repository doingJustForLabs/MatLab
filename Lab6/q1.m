clc;
clear;

% Определение функций
f1 = @(x,y) (1.5*x).^6 + (y-1).^6 - 3.6^6;
f2 = @(x) x.^(3/2) + sqrt(5.5 - x.^2).*sin(5*pi*x);

% Построение графиков
graphic(f1, f2);

% Функция для fsolve
fun = @(x) [(1.5*x(1))^6 + (x(2)-1)^6 - 3.6^6;
           x(2) - x(1)^(3/2) - sqrt(5.5 - x(1)^2)*sin(5*pi*x(1))];

x0 = [2.33, 1.18];
[x_fsolve, fval, exitflag, output] = fsolve(fun, x0);

disp('Решение fsolve:');
disp(['x = ', num2str(real(x_fsolve(1))), ', y = ', num2str(real(x_fsolve(2)))]);
fprintf('Количество итераций: %d\n\n', output.iterations);

% Символьное решение
syms x y
eqns = [(1.5*x).^6 + (y-1).^6 == 3.6.^6, y == x.^(3/2) + sqrt(5.5 - x.^2) * sin(5*pi*x)];
vars = [x y];

[solX, solY] = vpasolve(eqns, vars);
disp('Символьное решение : ');
fprintf('x = %.8f, y = %.8f\n\n', solX, solY);

% Определение функции и матрицы Якоби
F = @(x,y) [(1.5*x)^6 + (y-1)^6 - 3.6^6;
            y - x^(3/2) - sqrt(5.5 - x^2)*sin(5*pi*x)];

J = @(x,y) [6*(1.5)^6*x^5, 6*(y-1)^5;
           -1.5*x^(1/2) + x/sqrt(5.5-x^2)*sin(5*pi*x) - 5.5*pi*sqrt(5.5-x^2)*cos(5*pi*x), 1];

% Начальное приближение (возьмём из предыдущего решения fsolve)
x0 = 2.3449;
y0 = 3.5625;

accuracy = 1e-5;
max_iter = 1000;

% Вызов модифицированного метода Ньютона
[x_newton, y_newton, iter_newton] = methods.newton(F, J, x0, y0, accuracy, max_iter);
[x_simple, y_simple, iter_simple] = methods.simple(x0, y0, accuracy, max_iter);

% Вывод результатов
disp('Решение методом Ньютона:');
disp(['x = ', num2str(real(x_newton)), ', y = ', num2str(real(y_newton))]);
fprintf('Количество итераций: %d\n\n', iter_newton);

disp('Решение методом простых итераций:');
disp(['x = ', num2str(real(x_simple)), ', y = ', num2str(real(y_simple))]);
fprintf('Количество итераций: %d\n\n', iter_simple);

% Добавляем найденные решения на график
hold on;
plot(x_fsolve(1), x_fsolve(2), '*', 'MarkerSize', 15);

