syms x

y = (x^2 / log(x)) * (1 - log(x));

dydx = diff(y, x);
equation = x^3 * (dydx - x) - y^2;
simplified_eq = simplify(equation);
disp(simplified_eq)
if simplified_eq ~= 0
    disp("1 уравнение не является решением");
else
    disp("1 уравнение является решением");
end


y = x^2;
dydx = diff(y, x);
disp(" ");
equation = x^3 * (dydx - x) - y^2;
simplified_eq = simplify(equation);
disp(simplified_eq)
if simplified_eq ~= 0
    disp("2 уравнение не является решением");
else
    disp("2 уравнение является решением");
end

f = @(x, y) y * tan(x) + 1/cos(x);

h1 = 0.1;
h2 = 0.02;
a = 0;
b = 1;

x0 = 0;
y0 = 0;

% N = (b-a)/h1;
% 
% y = zeros(1, N+1);
% y(1) = y0;
% t = a:h1:b;
% 
% for n = 1:(N-1)
%     y(n+1) = y(n) + h1 * f(t(n), y(n));
% end

[x_eul_h1, y_eul_h1] = method_euler(h1, a, b, y0, f);
[x_eul_h2, y_eul_h2] = method_euler(h2, a, b, y0, f);
[x_ode, y_ode] = ode45(f, [a b], y0);
[x_RK_h1, y_RK_h1] = method_RK_4_por(h1, a, b, x0, y0, f);
[x_RK_h2, y_RK_h2] = method_RK_4_por(h2, a, b, x0, y0, f);

% График решения
plot(x_eul_h1, y_eul_h1, 'b-o', 'LineWidth', 1.5);
hold on;
plot(x_eul_h2, y_eul_h2, 'r--', 'LineWidth', 1.5);
plot(x_ode, y_ode, 'k-', 'LineWidth', 1.5);
plot(x_RK_h1, y_RK_h1, 'p--', 'LineWidth', 1.5);
plot(x_RK_h2, y_RK_h2, 'g--', 'LineWidth', 1.5);
xlabel('x');
ylabel('y(x)');
legend('Эйлер h = 0.1', 'Эйлер h = 0.02', 'ode45', 'Рунге-Кутты 4 пор. h = 0.1', 'Рунге-Кутты 4 пор. h = 0.02', Location='best');
grid on;


y_exact = interp1(x_ode, y_ode, b);

% Абсолютные погрешности в конце интервала
abs_err_eul_h1 = abs(y_exact - y_eul_h1(end));
abs_err_eul_h2 = abs(y_exact - y_eul_h2(end));
abs_err_rk_h1  = abs(y_exact - y_RK_h1(end));
abs_err_rk_h2  = abs(y_exact - y_RK_h2(end));

%оценка погрешности
p_eul = 1;
p_rk = 4;

% Эйлер
runge_err_eul = abs((y_eul_h2(1:h1/h2:end) - y_eul_h1) / (2^p_eul - 1));
% РК4
runge_err_rk = abs((y_RK_h2(1:h1/h2:end) - y_RK_h1) / (2^p_rk - 1));

fprintf('Абсолютная погрешность (Эйлер, h=0.1): %.5e\n', abs_err_eul_h1);
fprintf('Абсолютная погрешность (Эйлер, h=0.02): %.5e\n', abs_err_eul_h2);
fprintf('Абсолютная погрешность (РК4, h=0.1): %.5e\n', abs_err_rk_h1);
fprintf('Абсолютная погрешность (РК4, h=0.02): %.5e\n', abs_err_rk_h2);
disp(" ");
fprintf('Погрешность по Рунге (Эйлер, конец): %.5e\n', runge_err_eul(end));
fprintf('Погрешность по Рунге (РК4, конец): %.5e\n', runge_err_rk(end));


y_ode_eul_h1 = interp1(x_ode, y_ode, x_eul_h1);
y_ode_eul_h2 = interp1(x_ode, y_ode, x_eul_h2);
y_ode_rk_h1  = interp1(x_ode, y_ode, x_RK_h1);
y_ode_rk_h2  = interp1(x_ode, y_ode, x_RK_h2);

abs_err_eul_h1 = abs(y_ode_eul_h1 - y_eul_h1);
abs_err_eul_h2 = abs(y_ode_eul_h2 - y_eul_h2);
abs_err_rk_h1  = abs(y_ode_rk_h1  - y_RK_h1);
abs_err_rk_h2  = abs(y_ode_rk_h2  - y_RK_h2);

% Построение графика погрешностей
figure;
plot(x_eul_h1, abs_err_eul_h1, 'b-o', 'LineWidth', 1.5);
hold on;
plot(x_eul_h2, abs_err_eul_h2, 'r--', 'LineWidth', 1.5);
plot(x_RK_h1, abs_err_rk_h1, 'm-.', 'LineWidth', 1.5);
plot(x_RK_h2, abs_err_rk_h2, 'g:', 'LineWidth', 1.5);
xlabel('x');
ylabel('Абсолютная погрешность');
title('Абсолютная погрешность по всему интервалу в зависимости от шага интегрирования');
legend('Эйлер, h = 0.1', 'Эйлер, h = 0.02', ...
       'РК4, h = 0.1', 'РК4, h = 0.02', ...
       'Location', 'best');
grid on;



function [x, y] = method_euler(h, a, b, y0, f)
    N = (b-a)/h;
    y = zeros(1, N+1);
    y(1) = y0;
    x = a:h:b;
    
    for n = 1:(N)
        y(n+1) = y(n) + h * f(x(n), y(n));
    end
end

function [x, y] = method_RK_4_por(h, a, b, x0, y0, f)
    N = ((b-a)/h);
    x = zeros(1, N+1);
    y = zeros(1, N+1);
    x(1) = x0;
    y(1) = y0;

    for n = 1:N
        k1 = h * f(x(n), y(n));
        k2 = h * f(x(n) + h/2, y(n) + k1/2);
        k3 = h * f(x(n) + h/2, y(n) + k2/2);
        k4 = h * f(x(n)+ h, y(n) + k3);
        y(n+1) = y(n) + (k1+2*k2 + 2 * k3+ k4)/6;
        x(n+1) = x(n) + h;
    end

end
