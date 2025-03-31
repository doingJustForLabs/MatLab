% lab3_4

% format long

syms b11 b12 b13 b14 b15 b16 b17 b21 b22 b23 b24 b25 b26 b27

% матрица  коэффициентов

A = [2 1 3 0 0 0;
    0 0 3 1 1 0;
    1 0 3 0 1 0;
    0 0 1 2 0 0;
    0 1 2 0 0 0;
    0 0 1 0 0 1;
    0 0 6 0 2 1];

rank_A = rank(A);
norm_A = norm(A);
% число обусловленности матрицы коэффициентов
cond_A1 = cond(A);


% [m, n] = size(A);
% 
% valid_submatrices = {};
% 
% 
% for row_idx = nchoosek(1:m, rank_A)  
%     for col_idx = nchoosek(1:n, rank_A)
% 
%         sub_matrix = A(row_idx, col_idx);
% 
%         if det(sub_matrix) ~= 0
%             valid_submatrices{end+1} = sub_matrix;
%         end
% 
%         if length(valid_submatrices) >= 2
%             break;
%         end
%     end
%     if length(valid_submatrices) >= 2
%         break;
%     end
% end
% 
% % выбор двух подматриц для задания  
% % first_submatrix = submatrices{2};       % Первая подматрица
% % second_submatrix = submatrices{end};    % Вторая подматрица
% 
% % Задаем индексы строк и столбцов для подматрицы (например, выбираем 5 строк и 5 столбцов)
% rows = [1, 3, 4, 5, 6];  % Индексы строк для подматрицы
% cols = [2, 3, 4, 5, 6];  % Индексы столбцов для подматрицы
% 
% % Получаем размер матрицы A
% 
% 
% 
% B = sym(zeros(2, 7));
% 
% % Заполняем матрицу B
% for i = 1:2
%     for j = 1:7
%         if i == 1 && j <= 5
%             % Строка 1, столбцы 1-5: b11, b12, b13, b14, b15
%             B(i,j) = sym(['b' num2str(i) num2str(j)]);
%         elseif i == 2 && j <= 5
%             % Строка 2, столбцы 1-5: b21, b22, b23, b24, b25
%             B(i,j) = sym(['b' num2str(i) num2str(j)]);
%         elseif i == 1 && j == 6
%             % Строка 1, столбец 6: 1
%             B(i,j) = 1;
%         elseif i == 1 && j == 7
%             % Строка 1, столбец 7: 0
%             B(i,j) = 0;
%         elseif i == 2 && j == 6
%             % Строка 2, столбец 6: 0
%             B(i,j) = 0;
%         elseif i == 2 && j == 7
%             % Строка 2, столбец 7: 1
%             B(i,j) = 1;
%         end
%     end
% end
% 
% % Выводим матрицу B
% disp('Матрица B:');
% disp(B);

B1 = [1 0 b13 b14 b15 b16 b17;
     0 1 b23 b24 b25 b26 b27];

B2 = [b11 1 0 b14 b15 b16 b17;
      b21 0 1 b24 b25 b26 b27];


system_first = B1 * A == 0;
sol1 = solve(system_first, [b13 b14 b15 b16 b17 b23 b24 b25 b26 b27])

system_second = B2 * A == 0;
sol2 = solve(system_second, [b11 b14 b15 b16 b17 b21 b24 b25 b26 b27])

% print(sol1)


chemicals = {'Na2CO3','HNO3','NaNO3','H2O','CO2','CaO','Ca(NO3)2'};

% Список коэффициентов
coeffs_1 = [sol1.b13, sol1.b14, sol1.b15, sol1.b16, sol1.b17, sol1.b23, sol1.b24, sol1.b25, sol1.b26, sol1.b27];
coeffs_2 = [sol2.b11, sol2.b14, sol2.b15, sol2.b16, sol2.b17, sol2.b21, sol2.b24, sol2.b25, sol2.b26, sol2.b27];
coeff_values_1 = double(coeffs_1);
coeff_values_2 = double(coeffs_2);
% Получаем числовые значения

% Подготовка к созданию матрицы B1
B1_1 = zeros(2, 7);  % Матрица B1 будет 2x7

% Заполняем строки B1 с помощью цикла
B1_1(1, :) = [1, 0, coeff_values_1(1), coeff_values_1(2), coeff_values_1(3), coeff_values_1(4), coeff_values_1(5)];
B1_1(2, :) = [0, 1, coeff_values_1(6), coeff_values_1(7), coeff_values_1(8), coeff_values_1(9), coeff_values_1(10)];

% Подготовка к созданию матрицы B2
B2_1 = zeros(2, 7);  % Матрица B2 будет 2x7

% Заполняем строки B2 с помощью цикла
B2_1(1, :) = [coeff_values_2(1), 1, 0, coeff_values_2(2), coeff_values_2(3), coeff_values_2(4), coeff_values_2(5)];
B2_1(2, :) = [coeff_values_2(6), 0, 1, coeff_values_2(7), coeff_values_2(8), coeff_values_2(9), coeff_values_2(10)];


% Вывод реакции для первой подматрицы (первая строка)
fprintf('Реакция для первой подматрицы:\n');
print_reaction(B1_1(1, :), chemicals, 1);

% Вывод реакции для первой подматрицы (вторая строка)
fprintf('Реакция для первой подматрицы\n');
print_reaction(B1_1(2, :), chemicals, 2);

% Вывод реакции для первой подматрицы (первая строка)
fprintf('Реакция для второй подматрицы:\n');
print_reaction(B2_1(1, :), chemicals, 3);

% Вывод реакции для первой подматрицы (вторая строка)
fprintf('Реакция для второй подматрицы:\n');
print_reaction(B2_1(2, :), chemicals, 4);

% Функция для вывода реакции в требуемом формате
function print_reaction(B, chemicals, reaction_num)
    fprintf('Реакция %d: ', reaction_num);
    
    % Перебираем химические вещества
    reaction_left = {};   % Левые реагенты
    reaction_right = {};  % Продукты реакции
    
    for i = 1:length(chemicals)
        coeff = B(i);  % Берем готовый коэффициент
        
        % Округляем коэффициенты и формируем строку
        if coeff < 0
            coeff = round(coeff, 2);  % Округляем до 2 знаков после запятой
            reaction_left{end+1} = sprintf('%g%s', -coeff, chemicals{i});  % %g для обычного представления
        elseif coeff > 0
            coeff = round(coeff, 2);  % Округляем до 2 знаков после запятой
            reaction_right{end+1} = sprintf('%g%s', coeff, chemicals{i});  % %g для обычного представления
        end
    end
    
    % Выводим левую и правую части реакции с "->" между ними
    fprintf('%s -> %s\n', strjoin(reaction_left, ' + '), strjoin(reaction_right, ' + '));
end