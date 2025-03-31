function [solX, solY, iter] = mpi(x0, tol, max_iter)
    x = x0(1);
    y = x0(2);
    iter = 0;
    
    while iter < max_iter
        y_new = (2 - 3*sin(x)*cos(x))^(1/3);
        x_new = (2*y + 5 - sin(x)) / 3;
        
        if norm([x_new - x, y_new - y]) < tol
            solX = x_new; solY = y_new; return;
        end
        
        x = x_new;
        y = y_new;
        iter = iter + 1;
    end
    
    solX = NaN; solY = NaN;
end