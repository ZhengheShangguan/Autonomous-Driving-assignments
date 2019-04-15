%% main.m script
%% Controller for kinematic bicycle model
%% Reference Chapter 3: "Automatic_Steering_Methods_for_Autonomous_Automobile_Path_Tracking.pdf"
%%%%%%%%%%%%%%%%%%%%%%% 
% directly hit "Run" and you get everything
% Zhenghe Shangguan     NetID: zhenghe3     Date: 02/21/19

%% From Piazza, the professor said the model in the reference chapter is also acceptable
%% To make my life easier, I directly use the model of the reference Chapter 3
%% Where:   Inputs: v, delta;   Outputs: x, y, theta

% model parameters
L = 2.006;
radius = 50;

% Desired pose (destination with required heading)
x_d = 0;
y_d = 0;
theta_d = pi/2;

% Control Parameters
K_alpha = 8;
K_beta = -1.5;
K_rho = 3;

%% Run the controller with different initial Pose, collect the data and plot
%% Run the for-loop with different initial poses
for i = 1:1:8
    x0 = radius * cos((i-1)*pi/4);
    y0 = radius * sin((i-1)*pi/4);
    theta0 = 0;
    % First, check if the bicycle should move forward or backward
    angle = -theta0 + atan2(-y0+y_d, -x0+x_d);
    while angle > pi
        angle = angle - 2*pi;
    end
    while angle <= -pi
        angle = angle + 2*pi;
    end
    if angle > -pi/2 && angle <= pi/2
        forward_mode = 1;
    else
        forward_mode = -1;
    end
    % Second, run the simulink model and save the data to workspace
    sim('Controller_kinematic_bicycle');
    % Third, plot the pose
    plot(bicycle_pose(:,2), bicycle_pose(:,3));
    hold on;
end

title('SE498-HW2-zhenghe3 Robot Trajectory')
xlabel('X(mm)')
ylabel('Y(mm)')
axis([-radius * 1.2 radius * 1.2 -radius * 1.2 radius * 1.2])
legend('Initial Pose: (50, 0, 0)',...
    'Initial Pose: (50*cos(pi/4), 50*cos(pi/4), 0)',...
    'Initial Pose: (50*cos(2*pi/4), 50*cos(2*pi/4), 0)',...
    'Initial Pose: (50*cos(3*pi/4), 50*cos(3*pi/4), 0)',...
    'Initial Pose: (50*cos(4*pi/4), 50*cos(4*pi/4), 0)',...
    'Initial Pose: (50*cos(5*pi/4), 50*cos(5*pi/4), 0)',...
    'Initial Pose: (50*cos(6*pi/4), 50*cos(6*pi/4), 0)',...
    'Initial Pose: (50*cos(7*pi/4), 50*cos(7*pi/4), 0)')

