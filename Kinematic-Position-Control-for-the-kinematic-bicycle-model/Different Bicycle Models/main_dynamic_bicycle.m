%% dynamics bicycle main.m script
%%%%%%%%%%%%%%%%%%%%%%% 
% directly hit "Run" and you get everything
% Zhenghe Shangguan 
% zhenghe3
% 01/30/19

%% const & initial condition definition
% const define
Bf = 0.242; 
Cf = 1.352; 
Df = 2751.69; 
Ef = -0.392;
Br = 0.24;
Cr = 1.29;
Dr = 3113.08;
Er = 0.507;

af = 1.07;
ar = 0.936;
Iz = 552.718;
m = 645;

% the initial condition, all the following simulation starts with
% constant velocity v_const = 0.9 m/s, constant angular velocity r = 0.3 rad/s, initial pose = (0, 0 ,0).
v_const = 0.9;
v_dot = 0; % linear accelaration = 0
r = 0.3;
x0 = 0;
y0 = 0;
theta0 = 0;

%% CASE 1: STEP response with value = 1
% simulate the model
input_type = 1;
sim('BONUS_dynamics_bicycle'); % auto-solver, fixed-step = 0.002s
% plot
figure(1);
plot(bicycle_pose(:,1), bicycle_pose(:,2), '-.');
hold on
plot(bicycle_pose(:,1), bicycle_pose(:,3), '-.');
plot(bicycle_pose(:,1), bicycle_pose(:,4), '-.');
plot(bicycle_pose(:,1), bicycle_pose(:,5), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,6), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,7), 'b:');

% title, labels, legends
axis([0 5 -1 1.5]);
xlabel('time / s');
ylabel('value');
title('Dynamic Bicycle Pose with unit STEP input (value = 1, t0 = 0)');
legend('x', 'y', 'theta', 'r', 'v', 'Ref Input(delta)');

%% CASE 2: Impulse response with Amplitude = 1, period = 1, Pulse Width = 50%
% simulate the model
input_type = 2;
sim('BONUS_dynamics_bicycle');
% plot
figure(2);
plot(bicycle_pose(:,1), bicycle_pose(:,2), '-.');
hold on
plot(bicycle_pose(:,1), bicycle_pose(:,3), '-.');
plot(bicycle_pose(:,1), bicycle_pose(:,4), '-.');
plot(bicycle_pose(:,1), bicycle_pose(:,5), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,6), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,7), 'b:');

% title, labels, legends
axis([0 5 -1 1.5]);
xlabel('time / s');
ylabel('value');
title('Dynamic Bicycle Pose with unit Impulse input (amp = 1, period = 1, pulse width = 50%)');
legend('x', 'y', 'theta', 'r', 'v', 'Ref Input(delta)');

%% CASE 3: SINE (frequency) response with Amplitude = 1, requency = 5
% simulate the model
input_type = 3;
sim('BONUS_dynamics_bicycle');
% plot
figure(3);
plot(bicycle_pose(:,1), bicycle_pose(:,2), '-.');
hold on
plot(bicycle_pose(:,1), bicycle_pose(:,3), '-.');
plot(bicycle_pose(:,1), bicycle_pose(:,4), '-.');
plot(bicycle_pose(:,1), bicycle_pose(:,5), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,6), '--');
plot(bicycle_pose(:,1), bicycle_pose(:,7), 'b:');

% title, labels, legends
axis([0 5 -1 1.5]);
xlabel('time / s');
ylabel('value');
title('Dynamic Bicycle Pose with SINE frequency input (amp = 1, freq = 5)');
legend('x', 'y', 'theta', 'r', 'v', 'Ref Input(delta)');

