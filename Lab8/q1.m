clear;
clc;

% Вариант 1

x = [3.37;	5.84;	8.08;	9.83;	11.76;	12.15;	12.81;	13.25;	14.53];
y = [1.427;	13.471;	17.644;	42.907;	63.659;	71.609;	84.174;	98.402;	139.199];

p = [0.9; 0.2; 0.9; 0.7; 1; 0.7; 0.5; 0.9; 0.2];

n = length(x);

optimal_polynom = methods.create_diff_table(x, y, n);
m = optimal_polynom;

W = vander(x);
W = W(:, end-4:end);
coefficients = W \ y;

fprintf("Полином: P(x) = %.f6", coefficients(m+1))
for k = m:-1:1
    fprintf(' + %.6f x^%d', coefficients(k), m-k+1);
end
fprintf('\n');

model = @(params, x) params(1)*exp(params(2)*x) + params(3)*log(x);

error_func = @(params) sum(p .* (model(params, x) - y).^2);

initial_guess = [1, 0.1, 1];
optimal_params = fminsearch(error_func, initial_guess);

fprintf('Оптимальные параметры: a=%.4f, b=%.4f, c=%.4f\n', optimal_params);

xx = linspace(min(x), max(x), 300);
yy = model(optimal_params, xx);

y_spline = interp1(x, y, xx, "spline");
y_vander = polyval(coefficients, xx);

err = methods.error(x, y, coefficients);
fprintf('\nСредняя относительная ошибка в узлах (Вандермонд): %.2f%%\n', err);

figure
plot(x, y, 'o', "MarkerfaceColor", "b");
hold on;
plot(xx, y_spline, 'r-', "LineWidth", 1);
plot(xx, y_vander, 'r-', "LineWidth", 1);
plot(xx, yy, '-.', 'LineWidth', 1);
grid on;
legend('Данные', 'Сплайн', 'Вандермонд', 'fminsearch', 'Location', 'Best');