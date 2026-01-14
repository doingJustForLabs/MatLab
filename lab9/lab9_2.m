% syms x
f = @(x) cos(x) - x.^2.*sin(x);
h_range = logspace(-10, -1, 10);

x0 = 3.14
% n=length(x);

dy_exp = @(x) -sin(x) - 2*x.*sin(x) - x.^2.*cos(x);

% формула правых разностей
dy_right = @(x, h) (f(x + h) - f(x)) / h;

% формула левых разностей
dy_left = @(x, h) (f(x) - f(x - h)) / h;

% формула центральных разностей
dy_center = @(x, h) (f(x + h) - f(x - h)) / (2*h);

% формула с 5 точками
dy_5multi = @(x, h) (f(x-2*h) - 8*f(x-h) + 8*f(x+h) - f(x+2*h)) / (12*h);


% Вторая производная
d2y_exp = @(x) -cos(x) - 4*x.*cos(x) + (x.^2 - 2).*sin(x);

% симметричная схема для второй производной
d2y_symmetr = @(x, h) (f(x + h) - 2*f(x) + f(x - h)) / h^2;

% пятиточечная формула прои
d2y_5multi = @(x, h) (-f(x-2*h) + 16*f(x-h) - 30*f(x) + 16*f(x+h) - f(x+2*h)) / (12*h^2);



% Вычисление погрешностей
errors_df = struct();
errors_df.right = zeros(size(h_range));
errors_df.left = zeros(size(h_range));
errors_df.center = zeros(size(h_range));
errors_df.fivepoints = zeros(size(h_range));

errors_d2f = struct();
errors_d2f.symmetr = zeros(size(h_range));
errors_d2f.fivepoints = zeros(size(h_range));

for i = 1:length(h_range)
    h = h_range(i);
    
    % Первая производная
    errors_df.right(i) = abs(dy_exp(x0) - dy_right(x0, h));
    errors_df.left(i) = abs(dy_exp(x0) - dy_left(x0, h));
    errors_df.center(i) = abs(dy_exp(x0) - dy_center(x0, h));
    errors_df.fivepoints(i) = abs(dy_exp(x0) - dy_5multi(x0, h));
    
    % Вторая производная
    errors_d2f.symmetr(i) = abs(d2y_exp(x0) - d2y_symmetr(x0, h));
    errors_d2f.fivepoints(i) = abs(d2y_exp(x0) - d2y_5multi(x0, h));
end

% Построение графиков

figure;

% Первая производная
subplot(2,1,1);
loglog(h_range, errors_df.right, 'r-', 'LineWidth', 1.5); 
hold on;
loglog(h_range, errors_df.left, 'g--', 'LineWidth', 1.5);
loglog(h_range, errors_df.center, 'b-.', 'LineWidth', 1.5);
loglog(h_range, errors_df.fivepoints, 'm:', 'LineWidth', 2);
title('Погрешности вычисления первой производной');
xlabel('Шаг h'); 
ylabel('Погрешность');
legend('Правая', 'Левая', 'Центр.', 'Пятиточечная', 'Location', 'best');
grid on;

% Вторая производная
subplot(2,1,2);
plot(h_range, errors_d2f.symmetr, 'b-', 'LineWidth', 1.5); 
hold on;
loglog(h_range, errors_d2f.fivepoints, 'r--', 'LineWidth', 2);
title('Погрешности вычисления второй производной');
xlabel('Шаг h'); 
ylabel('Погрешность');
legend('Симметричная (3 точ.)', 'Пятиточечная', 'Location', 'best');
grid on;

% Сравнение точности при h = 1e-3
h_fixed = 1e-3;

fprintf('Точность вычислений при h = %.0e\n', h_fixed);

fprintf('\n[Первая производная]\n');
fprintf('Экспериментальное значение: %f\n', dy_exp(x0));
fprintf('Правые разности. Значение: %f\n', dy_right(x0, h_fixed));
fprintf('Левые разности. Значение: %f\n', dy_left(x0, h_fixed));
fprintf('Центральные разности. Значение: %f\n', dy_center(x0, h_fixed));
fprintf('5-точечная формула. Значение: %f\n\n', dy_5multi(x0, h_fixed));

fprintf('Погрешность правых разностей: %.3e\n', errors_df.right(h_range == h_fixed));
fprintf('Погрешность левых разностей: %.3e\n', errors_df.left(h_range == h_fixed));
fprintf('Погрешность центральных разностей: %.3e\n', errors_df.center(h_range == h_fixed));
fprintf('Погрешность 5-точечной формулы: %.3e\n\n', errors_df.fivepoints(h_range == h_fixed));

fprintf('\n[Вторая производная]\n');
fprintf('Экспериментальное значение: %f\n', d2y_exp(x0));
fprintf('Симметричная схема. Значение: %f\n', d2y_symmetr(x0, h_fixed));
fprintf('Пятиточечная. Значение: %f\n\n', d2y_5multi(x0, h_fixed));

fprintf('Погрешность симметричной разности (3 точ.): %.3e\n', errors_d2f.symmetr(h_range == h_fixed));
fprintf('Погрешность пятиточечной формулы: %.3e\n', errors_d2f.fivepoints(h_range == h_fixed));