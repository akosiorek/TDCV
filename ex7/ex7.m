
close all, clear all, clc
run('../vlfeat-0.9.20/toolbox/vl_setup');

%% ex1

N = 44;
A = [472.3       0.64     329.0;
       0.0     471.00     268.3;
       0.0       0.00       1.0];

% % euler angles
% R = zeros(3, 1); 
% angle_fun = @(x, p) rotation_euler(x, p);
% 
% % quaternions
% R = zeros(4, 1);
% R(1) = 1;
% angle_fun = @(x, p) rotation_quaternion(x, p);

% exponential map
R = zeros(3, 1); 
angle_fun = @(x) exp_map(x);


T = zeros(3, 1);


I0 = read_image('img_sequence/0000_crop.png');
[m0, d0] = extract_sift(I0);
M0 = generalize(m0) / A';




%% ex3

load('consensus.mat')

options = optimset('MaxFunEvals', 1e6, 'MaxIter', 1e4);

figure(2)
hold on
grid on
% plot_camera(T, 0, R, 0, angle_fun);
for n = 1:N
    [M, m] = get_points_for_frame(consensus_points, n);
    X0 = [T; R];
    foo = @(X) energy(X(4:end), X(1:3), A, M, m, angle_fun);

    fprintf('Frame %02d', n);
    [X, e] = fminsearch(foo, X0, options);
    fprintf('\t energy = %02f\n', e);

    T_last = T;
    T = X(1:3);
    R = X(4:end);
    theta = norm(R);
%     if theta > 2 * pi
%         R = (1 - 2 * pi / theta) * R;
%     end
%     R = mod((R / (2*pi)), 1) * 2 * pi; 
    
    
    plot_camera(T, T_last, R, n, angle_fun);
%     drawnow();
end





