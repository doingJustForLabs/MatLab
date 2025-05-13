syms x
f = cos(x) - x^2*sin(x);

%% Аналитическое решение
x0 = 0;
x1 = 10;
x_plot = linspace(x0, x1, 1000);

f1 = @(x) cos(x) - x.^2 .* sin(x);

func_int_analyt = @(x) sin(x) - 2*cos(x) + x^2*cos(x) - 2*x*sin(x);

I_analytic = func_int_analyt(x1) - func_int_analyt(x0); 
disp(['Аналитическое значение интеграла: ', num2str(I_analytic)]);

% I = int(f, x);
% disp(I);

% I_analytic = double(subs(I, x, x1)) - double(subs(I, x, x0));
% f_num = matlabFunction(f);

% I = integral(f1, x0, x1);

% func_int = matlabFunction(I);

y_plot = f1(x_plot);
% y_int = (x_plot);

% fprintf('(Используя функцию integral) Аналитическое значение интеграла на [%d; %d] = %f\n', x0, x1, I);

%% Метод трапеций
f2 = diff(f, x, 2);
f_proiz2 = matlabFunction(f2);
[x_max, neg_max_value] = fminbnd(@(x) -abs(f_proiz2(x)), 0, 10);
max_value_d2f = -neg_max_value;

eps_trap = 1e-2;

h_trap = sqrt((12*eps_trap)/(x1-x0)*max_value_d2f);

n_h = ceil((x1-x0)/h_trap);

% Узлы интегрирования
x_h = linspace(x0, x1, n_h+1);
y_h = f1(x_h);


I_h = h_trap * ((y_h(1) + y_h(end))/2 + sum(y_h(2:end-1)));

h_half = h_trap / 2;
n_half = ceil((x1-x0)/h_half);
x_half = linspace(x0, x1, n_half+1);
y_half = f1(x_half);
I_half = h_half * ((y_half(1) + y_half(end))/2 + sum(y_half(2:end-1)));

p = 2;  % порядок метода трапеций
I_runge = I_half + (I_half - I_h) / (2^p - 1);

fprintf('Метод трапеций с шагом h: %.4f\n', I_h);
fprintf('Метод трапеций с шагом h/2: %.4f\n', I_half);
fprintf('Уточнённый интеграл (Рунге): %.4f\n', I_runge);

%% График зависимости от шага в методе трапеций
h_min = 0.01;
h_max = 1;
N = 20;

h_vals = linspace(h_min, h_max, N);
errors = zeros(size(h_vals));

for i = 1:length(h_vals)
    h = h_vals(i);
    n = ceil((x1-x0)/h);
    x_temp = linspace(x0, x1, n+1);
    y_temp = f1(x_temp);
    I_temp = h * ( (y_temp(1) + y_temp(end))/2 + sum(y_temp(2:end-1)) );
    errors(i) = abs(I_temp - I_analytic);
end

figure;
plot(h_vals, errors, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 5);
grid on;
xlabel('Шаг h');
ylabel('Погрешность');
title('График влияния шага h на точность интегрирования методом трапеций');

%% Метод Симпсона

eps_simpson = 1e-4;
f4_simp = diff(f, x, 4);
% disp(f4_simp);

f4_num = matlabFunction(f4_simp);
[x_max4, neg_max4_value] = fminbnd(@(x) -abs(f4_num(x)), x0, x1);
M4 = abs(f4_num(x_max4));

h_simpson = (180 * eps_simpson / ((x1 - x0) * M4))^(1/4);
fprintf('Шаг для метода Симпсона: %f\n', h_simpson);

n_simpson = ceil((x1 - x0) / h_simpson);
if mod(n_simpson, 2) == 1
    n_simpson = n_simpson + 1;
end
h_simpson = (x1 - x0) / n_simpson;

% Узлы
x_simpson = linspace(x0, x1, n_simpson + 1);
y_simpson = f1(x_simpson);

% Метод Симпсона
I_simpson = (h_simpson/3) * ( y_simpson(1) + 2*sum(y_simpson(3:2:end-2)) + ...
    4*sum(y_simpson(2:2:end)) + y_simpson(end));

fprintf('Приближённое значение интеграла методом Симпсона: %.4f\n\n', I_simpson);

%% Решение стандартными методами MATLAB

disp('Результаты при решении стандартными методами');

x_trapz = linspace(x0, x1, n_h+1);
y_trapz = f1(x_trapz);

