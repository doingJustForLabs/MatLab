clear;
clc;
close all;

% Параметры для одномерной оптимизации
f = @(x) sin(x) + 0.3 * x;
a = 9.81;
b = 15.26;
eps = 1e-5;

% Метод Золотого сечения
fprintf('--- Метод Золотого сечения ---\n');
find_golden_max = false;
[x_gs, f_gs, iter_gs, x_hist_gs, y_hist_gs] = methods.goldenSection(f, a, b, eps);
fprintf('Найденный минимум: x = %.5f, f(x) = %.5f\n', x_gs, f_gs);
fprintf('Количество итераций: %d\n', iter_gs);
graphics.plot1D(f, a, b, x_hist_gs, y_hist_gs, x_gs, f_gs, 'Метод Золотого сечения');

% Метод Парабол
fprintf('\n--- Метод Парабол ---\n');
[x_parab, f_parab, iter_parab, x_hist_parab, y_hist_parab] = methods.parabolic(f, a, (a+b)/2, b, eps, 500);
fprintf('Найденный минимум: x = %.5f, f(x) = %.5f\n', x_parab, f_parab);
fprintf('Количество итераций: %d\n', iter_parab);
graphics.plot1D(f, a, b, x_hist_parab, y_hist_parab, x_parab, f_parab, 'Метод Парабол');

% Метод Ньютона
fprintf('\n--- Метод Ньютона ---\n');
df = @(x) cos(x) + 0.3;      
ddf = @(x) -sin(x);           
x0_newton = 10.0; 
[x_newton, f_newton, iter_newton, x_hist_newton, y_hist_newton] = methods.newton(f, df, ddf, x0_newton, eps, 100); 
fprintf('Найденный экстремум: x = %.5f, f(x) = %.5f\n', x_newton, f_newton);
fprintf('Количество итераций: %d\n', iter_newton);
graphics.plot1D(f, a, b, x_hist_newton, y_hist_newton, x_newton, f_newton, 'Метод Ньютона');

% fminbnd
fprintf('\n--- Стандартная функция MATLAB: fminbnd ---\n');
options_fminbnd = optimset('TolX', eps, 'Display', 'final', 'PlotFcns', @optimplotfval);
[x_fminbnd, f_fminbnd, exitflag_fminbnd, output_fminbnd] = fminbnd(f, a, b, options_fminbnd);

fprintf('Найденный минимум (fminbnd): x = %.5f, f(x) = %.5f\n', x_fminbnd, f_fminbnd);
fprintf('Exitflag: %d\n', exitflag_fminbnd);
disp('Output структура:');
disp(output_fminbnd);

fprintf('Метод                | x_min   | f(x_min) | Итерации\n');
fprintf('---------------------|---------|----------|----------\n');
fprintf('Золотое сечение      | %7.4f | %8.4f | %3d\n', x_gs, f_gs, iter_gs);
fprintf('Парабол              | %7.4f | %8.4f | %3d\n', x_parab, f_parab, iter_parab);
fprintf('Ньютона              | %7.4f | %8.4f | %3d\n', x_newton, f_newton, iter_newton);
fprintf('fminbnd              | %7.4f | %8.4f | %3d (funcCount)\n', x_fminbnd, f_fminbnd, output_fminbnd.funcCount);
