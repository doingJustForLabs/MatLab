x0 = [1; 4];
eps = 1e-10;
max_iter = 100;
options = optimoptions('fsolve', 'Display', 'iter-detailed', 'Algorithm','trust-region-dogleg');
solution = fsolve(@equations, x0, options);

fprintf('Решение: x = %.6f, y = %.6f\n', solution(1), solution(2));
residual = equations(solution);
fprintf('Невязка: F1 = %.6f, F2 = %.6f\n\n', residual(1), residual(2));

syms x y
eqns = [y == (2 - 3*sin(x).*cos(x)).^(1/3), y == (3*x + sin(x) - 5) / 2];
vars = [x y];

[solX, solY] = vpasolve(eqns, vars);
[solX_mpi, xolY_mpi, iter_mpi] = mpi(x0, eps, max_iter);
[solX_newton, solY_newton, iter_newton] = newton(x0, eps, max_iter);
 
fprintf('vpasolve:\n');
fprintf('x = %.8f, y = %.8f\n\n', solX, solY);

fprintf('Метод простых итераций:\n');
fprintf('x = %.8f, y = %.8f, итераций: %d\n', solX_mpi, xolY_mpi, iter_mpi);
    
fprintf('Метод Ньютона:\n');
fprintf('x = %.8f, y = %.8f, итераций: %d\n', solX_newton, solY_newton, iter_newton);


sol_mpi = [solX_mpi, xolY_mpi];
sol_newton = [solX_newton, solY_newton];
grafik(sol_mpi, sol_newton);

analyze_convergence();

% function F = equations(vars)
%     x = vars(1);
%     y = vars(2);
% 
%     % Система уравнений:
%     F = [
%         y^3 + 3*sin(x)*cos(x) - 2;
%         2*y - (3*x + sin(x) - 5)
%     ];
% end