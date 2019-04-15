%% kinematic bicycle main.m script
%%%%%%%%%%%%%%%%%%%%%%% 
% directly hit "Run" and you get everything
% Zhenghe Shangguan 
% zhenghe3
% 01/30/19

%% const & initial condition definition
% const define
l_f = 1.07;
l_r = 0.936;
% the initial condition, all the following simulation starts with
% constant velocity = 1 m/s, initial pose = (0, 0 ,0).
v_const = 1; 
x_init = 0;
y_init = 0;
psi_init = 0;

%% CASE 1: STEP response with value = 1
% simulate the model
input_type = 1;
sim('kinematic_bicycle'); % auto-solver, fixed-step = 0.002s
% plot
figure(1);
plot(bicycle_pose(:,1), bicycle_pose(:,2), '-.');
hold on
plot(bicycle_pose(:,1), bicycle_pose(:,3), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,4), '-');
plot(bicycle_pose(:,1), bicycle_pose(:,5), ':');
% title, labels, legends
xlabel('time / s');
ylabel('value')
title('Bicycle Pose with unit STEP input (value = 1, t0 = 0)');
legend('x', 'y', '\psi', 'Ref Input');

%% CASE 2: Impulse response with Amplitude = 1, period = 1, Pulse Width = 50%
% simulate the model
input_type = 2;
sim('kinematic_bicycle');
% plot
figure(2);
plot(bicycle_pose(:,1), bicycle_pose(:,2), '-.');
hold on
plot(bicycle_pose(:,1), bicycle_pose(:,3), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,4), '-');
plot(bicycle_pose(:,1), bicycle_pose(:,5), ':');
xlabel('time / s');
ylabel('value')
title('Bicycle Pose with unit Impulse input (amp = 1, period = 1, pulse width = 50%)');
legend('x', 'y', '\psi', 'Ref Input');

%% CASE 3: SINE (frequency) response with Amplitude = 1, requency = 5
% simulate the model
input_type = 3;
sim('kinematic_bicycle');
% plot
figure(3);
plot(bicycle_pose(:,1), bicycle_pose(:,2), '-.');
hold on
plot(bicycle_pose(:,1), bicycle_pose(:,3), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,4), '-');
plot(bicycle_pose(:,1), bicycle_pose(:,5), ':');
xlabel('time / s');
ylabel('value')
title('Bicycle Pose with SINE frequency input (amp = 1, freq = 5)');
legend('x', 'y', '\psi', 'Ref Input');

