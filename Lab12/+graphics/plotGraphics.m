function plotGraphics(x_data, y_data, legends, title_str, xlabel_str, ylabel_str)
    figure; 
    hold on; 
    colors = lines(length(x_data)); 

    for i = 1:length(x_data)
        plot(x_data{i}, y_data{i}, 'LineWidth', 1.5, 'Color', colors(i,:));
    end

    title(title_str);
    xlabel(xlabel_str);
    ylabel(ylabel_str);
    legend(legends, 'Location', 'best'); 
    grid on; 
    hold off; 
end