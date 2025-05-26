function [p_optimal, f_optimal, iterations, p_history] = gradient(f_handle, grad_handle, initial_point, learning_rate, tolerance, max_iterations)
    % Метод градиентного спуска для минимизации функции f(p) двух переменных.
    
    p_current = initial_point(:); 
    p_history = p_current;      
    iterations = 0;
    for k = 1:max_iterations
        iterations = k;
        
        gradient_val = grad_handle(p_current); 
        
        p_next = p_current - learning_rate * gradient_val; 
        
        p_history = [p_history, p_next];
        
        % Критерий остановки: норма разницы между текущей и следующей точкой
        if norm(p_next - p_current) < tolerance
            p_current = p_next; % Обновляем текущую точку перед выходом
            break;
        end
        
        p_current = p_next;
    end
    
    p_optimal = p_current;
    f_optimal = f_handle(p_optimal);
end