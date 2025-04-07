function [solX, solY, iter] = simple(x0, y0, accuracy, max_iter)
    x = x0;
    y = y0;
    iter = 0;

    while iter < max_iter
        y_new = (x.^(3/2) + sqrt(5.5 - x.^2)*sin(5*pi*x));
        x_new = (1.5*x).^6 + (y-1).^6 == 3.6.^6;
        
        if norm([x_new - x, y_new - y]) < accuracy
            solX = x_new; 
            solY = y_new; 
            return;
        end

        x = x_new;
        y = y_new;
        iter = iter + 1;
    end

    solX = NaN; solY = NaN;
end