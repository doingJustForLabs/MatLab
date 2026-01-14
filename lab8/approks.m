% лаба аппроксимация
x = [0.31,	3.27,	3.42,	6.05,	6.64,	7.17,	10.48,	11.21,	13.54];
y = [5.222,	5.971,	6.527,	13.391,	15.736,	19.344,	57.370,	96.146,	134.715];
p = [0.9,	0.2,	0.8,	1,	0.9,	0.8,	1,	0.7,    0.2];

x_plot = linspace(min(x), max(x), 1000);

% x_test = [(x(1)+x(2))/2; (x(end-1)+x(end))/2];


% diff_table(y);

y_norm = (y - min(y)) / (max(y) - min(y));
optimal_degree = find_optimal(y_norm);

p_coeffs = vander_pol(x, y, optimal_degree);
y_vand = polyval(p_coeffs, x_plot);

p_polyfit = polyfit(x, y, optimal_degree);
y_polyfit = polyval(p_polyfit, x_plot);

y_polyval= polyval(p_polyfit, x);
errors = y - y_polyval;
fprintf('\nСтатистика ошибок интерполяции:\n');
fprintf('Средняя абсолютная ошибка: %.6f\n', mean(abs(errors)));
fprintf('Максимальная абсолютная ошибка: %.6f\n', max(abs(errors)));

[y_spap] = spap2_fit(x, y, p, optimal_degree, x_plot);
[y_fmin] = polyfit_fminsearch(x, y, p, optimal_degree, x_plot);
[y_fmin_exp] = fminsearch_exp_func(x, y, p, x_plot);
[y_cheb, x_plot_cheb] = polinom_Chebishev(x, y, p, optimal_degree);

fprintf('\nОценка точности аппроксимации:\n');
evaluate_accuracy(x, y, 'Вандермонд', @(xi) polyval(p_coeffs, xi));
evaluate_accuracy(x, y, 'Polyfit', @(xi) polyval(p_polyfit, xi));
evaluate_accuracy(x, y, 'spap2', @(xi) interp1(x_plot, y_spap, xi, 'linear', 'extrap'));
evaluate_accuracy(x, y, 'fminsearch (полином)', @(xi) interp1(x_plot, y_fmin, xi, 'linear', 'extrap'));
evaluate_accuracy(x, y, 'fminsearch (экспоненциальная)', @(xi) interp1(x_plot, y_fmin_exp, xi, 'linear', 'extrap'));
evaluate_accuracy(x, y, 'Полином Чебышева', @(xi) interp1(x_plot_cheb, y_cheb, xi, 'linear', 'extrap'));

figure('Position', [100, 100, 1200, 500]);
hold on;
scatter(x, y, 100, '*', 'filled', 'DisplayName', 'Узловые точки', 'LineWidth', 0.5, 'MarkerEdgeColor', 'r');
plot(x_plot, y_vand, 'k--', 'LineWidth', 3, 'DisplayName', 'Вандермонд');
plot(x_plot, y_polyfit, 'r-', 'LineWidth', 1, 'DisplayName', 'Polyfit');
plot(x_plot, y_spap, 'b--', 'LineWidth', 2, 'DisplayName', 'spap2');
plot(x_plot, y_fmin, 'g--', 'LineWidth', 1, 'DisplayName', 'fminsearch');
plot(x_plot, y_fmin_exp, 'blue--', 'LineWidth', 1, 'DisplayName', 'fminsearch exp');
plot(x_plot_cheb, y_cheb, 'cyan--', 'LineWidth', 1, 'DisplayName', 'polinom_Chebishev');
title('Сравнение методов аппроксимации');
legend('Location', 'northwest');
grid on;

