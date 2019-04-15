%% Differential Steer main.m script
%%%%%%%%%%%%%%%%%%%%%%% 
% directly hit "Run" and you get everything
% Zhenghe Shangguan 
% zhenghe3
% 01/30/19

%% const & initial condition definition
% const define
B = 0.5;
% the initial condition, all the following simulation starts with
% Right Tyre constant velocity = 1.5 m/s, 
% initial pose (x0, y0, theta0) = (0, 0, 0).
v_R = 1.5;
x0 = 0;
y0 = 0;
theta0 = 0;

%% CASE 1: STEP response with value = 1
% simulate the model
input_type = 1;
sim('differential_steer'); % auto-solver, fixed-step = 0.002s
% plot
figure(1);
plot(steer_pose(:,1), steer_pose(:,2), '-.');
hold on
plot(steer_pose(:,1), steer_pose(:,3), '--');
plot(steer_pose(:,1), steer_pose(:,4), '-');
plot(steer_pose(:,1), steer_pose(:,5), '--');
plot(steer_pose(:,1), steer_pose(:,6), 'k:');
plot(steer_pose(:,1), steer_pose(:,7), 'm:');
% title, labels, legends
xlabel('time / s');
ylabel('value')
title('Steer Pose with unit STEP input (value = 1, t0 = 0)');
legend('x', 'y', '\theta', 'R', 'v_L', 'v_R');

%% CASE 2: Impulse response with Amplitude = 1, period = 1, Pulse Width = 50%
% simulate the model
input_type = 2;
sim('differential_steer');
% plot
figure(2);
plot(steer_pose(:,1), steer_pose(:,2), '-.');
hold on
plot(steer_pose(:,1), steer_pose(:,3), '--');
plot(steer_pose(:,1), steer_pose(:,4), '-');
plot(steer_pose(:,1), steer_pose(:,5), '--');
plot(steer_pose(:,1), steer_pose(:,6), 'k:');
plot(steer_pose(:,1), steer_pose(:,7), 'm:');
xlabel('time / s');
ylabel('value')
title('Steer Pose with unit Impulse input (amp = 1, period = 1, pulse width = 50%)');
legend('x', 'y', '\theta', 'R', 'v_L', 'v_R');

%% CASE 3: SINE (frequency) response with Amplitude = 1, requency = 5
% simulate the model
input_type = 3;
sim('differential_steer');
% plot
figure(3);
plot(steer_pose(:,1), steer_pose(:,2), '-.');
hold on
plot(steer_pose(:,1), steer_pose(:,3), '--');
plot(steer_pose(:,1), steer_pose(:,4), '-');
plot(steer_pose(:,1), steer_pose(:,5), '--');
plot(steer_pose(:,1), steer_pose(:,6), 'k:');
plot(steer_pose(:,1), steer_pose(:,7), 'm:');
xlabel('time / s');
ylabel('value')
title('Steer Pose with SINE frequency input (amp = 1, freq = 5)');
legend('x', 'y', '\theta', 'R', 'v_L', 'v_R');
