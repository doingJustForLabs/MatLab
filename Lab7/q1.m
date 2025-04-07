clear;
clc;

% Вариант 73

x = [3.33;	7.47;	8.54;	9.18;	10.48;	13.97;	14.81;	15.74;	17.21];

y = [7.057;	26.442;	31.459;	50.167;	78.736;	228.149; 294.174; 363.138; 408.751];

% Степень полинома
n = 8;

W = vander(x);
% W = W(:, end-n:end);

coefficients = W \ y;

fprintf("Полином: P(x) = %.f6", coefficients(n+1))
for k = n:-1:1
    fprintf(' + %.6f x^%d', coefficients(k), n-k+1);
end
fprintf('\n');

x_lin = linspace(min(x), max(x), 100);
y_pol = polyval(coefficients, x_lin);
y_spline = spline(x, y, x_lin);

figure;
plot(x, y, 'o', 'MarkerFaceColor', 'b');
hold on;
plot(x_lin, y_pol, 'r-', 'LineWidth', 1);
plot(x_lin, y_spline, 'k-', 'LineWidth', 1);
xlabel('Температура (C)');
ylabel('Вязкость (сP)');
title('Аппроксимация полиномом 3-й степени');
grid on;
legend('Данные', 'Полином', "Сплайн", 'Location', 'Best');

fprintf("Таблица конечных разностей\n");

n = length(y);

diff_table = zeros(n, n);
diff_table(:, 1) = y(:);

for j = 2:n
    for i = 1:n - j + 1
        diff_table(i, j) = diff_table(i + 1, j - 1) - diff_table(i, j - 1);
    end
end

disp(diff_table);