I_trapz = trapz(x_trapz, y_trapz);
fprintf('Интеграл методом трапеций trapz: %.4f\n', I_trapz);

I_integral = integral(f1, x0, x1);
fprintf('Интеграл через встроенную функцию integral: %.4f\n\n', I_integral);


%% Сравнение между аналитическим и рассчитанным

fprintf('Ошибка integral %.4f\n', abs(I_analytic-I_integral));
fprintf('Ошибка метода трапеций с шагом h %.4f\n', abs(I_analytic-I_h));
fprintf('Ошибка метода трапеций с шагом h/2 %.4f\n', abs(I_analytic-I_half));
fprintf('Ошибка метода трапеций уточненный Рунге %.4f\n', abs(I_analytic-I_runge));
fprintf('Ошибка метода Симпсона %.4f\n', abs(I_analytic-I_simpson));
fprintf('Ошибка trapz %.4f\n', abs(I_analytic-I_trapz));

%% 2 и 3 задания с неопределенным и несобственным интегралами

syms x
f = (x - exp(x)) / (x + 1);

I = int(f, x);
disp('Полученный кеопределённый интеграл:');
disp('');
disp(I);

% f_perv = x - log(x + 1) - ei(x + 1)*exp(-1);
% disp(diff(f_perv, x));

f2 = @(x) x.^2 ./ (x.^3 + 4);
% I2 = integral(f2, -Inf, 0);
% disp('Несобственный интеграл:');
% disp(I2);

% Интервал интегрирования
x0 = -Inf;
x1 = 0; 

% Метод трапеций
try
    n = 1000;  % Количество разбиений
    x_trap = linspace(x0, x1, n);
    y_trap = f2(x_trap);

    I_trap = trapz(x_trap, y_trap);

    % Проверка на расходимость
    if abs(I_trap) > 1e6 
        error('Метод трапеций: интеграл расходится');
    end
    if isnan(I_trap)
        error('NaN. Вероятно всего, что интеграл расходится');
    end
    fprintf('Интеграл методом трапеций: %.4f\n', I_trap);
catch
    disp('Метод трапеций: Интеграл расходится');
end

% Метод Симпсона
try
    n_simpson = 1000;  % Количество разбиений
    if mod(n_simpson, 2) == 1
        n_simpson = n_simpson + 1;
    end
    
    x_simpson = linspace(x0, x1, n_simpson);
    y_simpson = f2(x_simpson);

    % Метод Симпсона
    I_simpson = (x_simpson(2) - x_simpson(1)) / 3 * ...
        (y_simpson(1) + y_simpson(end) + 4*sum(y_simpson(2:2:end)) + 2*sum(y_simpson(3:2:end-1)));

    % Проверка на расходимость
    if abs(I_simpson) > 1e6
        error('Метод Симпсона: интеграл расходится');
    end
    if isnan(I_simpson)
        error('NaN. Вероятно всего, что интеграл расходится');
    end

    fprintf('Интеграл методом Симпсона: %.4f\n', I_simpson);
catch
    disp('Метод Симпсона: Интеграл расходится');
end

try
    I = integral(f2, x0, x1);

    % Проверка на расходимость
    if abs(I) > 1e6
        error('Несобственный интеграл: интеграл расходится');
    end
    fprintf('Несобственный с помощью integral: %.4f\n\n', I);
catch
    disp('Несобственный интеграл: Интеграл расходится');
end

%% Интеграл из варианта расходится (несобственный), поэтому возьмем f(x) = x*sin(x)
f_nes = @(x) 1 ./ x.^2;

% f2 = @(x) x.^2 ./ (x.^3 + 4);

x0 = 1;
x1 = Inf;
result = integral(f_nes, x0, x1);
disp(result);

try
    I = integral(f_nes, x0, x1);

    fprintf('Несобственный с помощью integral: %.4f\n', I);
catch
    disp('Несобственный интеграл: Интеграл расходится');
end

%% Графичек

figure;
% subplot(2,1,1);
% plot(x_plot, y_int, 'b-', 'LineWidth', 1.5, 'DisplayName', 'График интеграла');
% xlabel('x');
% ylabel('F(x)');

% hold off;

% subplot(2,1,2);
plot(x_plot, y_plot, 'r--', 'LineWidth', 2, 'DisplayName', 'Функция f(x)');
xlabel('x');
ylabel('f(x)');
title('График первообразной функции f(x) = cos(x) - x^2 sin(x)');
grid on;
legend show;