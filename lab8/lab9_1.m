x = [0.31,	3.27,	3.42,	6.05,	6.64,	7.17,	10.48,	11.21,	13.54];
y = [5.222,	5.971,	6.527,	13.391,	15.736,	19.344,	57.370,	96.146,	134.715];
p = [0.9,	0.2,	0.8,	1,	0.9,	0.8,	1,	0.7,    0.2];

optimal_degree = find_optimal(y);

x_plot = linspace(min(x), max(x), 1000);

[y_fmin, coefficients] = polyfit_fminsearch(x, y, p, optimal_degree, x_plot);
disp('Коэффициенты полинома:');
disp(coefficients);

P_proiz1 = @(x) polyval(polyder(coefficients), x);

P_proiz2 = @(x) polyval(polyder(polyder(coefficients)), x);

% точки, в которых необходимо вычислить произвоные (между 1 и 2 и между предпоследней и последней)
x1 = (x(1) + x(2)) / 2;
x2 = (x(end-1) + x(end)) / 2;

proiz1_x1 = P_proiz1(x1);
proiz1_x2 = P_proiz1(x2);
proiz2_x1 = P_proiz2(x1);
proiz2_x2 = P_proiz2(x2);

disp(['Первая производная в x1 = ', num2str(x1), ': ', num2str(proiz1_x1)]);
disp(['Первая производная в x2 = ', num2str(x2), ': ', num2str(proiz1_x2)]);
disp(['Вторая производная в x1 = ', num2str(x1), ': ', num2str(proiz2_x1)]);
disp(['Вторая производная в x2 = ', num2str(x2), ': ', num2str(proiz2_x2)]);

% Оценка погрешности
n = length(x) - 1;
[error_der1_x1] = error_deriv(x, y, x1, n);
[error_der1_x2] = error_deriv(x, y, x2, n);

disp(['Погрешность первой производной у x1 = ', num2str(x1), ': ', num2str(error_der1_x1)]);
disp(['Погрешность первой производной у x2 = ', num2str(x2), ': ', num2str(error_der1_x2)]);

figure;
plot(x, y, 'o', 'MarkerSize', 8, 'DisplayName', 'Исходные данные');
hold on;
plot(x_plot, y_fmin, 'black--', 'LineWidth', 2, 'DisplayName', 'Аппроксимационный полином');
plot(x1, polyval(coefficients, x1), 'r*', 'MarkerSize', 10, 'DisplayName', ['x=', num2str(x1)]);
plot(x2, polyval(coefficients, x2), 'g*', 'MarkerSize', 10, 'DisplayName', ['x=', num2str(x2)]);
xlabel('x'); ylabel('y'); title('Аппроксимация с весами и переменным шагом');
legend('show'); grid on;

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

function [y_fmin, coefficients] = polyfit_fminsearch(x, y, weights, degree, x_plot)
    poly_func = @(params, x) polyval(params, x);
    
    error_func = @(params) sum(weights .* (poly_func(params, x) - y).^2);
    
    initial_guess = polyfit(x, y, degree);
    
    coefficients = fminsearch(error_func, initial_guess);
    
    y_fmin = poly_func(coefficients, x_plot);
end

function [error_der1] = error_deriv(x, y, x_point, n)
    divided_diff = y;
    for k = 1:n
        for i = 1:n-k+1
            divided_diff(i) = (divided_diff(i+1) - divided_diff(i)) / (x(i+k) - x(i));
        end
    end
    f_n1 = divided_diff(1); % f[x_0, x_1, ..., x_n] ~ f^{(n)} / n!

    % Вычисление Π_{n+1}(x) = (x - x_0)(x - x_1)...(x - x_n)
    Pi_n1 = @(x_p) prod(x_p - x(1:n+1));

    % Погрешность первой производной (формула 13.28 из 9 занятия)
    error_der1 = (f_n1 / factorial(n+1)) * Pi_n1(x_point)... 
                + (divided_diff(1) / factorial(n+2)) * Pi_n1(x_point);
end