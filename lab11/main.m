
% func = e.^(-(x.^2 + y.^2)/8) .* (sin(x.^2) + cos(x.^2));

% [z, f, exitflag, output] = fminsearch(@(x) e^(-(x^2+y^2)/8)*(sin(x^2)+cos(y^2)));

syms x
f = cos(x) - x^2*sin(x);
func = @(x) cos(x) - x.^2 .* sin(x);
global df d2f;
df = matlabFunction(diff(f));
d2f = matlabFunction(diff(f, 2));

x0 = -15.03;
x1 = -8.18;
eps = 1e-4;

x_plot = linspace(x0, x1, 1000);
y_plot = func(x_plot);

[minim_gold, minim_hist_gold] = find_all_extrema(@gold_sec, func, x0, x1, eps, false);
[maxim_gold, maxim_hist_gold] = find_all_extrema(@gold_sec, func, x0, x1, eps, true);

[minim_parab, minim_hist_parab] = find_all_extrema(@parabolic_method, func, x0, x1, eps, false);
[maxim_parab, maxim_hist_parab] = find_all_extrema(@parabolic_method, func, x0, x1, eps, true);

[minim_newton, minim_hist_newton] = find_all_extrema(@newton_method, func, x0, x1, eps, false);
[maxim_newton, maxim_hist_newton] = find_all_extrema(@newton_method, func, x0, x1, eps, true);

disp("Метод золотого сечения:");
disp("Минимумы:"); disp(minim_gold);
disp("Максимумы:"); disp(maxim_gold);

disp("Метод парабол:");
disp("Минимумы:"); disp(minim_parab);
disp("Максимумы:"); disp(maxim_parab);

disp("Метод Ньютона:");
disp("Минимумы:"); disp(minim_newton);
disp("Максимумы:"); disp(maxim_newton);

n = 1000;

[std_min_x, std_min_y] = fminbnd(func, x0, x1); % минимум
[std_max_x, std_max_y] = fminbnd(@(x) -func(x), x0, x1); % максимум
std_max_y = -std_max_y;

disp('Сравнение с fminbnd');

disp('fminbnd:');
fprintf('Минимум: x = %.5f, y = %.5f\n', std_min_x, std_min_y);
fprintf('Максимум: x = %.5f, y = %.5f\n\n', std_max_x, std_max_y);

fprintf('Метод золотого сечения минимум: разница по y = %.5e\n', abs(func(minim_gold(1)) - std_min_y));
fprintf('Метод золотого сечения максимум: разница по y = %.5e\n', abs(func(maxim_gold(1)) - std_max_y));

fprintf('Метод парабол минимум: разница по y = %.5e\n', abs(func(minim_parab(1)) - std_min_y));
fprintf('Метод парабол максимум: разница по y = %.5e\n', abs(func(maxim_parab(1)) - std_max_y));

fprintf('Метод Ньютона минимум: разница по y = %.5e\n', abs(func(minim_newton(1)) - std_min_y));
fprintf('Метод Ньютона максимум: разница по y = %.5e\n', abs(func(maxim_newton(1)) - std_max_y));

figure;
subplot(2,1,1);
plot(x_plot, y_plot);
hold on

plot(minim_gold, func(minim_gold), 'ro', 'MarkerSize', 10);
plot(maxim_gold, func(maxim_gold), 'ro', 'MarkerSize', 10); 
plot(minim_parab, func(minim_parab), 'go', 'MarkerSize', 8);
plot(maxim_parab, func(maxim_parab), 'go', 'MarkerSize', 8);
plot(minim_newton, func(minim_newton), 'bo', 'MarkerSize', 6);
plot(maxim_newton, func(maxim_newton), 'bo', 'MarkerSize', 6);
grid on;
xlabel('x');
ylabel('y');
legend('Функция', 'Зол.сеч. мин', 'Зол.сеч. макс', 'Парабол мин', 'Парабол макс', 'Ньютон мин', 'Ньютон макс');

subplot(2,1,2);
plot(x_plot, y_plot, 'b--', 'LineWidth', 1);
hold on;

for i = 1:length(minim_hist_gold)
    plot(minim_hist_gold{i}(:,1), minim_hist_gold{i}(:,2), 'rs');
end
for i = 1:length(maxim_hist_gold)
    plot(maxim_hist_gold{i}(:,1), maxim_hist_gold{i}(:,2), 'rs');
end

for i = 1:length(minim_hist_parab)
    plot(minim_hist_parab{i}(:,1), minim_hist_parab{i}(:,2), 'go');
end
for i = 1:length(maxim_hist_parab)
    plot(maxim_hist_parab{i}(:,1), maxim_hist_parab{i}(:,2), 'go');
end

for i = 1:length(minim_hist_newton)
    plot(minim_hist_newton{i}(:,1), minim_hist_newton{i}(:,2), 'b.');
