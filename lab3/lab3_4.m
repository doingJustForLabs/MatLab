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
cond_A = cond(A);

B1 = [1 0 b13 b14 b15 b16 b17;
     0 1 b23 b24 b25 b26 b27];

B2 = [b11 1 0 b14 b15 b16 b17;
      b21 0 1 b24 b25 b26 b27];


system_first = B1 * A == 0;
sol1 = solve(system_first, [b13 b14 b15 b16 b17 b23 b24 b25 b26 b27]);

system_second = B2 * A == 0;
sol2 = solve(system_second, [b11 b14 b15 b16 b17 b21 b24 b25 b26 b27]);

% print(sol1)
disp("Матрица коэффициентов");
disp(A);
fprintf('\nОбусловленность матрицы коэффициентов %.5f\n\n', cond_A);

chemicals = {'Na2CO3','HNO3','NaNO3','H2O','CO2','CaO','Ca(NO3)2'};

% Список коэффициентов
coeffs_1 = [sol1.b13, sol1.b14, sol1.b15, sol1.b16, sol1.b17, sol1.b23, sol1.b24, sol1.b25, sol1.b26, sol1.b27];
coeffs_2 = [sol2.b11, sol2.b14, sol2.b15, sol2.b16, sol2.b17, sol2.b21, sol2.b24, sol2.b25, sol2.b26, sol2.b27];
coeff_values_1 = double(coeffs_1);
coeff_values_2 = double(coeffs_2);

B1_1 = zeros(2, 7);

% Заполняем строки B1 с помощью цикла
B1_1(1, :) = [1, 0, coeff_values_1(1), coeff_values_1(2), coeff_values_1(3), coeff_values_1(4), coeff_values_1(5)];
B1_1(2, :) = [0, 1, coeff_values_1(6), coeff_values_1(7), coeff_values_1(8), coeff_values_1(9), coeff_values_1(10)];


B2_1 = zeros(2, 7);

B2_1(1, :) = [coeff_values_2(1), 1, 0, coeff_values_2(2), coeff_values_2(3), coeff_values_2(4), coeff_values_2(5)];
B2_1(2, :) = [coeff_values_2(6), 0, 1, coeff_values_2(7), coeff_values_2(8), coeff_values_2(9), coeff_values_2(10)];

% fprintf('Реакция для первой подматрицы:\n');
print_reaction(B1_1(1, :), chemicals, 1);

% fprintf('Реакция для первой подматрицы\n');
print_reaction(B1_1(2, :), chemicals, 2);

% fprintf('Реакция для второй подматрицы:\n');
print_reaction(B2_1(1, :), chemicals, 3);

% fprintf('Реакция для второй подматрицы:\n');
print_reaction(B2_1(2, :), chemicals, 4);

function print_reaction(B, chemicals, reaction_num)
    fprintf('Реакция %d: ', reaction_num);
    
    reaction_left = {};   % Левые реагенты
    reaction_right = {};  % Продукты реакции
    
    for i = 1:length(chemicals)
        coeff = B(i);
        
        % Округляем коэффициенты и формируем строку
        % if coeff == 1
        %     reaction_left{end+1} = sprintf('%s', chemicals{i});
        % elseif coeff == -1
        %     reaction_right{end+1} = sprintf('%s', chemicals{i});
        if coeff > 0
            reaction_right{end+1} = sprintf('%g%s', coeff, chemicals{i});  % %g для обычного представления
        elseif coeff < 0
            reaction_left{end+1} = sprintf('%g%s', -coeff, chemicals{i});  % %g для обычного представления

        end
    end
    
    fprintf('%s -> %s\n', strjoin(reaction_left, ' + '), strjoin(reaction_right, ' + '));
end