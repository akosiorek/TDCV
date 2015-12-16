function X = camera_location(R, T, angle_fun)
    X = - angle_fun(R)' * T;
end