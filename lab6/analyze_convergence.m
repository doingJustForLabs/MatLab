function analyze_convergence()
    [x_grid, y_grid] = meshgrid(linspace(-5, 5, 200));
    
    mpi_mask = zeros(size(x_grid));
    newton_mask = zeros(size(x_grid));
    
    h = 1e-6; % Шаг
    
    for i = 1:numel(x_grid)
        try
            x_val = x_grid(i);
            y_val = y_grid(i);
            
            % 3. Проверка условий МПИ
            g1 = @(x,y) (2 - 3*sin(x)*cos(x))^(1/3);
            g2 = @(x,y) (2*y + 5 - sin(x))/3;
            
            J11 = (g1(x_val+h, y_val) - g1(x_val-h, y_val))/(2*h);
            J12 = (g1(x_val, y_val+h) - g1(x_val, y_val-h))/(2*h);
            J21 = (g2(x_val+h, y_val) - g2(x_val-h, y_val))/(2*h);
            J22 = (g2(x_val, y_val+h) - g2(x_val, y_val-h))/(2*h);
            
            J_mpi = [J11, J12; J21, J22];
            mpi_mask(i) = max(abs(eig(J_mpi))) < 1; % Спектральный радиус < 1
            
            % 4. Проверка условий Ньютона
            F = @(x,y) [y^3 + 3*sin(x)*cos(x) - 2;
                        2*y - (3*x + sin(x) - 5)];
            
            J = zeros(2,2);
            F0 = F(x_val, y_val);
            Fx = F(x_val + h, y_val);
            Fy = F(x_val, y_val + h);
            
            J(:,1) = (Fx - F0)/h; % df/dx
            J(:,2) = (Fy - F0)/h; % df/dy
            
            newton_mask(i) = abs(det(J)) > 1e-10 && all(isfinite(J(:)));
            
        catch
            mpi_mask(i) = 0;
            newton_mask(i) = 0;
        end
    end
    
    figure('Position', [100 100 800 600]);
    
    % График областей сходимости
    subplot(2,1,1);
    hold on;
    
    % Только точки, где есть сходимость
    mpi_mask = mpi_mask & ~isnan(mpi_mask);
    newton_mask = newton_mask & ~isnan(newton_mask);
    
    contourf(x_grid, y_grid, mpi_mask, [0.5 1.5], ...
             'FaceColor', 'green', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    contourf(x_grid, y_grid, newton_mask, [0.5 1.5], ...
             'FaceColor', 'blue', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    
    fimplicit(@(x,y) y.^3 + 3*sin(x).*cos(x) - 2, [-5 5], 'r', 'LineWidth', 1);
    fimplicit(@(x,y) 2*y - (3*x + sin(x) - 5), [-5 5], 'm', 'LineWidth', 1);
    
    title('Области сходимости методов');
    xlabel('x'); ylabel('y');
    legend('МПИ сходится', 'Ньютон сходится', 'F1=0', 'F2=0');
    grid on;
    
    % График решений
    subplot(2,1,2);
    hold on;
    
    f_solve = @(v) [v(2)^3 + 3*sin(v(1))*cos(v(1)) - 2;
                    2*v(2) - (3*v(1) + sin(v(1)) - 5)];
    sol = fsolve(f_solve, [1; 1], optimset('Display', 'off'));
    
    fimplicit(@(x,y) y.^3 + 3*sin(x).*cos(x) - 2, [-5 5], 'r');
    fimplicit(@(x,y) 2*y - (3*x + sin(x) - 5), [-5 5], 'm');
    plot(sol(1), sol(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
    
    title('Решение системы');
    xlabel('x'); ylabel('y');
    legend('F1=0', 'F2=0', 'Решение');
    grid on;
end