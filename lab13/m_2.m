h = 0.1;

x0 = 0;
x_end = 3;
x_span = [x0 x_end];
N = (x_end - x0) / h;
y0 = [1; 1];

[x_ode, y_ode] = ode45(@f, x_span, y0);

[x_euler, y_euler] = yavn_euler(@f, x0, y0, h, N);
[x_neyavn, y_neyavn] = neyavn_euler(@f, x0, y0, h, N);

jest = zeros(1, N+1);
for i = 1:N+1
    x = x0 + (i-1)*h;
    J = [exp(x^2), x; -1, 2];
    lambda = eig(J);
    jest(i) = max(abs(lambda)) / min(abs(lambda));
end

figure;
subplot(2,1,1);
plot(x_ode, y_ode(:, 1), 'k-', 'LineWidth', 2, 'DisplayName', 'ode45');
hold on;
plot(x_euler, y_euler(:,1), 'b-o', 'DisplayName', 'y1 (явный)');
plot(x_euler, y_euler(:,2), 'b--o', 'DisplayName', 'y2 (явный)');
plot(x_neyavn, y_neyavn(:,1), 'r-s', 'DisplayName', 'y1 (неявный)');
plot(x_neyavn, y_neyavn(:,2), 'r--s', 'DisplayName', 'y2 (неявный)');
hold off;
legend('show', Location='best');
xlabel('x');
ylabel('y');
title('Сравнение методов');

subplot(2, 1, 2);
plot(x_euler, jest, 'm-^');
xlabel('x');
ylabel('Жёсткость |λ_{max}|/|λ_{min}|');
title('Оценка жёсткости системы');
grid on;


figure;
subplot(2,1,1);
semilogy(x_ode, y_ode(:, 1), 'k-', 'LineWidth', 2, 'DisplayName', 'ode45 y1');
hold on;
semilogy(x_euler, abs(y_euler(:,1)), 'b-o', 'DisplayName', '|y1| (явный)');
semilogy(x_euler, abs(y_euler(:,2)), 'b--o', 'DisplayName', '|y2| (явный)');
semilogy(x_neyavn, abs(y_neyavn(:,1)), 'r-s', 'DisplayName', '|y1| (неявный)');
semilogy(x_neyavn, abs(y_neyavn(:,2)), 'r--s', 'DisplayName', '|y2| (неявный)');
hold off;
legend('show');
xlabel('x');
ylabel('log_{10}(|y|)');
title('Решения системы');
grid on;

subplot(2,1,2);
plot(x_euler, jest, 'm-^');
xlabel('x');
ylabel('log_{10}(|λ_{max}|/|λ_{min}|)');
title('Жесткость системы');
grid on;


function dydx = f(x, y)
    dydx = zeros(2, 1);
    dydx(1) = y(1) * exp(x^2) + x * y(2);
    dydx(2) = 3*x - y(1) + 2 * y(2);
end

function [x, y] = yavn_euler(f, x0, y0, h, N)
    x = x0:h:x0 + N*h;
    y = zeros(N+1, 2);
    y(1, :) = y0';
    for i = 1:N
        y(i+1, :) = y(i, :)' + h * f(x(i), y(i, :)');
        y(i+1, :) = y(i+1, :)';
    end
end

function [x, y] = neyavn_euler(f, x0, y0, h, N)
    x = x0:h:x0 + N*h;
    y = zeros(N+1, 2);
    y(1, :) = y0';

    for i = 1:N
        y_guess = y(i, :)' + h * f(x(i), y(i, :)');
        options = optimoptions('fsolve', 'Display', 'off');
        current_y = y(i, :)';
        next_x = x(i+1);
        func = @(y) y - current_y - h * f(next_x, y);
        y_next = fsolve(func, y(i,:)', options);
        y(i+1, :) = y_next';
    end
end