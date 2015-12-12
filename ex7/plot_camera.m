function plot_camera(T, T_last, R, num)
    
    text(T(1), T(2), T(3), num2str(num));
    plotCamera('Location', T, 'Orientation', rotation_euler(R), 'Size', 0.05, 'Opacity', 0);
    if numel(T_last) == 3
        plot3([T_last(1) T(1)], [T_last(2) T(2)], [T_last(3) T(3)])
    end
end