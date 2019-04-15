clc;
clear;
close all;

%% Initialization

% System dynmaics:
C = [1 0 0];

% Initial values:
x_ref = [0;0;0]; % For correction reference
x_kf = [0;0;0]; % Initialize the state estimate          
y_ref = 0;
y_kf = 0;

% Discrete system parameters
t = 0;
dt = 0.01;
tf = 600/dt;

% Discrete propagation
Ad_ref = [1 dt -dt*dt/2; 0 1 -dt; 0 0 1];
Ad_kf = [1 dt -dt*dt/2; 0 1 -dt; 0 0 1];
Bd_ref = [dt*dt/2; dt; 0];
Bd_kf = [dt*dt/2 0 0; dt dt 0; 0 0 dt];

% Noise parameters 
sigma_w = sqrt(2.1*10e-6); % IMU & GPS process noise variance
sigma_z = sqrt(3.4*10e-3); % IMU measurement noise variance
sigma_g = sqrt(5); % GPS measurement noise variance
process_noise_array = normrnd(0, sigma_w, [1, tf]);
measure_noise_array = normrnd(0, sigma_z, [1, tf]);
position_noise_array = normrnd(0, sigma_g, [1, tf]);

% Matrices
Qd = [(dt^4)*(sigma_g^2)/4 (dt^3)*(sigma_g^2) 0; (dt^3)*(sigma_g^2)/2 (dt^2)*(sigma_g^2)/2 0; 0 0 0]; % Discrete time Q matrix
R = [sigma_z]; % R matrix represents the confidence in the measurements from the correcting sensor
P = eye(3); % Initialize covariance matrix P, can be adjusted

% Plotting variables
x_estimated_plot = zeros(3,tf);
x_plot = zeros(3,tf);
t_plot = zeros(tf,1);
P11 = zeros(tf,1);
P22 = zeros(tf,1);
P33 = zeros(tf,1);
correction_count = 0;


%% Main
for tk = 1:tf
    % Inputs
    input = sin(0.005 * tk * dt);
    
    % Noise update
    process_noise = process_noise_array(tk);
    measure_noise = measure_noise_array(tk);
    position_noise = position_noise_array(tk);
    
    % Reference system (with GPS poistion noise)
    u_ref = [input];
    x_ref = Ad_ref * x_ref + Bd_ref * u_ref;
    y_ref = C * x_ref;
    
    % Kalman filter
    % -------------------------------------------------------------- %
    % Prediction
    u_kf = [input; process_noise; measure_noise];
    x_kf = Ad_kf * x_kf + Bd_kf * u_kf;
    y_kf = C * x_kf;
    
    % Predict error covariance
    P = Ad_kf * P * (Ad_kf') + Qd;

    % Correction at 1Hz
    if rem(tk,100) == 0
        K = P * (C') * inv(C*P*(C') + R); % Update Kalman filter gain
        P = (eye(3) - K * C) * P; % Update error covariance 
        x_kf = x_kf + K * (y_ref - y_kf); % Correct state estimation
        correction_count = correction_count+1; 
    end
    % -------------------------------------------------------------- %
    
    t = t+dt;
    % Store for plotting
    x_estimated_plot(:,tk) = x_kf;
    x_plot(:,tk) = x_ref;
    t_plot(tk) = t;
    P11(tk) = P(1,1);
    P22(tk) = P(2,2);
    P33(tk) = P(3,3);
end


%% Plotting
disp('corrected times:')
disp(correction_count)

figure(1)
subplot(311)
plot(t_plot,x_plot(1,:),t_plot,x_estimated_plot(1,:))
title('State Estimate')
ylabel('position')
legend('Reference','Estimated')
subplot(312)
plot(t_plot,x_plot(2,:),t_plot,x_estimated_plot(2,:))
ylabel('velocity')
legend('Reference','Estimated')
subplot(313)
plot(t_plot,x_plot(3,:),t_plot,x_estimated_plot(3,:))
ylabel('bias')
legend('Reference','Estimated')
xlabel('Time in (s)')

figure(2)
subplot(311)
plot(t_plot,P11);
title('Covraiance Matrix')
ylabel('P11')
subplot(312)
plot(t_plot,P22);
ylabel('P22')
subplot(313)
plot(t_plot,P33);
ylabel('P33')
xlabel('Time in (s)')
