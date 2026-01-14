h = 0.1;
x_kon = 1;
x_nach = 0;

x_span = [x_nach x_kon];

N = (x_kon - x_nach)/h;

y0 = [1; 1];

[x_ode, y_ode] = ode45(@f, x_span, y0);
[x_euler, y_euler] = method_euler(@f, x_nach, y0, h, N);
[x_mod_euler, y_mod_euler] = method_euler_mod(@f, x_nach, y0, h, N);
[x_rk4, y_rk4] = method_RK4(@f, x_nach, y0, h, N);

stiffness = zeros(1, N+1);
for i = 1:N+1
    x = x_nach + (i-1)*h;
    J = [exp(-x^2), x; -1, 2]; % Матрица Якоби
    lambda = eig(J);
    stiffness(i) = max(abs(lambda)) / min(abs(lambda));
end

figure;
subplot(2, 1, 1);
plot(x_ode, y_ode(:, 1), 'k-', 'LineWidth', 2);
hold on;
plot(x_euler, y_euler(:, 1), 'b-o');
plot(x_mod_euler, y_mod_euler(:, 1), 'r-s');
plot(x_rk4, y_rk4(:, 1), 'g-*');
hold off;
legend('ode45 (y1)', 'Эйлер (y1)', 'Мод. Эйлер (y1)', 'РК4 (y1)');
xlabel('x');
ylabel('y');
title('Сравнение методов для y1(x)');
grid on;

subplot(2, 1, 2);
plot(x_ode, y_ode(:, 2), 'k-', 'LineWidth', 2);
hold on;
plot(x_euler, y_euler(:, 2), 'b-o');
plot(x_mod_euler, y_mod_euler(:, 2), 'r-s');
plot(x_rk4, y_rk4(:, 2), 'g-*');
hold off;
legend('ode45 (y2)', 'Эйлер (y2)', 'Мод. Эйлер (y2)', 'РК4 (y2)');
xlabel('x');
ylabel('y');
title('Сравнение методов для y2(x)');
grid on;

figure;
plot(x_euler, stiffness, 'm-^');
xlabel('x');
ylabel('Жёсткость |λ_{max}|/|λ_{min}|');
title('Оценка жёсткости системы');


function dydx = f(x, y)
    dydx = zeros(2, 1);
    dydx(1) = y(1) * exp(-x^2) + x * y(2);
    dydx(2) = 3*x - y(1) + 2 * y(2);
end

function [x, y] = method_euler(f, x0, y0, h, N)
    x = x0:h:x0 + N*h;
    y = zeros(length(y0), N+1);
    y(:, 1) = y0;
    for i=1:N
        y(:, i+1) = y(:, i) + h * f(x(i), y(:, i));
    end
    y = y';
end

function [x, y] = method_euler_mod(f, x0, y0, h, N)
    x = x0:h:x0 + N*h;
    y = zeros(length(y0), N+1);
    y(:, 1) = y0;
    for i=1:N
        k1 = f(x(i), y(:, i));
        k2 = f(x(i)+h, y(:, i)+h*k1);
        y(:, i+1) = y(:, i) + h/2*(k1+k2);
    end
    y = y';
end

function [x, y] = method_RK4(f, x0, y0, h, N)
    x = x0:h:x0 + N*h;
    y = zeros(length(y0), N+1);
    y(:, 1) = y0;
    for i=1:N
        k1 = f(x(i), y(:, i));
        k2 = f(x(i)+h/2, y(:, i)+h/2*k1);
        k3 = f(x(i)+h/2, y(:, i)+h/2*k2);
        k4 = f(x(i)+h, y(:, i)+h*k3);
        y(:, i+1) = y(:, i) + h/6*(k1+2*k2+2*k3+k4);
    end
    y = y';
end