% function diff_table(y)
%     m = length(y);
%     diff_table = zeros(m, m);
%     diff_change = zeros(m-1, 1);
%     diff_table(:, 1) = y(:);
% 
%     for j = 2:m
%         for i = 1:(m-j+1)
%             diff_table(i, j) = diff_table(i+1, j-1) - diff_table(i, j-1);
%         end
%     end
% 
%     fprintf('Таблица конечных разностей:\n');
%     disp(diff_table);
% 
%     for k = 2:m
%        diff_change(k) = max(diff_table(1:m-k+1, k)) - min(diff_table(1:m-k+1, k));
%     end
%     disp(diff_change');
% end

function optimal_degree = find_optimal(y_norm)
    max_order = length(y_norm)-2;
    tolerance = 0.05;
    optimal_degree = [];

    for k = 1:max_order
        d = diff(y_norm, k); % Разности k-го порядка нормированных данных
        
        fprintf('Разности %d-го порядка: max|Δy| = %.4f\n', k, max(abs(d)));
        
        if max(abs(d)) < tolerance
            fprintf('Оптимальная степень полинома: %d\n', k-1);
            optimal_degree = k-1;
            break;
        end
    end
    
    if isempty(optimal_degree)
        optimal_degree = max_order - 1;
        fprintf('Не удалось определить степень. Рекомендуемая: %d\n', optimal_degree);
    end
end

function p_coeffs = vander_pol(x, y, n)
    V = zeros(length(x), n+1);
    for i = 1:n+1
        V(:,i) = x.^(n+1-i);
    end
    p_coeffs = V \ y';
end

function [y_fit] = spap2_fit(x, y, weights, degree, x_plot)
    x_norm = (x - min(x))/(max(x)-min(x));
    y_norm = (y - min(y))/(max(y)-min(y));
    % weights = weights/max(weights);

    knots = 1;
    order = degree + 1;

    sp = spap2(knots, order, x_norm, y_norm, weights);

    x_plot_norm = (x_plot - min(x))/(max(x)-min(x));
    y_fit_norm = fnval(sp, x_plot_norm);
    y_fit = y_fit_norm * (max(y)-min(y)) + min(y);
end

function y_fmin = polyfit_fminsearch(x, y, weights, degree, x_plot)
    poly_func = @(params, x) polyval(params, x);
    
    error_func = @(params) sum(weights .* (poly_func(params, x) - y).^2);
    
    initial_guess = polyfit(x, y, degree);
    
    coefficients = fminsearch(error_func, initial_guess);
    
    y_fmin = poly_func(coefficients, x_plot);
end

function y_fit = fminsearch_exp_func(x, y, weights, x_plot)

    model = @(p, x) p(1)*exp(p(2)*x) + p(3);

    error_func = @(p) sum(weights .* (model(p, x) - y).^2);

    p0 = [1, 1, 1];

    params = fminsearch(error_func, p0);

    y_fit = model(params, x_plot);
end

function [y_cheb, x_plot] = polinom_Chebishev(x, y, weights, degree)
    x = x(:);
    y = y(:);
    weights = weights(:);


    a = min(x);
    b = max(x);
    x_scaled = (2*x - (b + a)) / (b - a);
    
    % матрица базисных функций Чебышева
    T = zeros(length(x), degree+1);
    T(:,1) = 1;   
    if degree >= 1
        T(:,2) = x_scaled;
    end
    for k = 2:degree
        T(:,k+1) = 2*x_scaled.*T(:,k) - T(:,k-1);
    end

    W = diag(weights);
    coeffs = (T' * W * T) \ (T' * W * y);

    x_plot = linspace(a, b, 500);
    x_plot_scaled = (2*x_plot - (b + a)) / (b - a);

    % Вычисление значений полинома в точках графика
    T_plot = zeros(length(x_plot), degree+1);
    T_plot(:,1) = 1;
    if degree >= 1
        T_plot(:,2) = x_plot_scaled;
    end
    for k = 2:degree
        T_plot(:,k+1) = 2*x_plot_scaled'.*T_plot(:,k) - T_plot(:,k-1);
    end
    y_cheb = T_plot * coeffs;
end

function evaluate_accuracy(x, y, name_of_method, fit_func)
    y_fit = fit_func(x);
    abs_errors = abs(y_fit - y);

    mae = mean(abs_errors);
    max_ae = max(abs_errors);
    
    fprintf('\nМетод: %s\n', name_of_method);
    fprintf('Средняя абсолютная ошибка (MAE): %.4f\n', mae);
    fprintf('Максимальная абсолютная ошибка: %.4f\n', max_ae);
end
