function diagonal_dominance_solver()
    % Исходная матрица matrix и вектор b
    matrix = [2 4 2 6;
             3 10 4 2;
             1 4 8 3;
             2 4 1 5];
    
    b = [0; 0; 0; 0]; % Вектор b (пока не используется)

    % Запрашиваем номер строки для проверки
    k = input('Введите номер строки (1, 2, 3, 4): ');
    
    % Диапазон перебора для A, B, C, D
    N = 5;
    
    % Перебор всех возможных комбинаций A, B, C, D
    for A = -N:N
        for B = -N:N
            for C = -N:N
                for D = -N:N
                    % Вычисляем новые коэффициенты
                    d1 = abs(A * matrix(1, 1) + B * matrix(2, 1) + C * matrix(3, 1) + D * matrix(4, 1));
                    d2 = abs(A * matrix(1, 2) + B * matrix(2, 2) + C * matrix(3, 2) + D * matrix(4, 2));
                    d3 = abs(A * matrix(1, 3) + B * matrix(2, 3) + C * matrix(3, 3) + D * matrix(4, 3));
                    d4 = abs(A * matrix(1, 4) + B * matrix(2, 4) + C * matrix(3, 4) + D * matrix(4, 4));
                    
                    % Проверяем условие диагонального преобладания
                    if k == 1
                        condition = d1 > d2 + d3 + d4;
                    elseif k == 2
                        condition = d2 > d1 + d3 + d4;
                    elseif k == 3
                        condition = d3 > d1 + d2 + d4;
                    elseif k == 4
                        condition = d4 > d1 + d2 + d3;
                    else
                        error('Некорректный номер строки');
                    end
                    
                    % Если условие выполнено, выводим результат
                    if condition
                        fprintf('Найдено решение: A = %d, B = %d, C = %d, D = %d\n', A, B, C, D);
                        fprintf('Новые коэффициенты: d1 = %.4f, d2 = %.4f, d3 = %.4f, d4 = %.4f\n', d1, d2, d3, d4);
                    end
                end
            end
        end
    end
end