function [solX, solY, iter] = newton(x0, tol, max_iter)
    h = 1e-6;
    
    x = x0(1);
    y = x0(2);
    iter = 0;
    
    while iter < max_iter
        try
            [F, J] = numerical_jacobian(x, y, h);
            
            if cond(J) > 1e10
                solX = NaN; solY = NaN; return;
            end
            
            delta = -J \ F;
            x_new = x + delta(1);
            y_new = y + delta(2);
            
            if norm(delta) < tol
                solX = x_new;
                solY = y_new;
                return;
            end
            
            x = x_new;
            y = y_new;
            iter = iter + 1;
            
        catch
            solX = NaN; solY = NaN; return;
        end
    end
    
    % Если не сошлось
    solX = NaN; solY = NaN;

    function [F_val, J_val] = numerical_jacobian(x, y, h)
        F_val = equations([x; y]);
        
        % Частные производные по x
        F_xh = equations([x + h; y]);
        df_dx = (F_xh - F_val)/h;
        
        % Частные производные по y
        F_yh = equations([x; y + h]);
        df_dy = (F_yh - F_val)/h;
        
        J_val = [df_dx, df_dy];
    end
end