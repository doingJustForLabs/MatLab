syms x y;
% Функция
f = exp(-(x^2 + y^2)/8) * (sin(x)^2 + cos(y)^2);

% Производные по x и y
dfdx = diff(f, x);
dfdy = diff(f, y);

f_func = matlabFunction(f);
dfdx_func = matlabFunction(dfdx);
dfdy_func = matlabFunction(dfdy);

% Начальная точка
x = rand() * 12 - 6;
y = rand() * 12 - 6;
alpha = 0.1; % шаг градиента
eps = 1e-6;
max_iter = 1000;

trajectory = [x, y];

for i = 1:max_iter
    grad_x = dfdx_func(x, y);
    grad_y = dfdy_func(x, y);
    
    x_new = x - alpha * grad_x;
    y_new = y - alpha * grad_y;
    
    if norm([x_new - x, y_new - y]) < eps
        break;
    end
    
    x = x_new; y = y_new;
    trajectory(end+1, :) = [x, y];
end

f_best = f_func(x, y);
fprintf('Минимум с методом градиентного спуска: x = %.6f, y = %.6f, f(x, y) = %.6f\n', x, y, f_best);

[xgrid, ygrid] = meshgrid(-6:0.1:6, -6:0.1:6);
zgrid = f_func(xgrid, ygrid);

figure;
surf(xgrid, ygrid, zgrid, 'EdgeColor', 'none'); hold on;
plot3(trajectory(:,1), trajectory(:,2), f_func(trajectory(:,1), trajectory(:,2)), 'r.-', 'LineWidth', 2);
plot3(x, y, f_func(x, y), 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
title('Градиентный спуск');
xlabel('x'); ylabel('y'); zlabel('z');

figure;
contourf(xgrid, ygrid, zgrid, 50); colormap jet; colorbar;
hold on;
plot(trajectory(:,1), trajectory(:,2), 'w.-', 'LineWidth', 2);
scatter(x, y, 100, 'k', 'filled');
title('2D-график (контурный) с шагами спуска');
xlabel('x'); ylabel('y');


initial_point = rand(2, 1) * 12 - 6;

% Опции для fminunc
options = optimset('GradObj', 'on', 'Display', 'off');

[x_opt, f_opt] = fminunc(@(xy) deal(f_func(xy(1), xy(2)), [dfdx_func(xy(1), xy(2)); dfdy_func(xy(1), xy(2))]), initial_point, options);

fprintf('Минимум с fminunc: x = %.6f, y = %.6f, f(x, y) = %.6f\n', x_opt(1), x_opt(2), f_opt);