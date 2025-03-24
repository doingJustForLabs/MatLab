clc;
clear;

% Задаем интервал
a = -25;
b = 10;

% Определяем функцию
f = @(x) (x - 4).^3 + 6;

% Решение через fzero
x0 = 10; 
root = fzero(f, x0); 
y_root = f(root);
disp('Решение через fzero:');
disp(root);

% Строим график функции
fplot(f, [-10, 10]);
xlabel('x'); 
ylabel('f(x)'); 
title('График функции f(x) = (x - 4)^3 + 6'); 
grid;
ylim([y_root - 10, y_root + 10]);

yline(0, 'k', 'LineWidth', 0.5); % Черная линия y = 0
xline(0, 'k', 'LineWidth', 0.5); % Черная линия x = 0

% Задаем точность
high_accuracy = 0.1;
accuracy = 1e-5;

% Решение методом половинного деления с высокой точностью
[x_half, iter_half] = methods.binary_search(f, a, b, high_accuracy);
fprintf('Метод половинного деления сошелся за %d итераций. (высокая точность)\n', iter_half);
fprintf('Приближенный корень: %f\n\n', x_half);

% Устанавливаем начальное приближение x0
x0 = x_half;

% Находим производную (для следующих методов)
df = @(x) 3*(x - 4).^ 2;

% Решение методом хорд
[x_chord, iter_chord] = methods.chord(f, x0, a, b, accuracy);
fprintf('Метод хорд сошелся за %d итераций.\n', iter_chord);
fprintf('Приближенный корень: %f\n\n', x_chord);

% Решение методом простых итераций
[x_simple, iter_simple] = methods.simple_iterations(f, df, x0, accuracy);
fprintf('Метод простых итераций сошелся за %d итераций.\n', iter_simple);
fprintf('Приближенный корень: %f\n\n', x_simple);

% Решение методом касательных
[x_newton, iter_newton] = methods.newton(f, df, x0, accuracy);
fprintf('Метод касательных сошелся за %d итераций.\n', iter_newton);
fprintf('Приближенный корень: %f\n\n', x_newton);

% Решение методом секущих
[x_secant, iter_secant] = methods.secant(f, x0, accuracy);
fprintf('Метод секущих сошелся за %d итераций.\n', iter_secant);
fprintf('Приближенный корень: %f\n\n', x_secant);

% Добавляем звёздочки на график
hold on;

% Начальная точка (синяя звездочка)
plot(x0, f(x0), 'b*', 'MarkerSize', 10, 'LineWidth', 2);

% Найденный корень (красная звездочка)
plot(root, 0, 'r*', 'MarkerSize', 10, 'LineWidth', 2);

hold off;