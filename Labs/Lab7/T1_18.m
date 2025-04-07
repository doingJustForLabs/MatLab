clear all;
clc;

function n = opt_polynomial_degree(y)

    m = length(y);
    diff_table = zeros(m, m);
    diff_change = zeros(m-1, 1);
    diff_table(:, 1) = y(:);

    for j = 2:m
        for i = 1:(m-j+1)
            diff_table(i, j) = diff_table(i+1, j-1) - diff_table(i, j-1);
        end
    end
    
    fprintf('Таблица конечных разностей:\n');
    disp(diff_table);

    for k = 2:m
        diff_change(k) = max(diff_table(1:m-k+1, k)) - min(diff_table(1:m-k+1, k));
    end
    disp(diff_change');
    
    [~, min_index] = min(diff_change(2:end-1));
    n = min_index;
    fprintf('Оптимальная степень интерполяционного полинома: %d\n', n);
end

function error = interpolation_error(x, y, xx, polynomial_coeffs)
    
    y_polynomial = polyval(polynomial_coeffs, xx);
    y_real = interp1(x, y, xx, "spline");

    error = 1.0;
    for j = 1:length(xx)
        if (~ismember(x, xx(j)))
            error = error * abs(y_real(j) - y_polynomial(j));
        end
    end
end

t = [5, 6, 7, 8, 10, 11, 12, 13, 14];
y = [347.6, 205.1, 173.5, 4.008, 38.54, 92.25, 273.63, 550.10, 650.19];

n = opt_polynomial_degree(y);

W = vander(t);

polynomial_coeffs = W \ y';

tt = linspace(min(t), max(t), 100);
y_spline = interp1(t, y, tt, "spline");

y_vandermond = polyval(polynomial_coeffs, tt);

y_polyfit = polyval(polyfit(t, y, 7), tt);

error = interpolation_error(t, y, linspace(min(t), max(t), 10), polynomial_coeffs);
fprintf("Ошибка: %4.2f", error);

plot(t, y, 'o', "MarkerfaceColor", "g");
hold on;
grid("on");

plot(tt, y_spline, '-r', "LineWidth", 2);

hold on;

plot(tt, y_vandermond, '--b', "LineWidth", 2)

hold on;

plot(tt, y_polyfit, '-.', "LineWidth", 2)

legend("Экспериментальные данные", "Кубический сплайн", "Интеполяционный полином", "Интерполяционный полином (polyfit)", "Location", "northwest");