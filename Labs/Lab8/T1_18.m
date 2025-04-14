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

    [~, min_index] = min(diff_change(2:end-1));
    n = min_index;
    fprintf('Оптимальная степень интерполяционного полинома: %d\n', n);
end

function rel_error = interpolation_error_nodes(x, y, polynomial_coeffs)
    y_polynomial = polyval(polynomial_coeffs, x);
    rel_errors = abs((y - y_polynomial) ./ y);
    rel_error = mean(rel_errors) * 100;    
end

t = [0, 2, 5, 9, 11, 16, 18, 21, 24];
h = [10.00, 918.4, 2222.5, 3448.9, 3550.9, 1736.4, 984.174, 436.146, 807.6];

n = opt_polynomial_degree(h);

W = vander(t);
W = W(:, end-4:end);
coeff_vandermonde = W \ h';

coeff_polyfit = polyfit(t, h, 4);

tt = linspace(min(t), max(t), 300);
h_spline = interp1(t, h, tt, "spline");
h_vander = polyval(coeff_vandermonde, tt);
h_polyfit = polyval(coeff_polyfit, tt);

plot(t, h, 'o', 'MarkerFaceColor', 'g'); hold on; grid on;
plot(tt, h_spline, '-r', 'LineWidth', 2);
plot(tt, h_vander, '--b', 'LineWidth', 2);
plot(tt, h_polyfit, '-.', 'LineWidth', 2);
legend("Узловые точки", "Кубический сплайн", "Полином Вандермонда", "polyfit", "Location", "northeast");
title('Интерполяция высоты колонны');
xlabel('Время (t)');
ylabel('Высота (h)');

err = interpolation_error_nodes(t, h, coeff_vandermonde);
fprintf('\nСредняя относительная ошибка в узлах (Вандермонд): %.2f%%\n', err);

key_times = [3.5, 6.7, 12.4];
key_heights = interp1(t, h, key_times, 'spline');
for i = 1:length(key_times)
    fprintf('t = %.1f -> h = %.2f\n', key_times(i), key_heights(i));
end
