clear;
clc;

syms x;
f = sin(x) + 0.3 * x;
func = @(x) sin(x) + 0.3 * x;

% Интервал
a = 0;    
b = 2*pi; 

% Аналитический интеграл
analytic_integral = @(a, b) -cos(b) + 0.15*b^2 - (-cos(a) + 0.15*a^2);
fprintf('Аналитический интеграл: %.10f\n', analytic_integral(a, b));

% Метод трапеций с точностью 1e-2
[h_max, trapez_result] = methods.trapezoid_method(func, a, b, 1e-2);
fprintf('Интеграл методом трапеций: %.10f\n', trapez_result);

% Уточнение интеграла методом Рунге
trap_result_new = methods.trapezoid_runge_ref(func, a, b, h_max);

% Уточнённый результат методом Рунге
I_final = (4 * trap_result_new - trapez_result) / 3;
fprintf('Уточнённый результат методом Рунге: %.10f\n', I_final);

% Построение графика
x_lin = linspace(a, b, 500);
yy = func(x_lin);
graphics.create_func(x_lin, yy);

% 2. Метод Симпсона с точностью ε=10^-4

f4 = diff(f, 4);
f4_func = matlabFunction(f4);
f4_max = 1;

eps = 1e-4;
h = ((180 * eps) / ((b-a) * f4_max))^(1/4);

% % Округляем до удобного значения
n = ceil((b-a)/h);
if mod(n, 2) ~= 0  % Метод Симпсона требует четное число интервалов
    n = n + 1;
end
h = (b-a)/n;

% Вычисляем интеграл методом Симпсона
x_simp = a:h:b;
y_simp = func(x_simp);

simp_result = (h/3) * (y_simp(1) + 4*sum(y_simp(2:2:end-1))) + ...
              (h/3) * 2*sum(y_simp(3:2:end-2)) + (h/3)*y_simp(end);

fprintf('Интеграл методом Симпсона (n=%d): %.10f\n\n', n, simp_result);

% 3. Вычисление неопределённого интеграла
indefinite_integral = int(f);
fprintf('Неопределённый интеграл: ');
disp(indefinite_integral);

% 4. Вычисление несобственного интеграла (пример: от 0 до inf от exp(-x))
improper_f = @(x) exp(-x);
improper_result = integral(improper_f, 0, Inf);
fprintf('Несобственный интеграл от 0 до inf от exp(-x): %.5f\n', improper_result);
