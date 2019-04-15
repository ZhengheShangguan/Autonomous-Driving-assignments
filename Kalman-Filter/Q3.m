clc
clear
close all

%% Initialization

% System dynmaics:
A_ideal = [0 1; 0 0];
A_real = [0 1 0; 0 0 1; 0 0 0];
B_ideal = [0; 1];
B_real = [0 0 0; 1 1 0; 0 0 1];
C_ideal = [0 1];
C_real = [0 1 0];
D = 0;

% Initial values:
x_real = [0;0;0];
x_ideal = [0;0]; % For groundtruth reference

% Discrete system parameters
t = 0;
dt = 0.01;
tf = 600/dt;

% Discrete propagation
Ad_ideal = expm(A_ideal * dt);
Ad_real = expm(A_real * dt);
Bd_ideal = B_ideal * dt;
Bd_real = B_real * dt;

% Noise parameters 
sigma_w = sqrt(2.1*10e-6); % process noise variance
sigma_z = sqrt(3.4*10e-3); % measurement noise variance
process_noise_array = normrnd(0, sigma_w, [1, tf]);
measure_noise_array = normrnd(0, sigma_z, [1, tf]);

% Plotting variables
x_real_plot = zeros(3,tf); 
x_ideal_plot = zeros(2,tf);
error = zeros(tf+1,1); 
t_plot = zeros(tf,1);


%% Main
for tk = 1:tf
    % Inputs
    input = sin(0.005*tk*dt);

    % System with noise 
    process_noise = process_noise_array(tk);
    measure_noise = measure_noise_array(tk);
    u_real = [input; process_noise; measure_noise];
    x_real = Ad_real * x_real + Bd_real * u_real;
    
    % Ideal system (For groundtruth reference)
    u_ideal = input;
    x_ideal = Ad_ideal * x_ideal + Bd_ideal * u_ideal;
  
    % Error accumulation
    y_real = C_real * x_real;
    y_ideal = C_ideal * x_ideal;
    % The accumulation of error is the error of position
    error(tk+1) = error(tk) + (y_real - y_ideal)*dt; 
    t = t+dt;
    
    % Store for plotting
    x_real_plot(:,tk) = x_real;
    x_ideal_plot(:,tk) = x_ideal;
    t_plot(tk) = t;
end


%% Plotting

figure(1)
subplot(211)
plot(t_plot,x_ideal_plot(1,:),t_plot,x_real_plot(1,:))
title('State Estimate')
ylabel('position')
legend('Groundtruth','Real System')
subplot(212)
plot(t_plot,x_ideal_plot(2,:),t_plot,x_real_plot(2,:))
ylabel('velocity')
legend('Groundtruth','Real System')
xlabel('time (sec)')

figure(2)
plot(t_plot,error(1:tf))
title('Estimation error caused by integration')
ylabel('integral error')
xlabel('time (sec)')
