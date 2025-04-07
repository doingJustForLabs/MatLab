function graphic(f1, f2)
    figure;
    fimplicit(f1, [-2.5 2.5 -4 6], 'r');
    hold on;
    fplot(f2, [-sqrt(6) sqrt(6)], 'b');
    xlabel('x'); 
    ylabel('y');
    legend('(1.5x)^{6} + (y-1)^{6} = 3.6^{6}', 'y = x^{3/2} + sqrt(5.5-x^2)sin(5πx)');
    title('Графики уравнений системы');
    
    yline(0, 'k', 'LineWidth', 0.5); % Черная линия y = 0
    xline(0, 'k', 'LineWidth', 0.5); % Черная линия x = 0
    grid on;
end

