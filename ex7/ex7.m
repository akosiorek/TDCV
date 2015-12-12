
close all, clear all, clc
run('../vlfeat-0.9.20/toolbox/vl_setup');

%% ex1

A = [472.3       0.64     329.0;
       0.0     451.00     268.3;
       0.0       0.00       1.0];

% R = eye(3);
R = zeros(3, 1); % parametrization for euler angles
T = zeros(3, 1);


I0 = read_image('img_sequence/0000.png');
[m0, d0] = extract_sift(I0);
M0 = generalize(m0) / A';


%%% ex2
% consensus_points = zeros([45 size(M0)]);
% consensus_points(end, :, :, :) = M0;
% % h = figure(1);
% for n = 1:44
%     fprintf('Processing image %02d\n', n);
%     img_path = sprintf('img_sequence/%04d.png', n);
% 
%     I = read_image(img_path);
%     [m, d] = extract_sift(I);
%     matches = vl_ubcmatch(d0, d);
%     matched0 = m0(matches(1, :), :);
%     matched = m(matches(2, :), :);    
% 
%     [H, consensus] = RANSAC(matched0, matched, 10, 25, 1000);
%     matched0 = matched0(consensus, :);
%     matched = matched(consensus, :);
%     
%     m = size(consensus, 1);
%     consensus_points(n, 1:m, 1) = consensus;
%     consensus_points(n, 1:m, 2:end) = matched;
% %     showMatchedFeatures(I0, I, matched0, matched, 'montage');
% %     name = sprintf('0 - %02d', n)
% %     title(name)
% %     print(h, '-dpng', name)
% 
% end
% 
% save('consensus.mat', 'consensus_points')

%% ex3

load('consensus.mat')

Rs = zeros(44, 3);
Ts = zeros(44, 3);

options = optimset('MaxFunEvals', 1e6);

figure(2)
hold on
grid on
xlim([-3 3]);
ylim([-5 3]);
zlim([0 40]);
plot_camera(T, 0, R, 0);
for n = 1:44
    [M, m] = get_points_for_frame(consensus_points, n);
    X0 = [R; T];
    foo = @(X) energy(X(1:3), X(4:6), A, M, m);

    [X, e] = fminsearch(foo, X0, options);
    fprintf('Frame %02d\t energy = %02f\n', n, e);

    R = X(1:3);
    R = mod((R / (2*pi)), 1) * 2 * pi; 
    T_last = T;
    T = X(4:6);
    plot_camera(T, T_last, R, n);
%     drawnow();

    Rs(n, :) = R;
    Ts(n, :) = T;
end