end
for i = 1:length(maxim_hist_newton)
    plot(maxim_hist_newton{i}(:,1), maxim_hist_newton{i}(:,2), 'b.');
end

% plot(minima, func(minima), 'g*', 'MarkerSize', 4, 'LineWidth', 4);
% plot(maxima, func(maxima), 'r*', 'MarkerSize', 4, 'LineWidth', 4);
grid on;
xlabel('x');
ylabel('y');
title('Значения экстремумов на отдельных шагах');
legend('Функция', 'Зол.сеч. мин', 'Зол.сеч. макс', 'Парабол мин', 'Парабол макс', 'Ньютон мин', 'Ньютон макс');


function [extrema, histories] = find_all_extrema(method_func, func, a, b, eps, find_max)
    if strcmp(func2str(method_func), 'gold_sec')
        n_intervals = 20;
        x_points = linspace(a, b, n_intervals + 1);
        extrema = [];
        histories = {};
        
        for i = 1:n_intervals
            [x_extr, history] = method_func(func, x_points(i), x_points(i+1), eps, find_max);
            if is_real_extremum(func, x_extr, find_max)
                % Проверяем, что это не дубликат
                is_new = true;
                for j = 1:length(extrema)
                    if abs(x_extr - extrema(j)) < eps
                        is_new = false;
                        break;
                    end
                end
                
                if is_new
                    extrema = [extrema, x_extr];
                    histories{end+1} = history;
                end
            end
            
        end
    else
        n_intervals = 20;
        x_points = linspace(a, b, n_intervals + 1);
        extrema = [];
        histories = {};
        
        for i = 1:n_intervals
            [x_extr, history] = method_func(func, x_points(i), x_points(i+1), eps, find_max);
            if is_real_extremum(func, x_extr, find_max)
                is_new = true;
                for j = 1:length(extrema)
                    if abs(x_extr - extrema(j)) < eps
                        is_new = false;
                        break;
                    end
                end
                if is_new
                    extrema = [extrema, x_extr];
                    histories{end+1} = history;
                end
            end
        end
    end
end

function result = is_real_extremum(f, x, is_max)
    h = 1e-5;
    df_left = (f(x) - f(x-h))/h;
    df_right = (f(x+h) - f(x))/h;
    
    if is_max
        result = (df_left > 0) && (df_right < 0);
    else
        result = (df_left < 0) && (df_right > 0);
    end
end

function [optimum, history] = gold_sec(func, a, b, eps, find_max)
    history = [];

    g = 0.618034;
    R = g * (b - a);

    x1 = b - R;
    x2 = a + R;
    f1 = func(x1);
    f2 = func(x2);

    for iter = 1:1000
        current_x = (a+b)/2;
        history = [history; current_x, func(current_x)];
        
        if xor(f1 > f2, find_max)
            a = x1;
            x1 = x2;
            f1 = f2;
            x2 = a + g*(b-a);
            f2 = func(x2);
        else
            b = x2;
            x2 = x1;
            f2 = f1;
            x1 = b - g*(b-a);
            f1 = func(x1);
        end
        
        if abs(b-a) < eps
            break;
        end
    end
    optimum = (a+b)/2;
end

function [optimum, history] = parabolic_method(func, a, b, eps, find_max)
    history = [];

    x1 = a;
    x3 = b;
    x2 = (x1 + x3)/2;

    f1 = func(x1);
    f2 = func(x2);
    f3 = func(x3);

    for iter = 1:1000
        numerator = (x2 - x1)^2 * (f2 - f3) - (x2 - x3)^2 * (f2 - f1);
        denominator = 2 * ((x2 - x1)*(f2 - f3) - (x2 - x3)*(f2 - f1));

        if denominator == 0
            break;
        end

        x = x2 - numerator / denominator;
        fx = func(x);
        history = [history; x, fx];

        % Обновляем точки в зависимости от направления
        if xor(fx > f2, find_max)
            if x < x2
                x1 = x;
                f1 = fx;
            else
                x3 = x;
                f3 = fx;
            end
        else
            x2 = x;
            f2 = fx;
        end

        if abs(x3 - x1) < eps
            break;
        end
    end

    optimum = x2;
end

function [optimum, history] = newton_method(func, a, b, eps, find_max)
    global df d2f;
    x = (a + b)/2;
    history = [];

    for iter = 1:1000
        dfx = df(x);
        d2fx = d2f(x);

        if d2fx == 0
            optimum = NaN;
            return;
        end

        if find_max
            x_new = x + dfx / abs(d2fx);
        else
            x_new = x - dfx / abs(d2fx);
        end

        if abs(x_new - x) > 1 || x_new < a || x_new > b
            optimum = NaN;
            return;
        end

        history = [history; x, func(x)];

        if abs(x_new - x) < eps
            if (find_max && d2fx < 0) || (~find_max && d2fx > 0)
                optimum = x_new;
            else
                optimum = NaN;
            end
            return;
        end

        x = x_new;
    end

    optimum = NaN;
end