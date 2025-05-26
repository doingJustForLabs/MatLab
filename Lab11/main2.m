clear;
clc;
close all;

% --- Определение функции и ее градиента символьно ---
syms x_sym y_sym;
f_sym = exp(-(x_sym^2 + y_sym^2)/8) * (sin(x_sym)^2 + cos(y_sym)^2);

% Вычисляем частные производные
grad_f_sym_x = diff(f_sym, x_sym);
grad_f_sym_y = diff(f_sym, y_sym);

f_handle = matlabFunction(f_sym, 'Vars', [x_sym, y_sym]);
grad_x_handle = matlabFunction(grad_f_sym_x, 'Vars', [x_sym, y_sym]);
grad_y_handle = matlabFunction(grad_f_sym_y, 'Vars', [x_sym, y_sym]);

% Обертка для градиента, чтобы он возвращал вектор [df/dx; df/dy]
gradient_handle = @(p) [grad_x_handle(p(1), p(2)); grad_y_handle(p(1), p(2))];
f_vec_handle = @(p) f_handle(p(1), p(2));

fprintf('Функция: f(x,y) = exp(-(x^2+y^2)/8) * (sin(x)^2 + cos(y)^2)\n');

% Параметры для метода градиентного спуска
initial_point = [4; -3]; 
learning_rate = 0.1;    
accuracy = 1e-5;       % Критерий остановки (малое изменение положения)
max_iterations = 500;   

fprintf('Начальная точка: (%.2f, %.2f)\n', initial_point(1), initial_point(2));
fprintf('Скорость обучения (alpha): %.2f\n', learning_rate);
fprintf('Точность (epsilon): %.e\n', accuracy);

% Градиентный спуск
[p_min_custom, f_min_custom, iter_custom, history_points_custom] = ...
    methods.gradient(f_vec_handle, gradient_handle, initial_point, learning_rate, accuracy, max_iterations);

fprintf('\n--- Метод Градиентного спуска ---\n');
if isnan(f_min_custom)
    fprintf('Метод не сошелся или результат NaN после %d итераций.\n', iter_custom);
else
    fprintf('Найденный минимум: P = (%.6f, %.6f)\n', p_min_custom(1), p_min_custom(2));
    fprintf('Значение функции в минимуме: f(P) = %.6f\n', f_min_custom);
    fprintf('Количество итераций: %d\n', iter_custom);
end

% Построение графика для нашего метода
if ~isnan(f_min_custom)
    history_values_custom = zeros(size(history_points_custom, 2), 1);
    for i = 1:size(history_points_custom, 2)
        history_values_custom(i) = f_vec_handle(history_points_custom(:,i));
    end
    graphics.plot2D(f_handle, history_points_custom, history_values_custom, p_min_custom, f_min_custom, ...
                          'Градиентный спуск', initial_point);
end