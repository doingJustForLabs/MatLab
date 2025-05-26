clear; 
clc;  

f = @(x, y) sin(x) - cos(y);

interval = [0, 1]; 
y0 = 1;          

h1 = 0.2;
h2 = 0.05;

h_runge_err = h2 / 2; 

% Метод Эйлера
[x_euler_h1, y_euler_h1] = methods.euler(f, interval, y0, h1);
[x_euler_h2, y_euler_h2] = methods.euler(f, interval, y0, h2);

% Метод Рунге-Кутты 4-го порядка
[x_rk4_h1, y_rk4_h1] = methods.rungeKutta4(f, interval, y0, h1);
[x_rk4_h2, y_rk4_h2] = methods.rungeKutta4(f, interval, y0, h2);

% Рунге-Кутта с половинным шагом для оценки погрешности
[~, y_rk4_h_runge_err] = methods.rungeKutta4(f, interval, y0, h_runge_err);

% Стандартный решатель MATLAB (ode45) для эталонного решения
[x_ode45, y_ode45] = ode45(f, interval, y0);

x_data = {x_euler_h1, x_euler_h2, x_rk4_h1, x_rk4_h2, x_ode45};
y_data = {y_euler_h1, y_euler_h2, y_rk4_h1, y_rk4_h2, y_ode45};
legends = {['Эйлер, h = ', num2str(h1)], ...
           ['Эйлер, h = ', num2str(h2)], ...
           ['РК4, h = ', num2str(h1)], ...
           ['РК4, h = ', num2str(h2)], ...
           'MATLAB ode45 (эталон)'};

graphics.plotGraphics(x_data, y_data, legends, 'Решения ОДУ y'' = sin(x) - cos(y)', 'x', 'y');

% Получите значения решения в конце интервала (x=1)
y_rk4_h2_end = y_rk4_h2(end);
y_rk4_h_runge_err_end = y_rk4_h_runge_err(end);

p = 4; % Порядок метода РК4
m = h2 / h_runge_err; % Отношение шагов
runge_error_rk4_h2 = abs(y_rk4_h_runge_err_end - y_rk4_h2_end) / (m^p - 1);

fprintf('Оценка погрешности по Рунге для РК4 с h = %.3f в точке x = %.2f: %.6e\n', h2, interval(2), runge_error_rk4_h2);

[~, idx_ode45_end] = min(abs(x_ode45 - interval(2)));
y_ode45_end = y_ode45(idx_ode45_end);

error_rk4_h1_vs_ode45 = abs(y_rk4_h1(end) - y_ode45_end);
error_rk4_h2_vs_ode45 = abs(y_rk4_h2(end) - y_ode45_end);
error_euler_h1_vs_ode45 = abs(y_euler_h1(end) - y_ode45_end);
error_euler_h2_vs_ode45 = abs(y_euler_h2(end) - y_ode45_end);

fprintf('\nАбсолютная погрешность (относительно ode45) в точке x = %.2f:\n', interval(2));
fprintf('Эйлер (h = %.2f): %.6e\n', h1, error_euler_h1_vs_ode45);
fprintf('Эйлер (h = %.2f): %.6e\n', h2, error_euler_h2_vs_ode45);
fprintf('РК4 (h = %.2f):   %.6e\n', h1, error_rk4_h1_vs_ode45);
fprintf('РК4 (h = %.2f):   %.6e\n', h2, error_rk4_h2_vs_ode45);
