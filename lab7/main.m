x=[5999
    6199
    6399
    6599
    6799
    6999
    7199
    7399
    7599
    7799
    7999
    8199
    8399
    8599
    8799
    8999
    9199
    9399
    9599
    9799
    9999
 ];
y=[-29755.28447
-29850.80797
-29947.22362
-30044.52186
-30142.6889
-30241.70627
-30341.55026
-30442.19131
-30543.59347
-30645.71378
-30748.50171
-30851.89863
-30955.83732
-31060.24154
-31165.02581
-31270.09523
-31375.34555
-31480.66342
-31585.92691
-31691.00626
-31795.76492
];
x_test = [(x(1)+x(2))/2; (x(14)+x(15))/2];
fprintf("Тестовые точки:\n");
disp(table(x_test, 'VariableNames', {'x_test'}, 'RowNames', {'Между 1-2 узлами', 'Между 14-15 узлами'}));

x_plot = linspace(min(x), max(x), 1000)';

%% Канонический полином (Вандермонд)
n = length(x)-1;
V = zeros(length(x), n+1);
for i = 1:n+1
    V(:,i) = x.^(n+1-i);
end
a = V \ y; 
P_coeff = a';
disp('Коэффициенты полинома (от x^n до x^0):');
disp(P_coeff);
y_pred = polyval(P_coeff, x);
errors = y - y_pred;
fprintf('\nСтатистика ошибок для всех %d точек:\n', length(x));
fprintf('Средняя абсолютная ошибка: %.6f\n', mean(abs(errors)));
fprintf('Максимальная абсолютная ошибка: %.6f\n', max(abs(errors)));
fprintf('Стандартное отклонение ошибок: %.6f\n\n', std(errors));
y_pred_plot = polyval(P_coeff, x_plot);

%% Полином через polyfit
n = length(x)-1;
p_polyfit = polyfit(x, y, n);

fprintf('Интерполяционный полином %d-й степени\n', n);
fprintf('Коэффициенты (от x^%d до x^0):\n', n);
y_polyfit = polyval(p_polyfit, x_plot);

y_interp = polyval(p_polyfit, x);
errors = y - y_interp;

fprintf('\nСтатистика ошибок интерполяции:\n');
fprintf('Средняя абсолютная ошибка: %.6f\n', mean(abs(errors)));
fprintf('Максимальная абсолютная ошибка: %.6f\n', max(abs(errors)));

%% Оценка погрешности в тестовых точках
y_test_poly = polyval(p_polyfit, x_test);
y_test_exact = interp1(x, y, x_test, 'spline');

abs_errors = abs(y_test_exact - y_test_poly);
rel_errors = abs_errors ./ abs(y_test_exact) * 100;

error_table = table(x_test, y_test_exact, y_test_poly, abs_errors, rel_errors, ...
    'VariableNames', {'x', 'Точное_значение', 'Полином', 'Абс_ошибка', 'Отн_ошибка_проц'}, ...
    'RowNames', {'Точка1', 'Точка2'});

disp('Оценка погрешности интерполяции:');
disp(error_table);

%% Кубический сплайн через interp1 (степень 3)
y_cubic = interp1(x, y, x_plot, 'spline');

%% 5. Таблица конечных разностей и анализ
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

%% 3. Графики
figure('Position', [100, 100, 1200, 500]);
% subplot(1,2,1);
hold on;
plot(x, y, 'ko', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Узловые точки');
plot(x_plot, y_cubic, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Кубический сплайн (interp1)');
plot(x_plot, y_polyfit, 'r-', 'LineWidth', 2, 'DisplayName', 'Интерполяционный полином');
plot(x_test, y_test_poly, 'g*', 'MarkerSize', 10, 'DisplayName', 'Тестовые точки (полином)');
plot(x_test, y_test_exact, 'kx', 'MarkerSize', 10, 'DisplayName', 'Точные значения');
title('Сравнение методов интерполяции');
legend('Location', 'northwest');
grid on;