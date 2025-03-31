f1=@(x) (-2*exp(x)+10 - sin(x));
df1 = @(x) -2*exp(x) - cos(x);

% Основной код

a = 0;
b = 10;
eps_local = 1e-2;

[root_local, iter_local] = polovin_del(@f, a, b, eps_local);  % Используем функцию f

disp(['Локализованный корень методом дихотомии: ', num2str(root_local(end))]);
disp(['Количество итераций в методе дихотомии: ', num2str(iter_local)]);

root_local_end = root_local(end);

root_fzero = solve_fzero(f1, a, b);
root_fsolve = solve_fsolve(f1, root_local_end);
eps_res = 1e-10;

[root_mpi, iter_mpi] = mpi(@f, root_local_end, eps_res, @g);  % Используем функцию g
disp(['Локализованный корень МПИ: ', num2str(root_mpi(end))]);
disp(['Количество итераций в МПИ: ', num2str(iter_mpi)]);

[root_sec, iter_sec] = sec_method(@f, root_local_end, eps_res);  % Используем функцию f
disp(['Локализованный корень методом секущих: ', num2str(root_sec(end))]);
disp(['Количество итераций в методе секущих: ', num2str(iter_sec)]);

[root_newton, iter_newton] = newton_method(f1, df1, root_local_end, eps_res);
disp(['Локализованный корень методом касательных: ', num2str(root_newton(end))]);
disp(['Количество итераций в методе касательных: ', num2str(iter_newton)]);

[root_hord, iter_hord] = hord_method(@f, a, b, eps_res);
disp(['Локализованный корень методом хорд: ', num2str(root_hord(end))]);
disp(['Количество итераций в методе хорд: ', num2str(iter_hord)]);

function y = f(x)
    y = -2*exp(x) + 10 - sin(x);
end

% Определение функции g(x)
function g_val = g(x)
    g_val = log((10 - sin(x)) / 2);
end

function root_fzero = solve_fzero(f, a, b)
    root_fzero = fzero(f, [a, b]);
    disp(['Корень, найденный с помощью fzero: ', num2str(root_fzero)]);
end

function root_fsolve = solve_fsolve(f, x0)
    options = optimset('Display', 'off');
    root_fsolve = fsolve(f, x0, options);
    disp(['Корень, найденный с помощью fsolve: ', num2str(root_fsolve)]);
end