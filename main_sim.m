%% MAIN LASER ROBOT 3D SIMULATION (USING DKM + Position_and_orientation)
clc; clear; close all;

%% --- NUMERIC PARAMETERS ---
L1 = 1;
L2 = 1;
L3 = 1;

%% --- TRAJECTORY FOR LASER TIP ---
nSteps = 120;
theta1_list = linspace(0 , pi/2 , nSteps);        % Joint 1 motion (Z rotation)
theta2_list = linspace(0 , pi/3 , nSteps);        % Joint 2 motion (Y rotation)

P_traj  = zeros(3 , nSteps);   % End-effector positions
O_traj  = zeros(3 , nSteps);   % End-effector orientations [Roll Pitch Yaw]

%% --- COMPUTE TRAJECTORY USING DKM + Position_and_orientation ---
for k = 1:nSteps
    TM = DKM(theta1_list(k) , theta2_list(k) , L1 , L2 , L3);
    [P , O] = Position_and_orientation(TM);
    P_traj(:,k) = double(P);
    O_traj(:,k) = double(O);
end

%% --- CREATE 3D FIGURE ---
figure('Name','3D Laser Robot Simulation','NumberTitle','off');
ax = axes('Parent', gcf);
hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

xlabel(ax, 'X'); ylabel(ax, 'Y'); zlabel(ax, 'Z');
title(ax, 'Laser Beam Path');
axis(ax, [-2 2 -2 2 -1 3]);
view(ax, 3);

%% --- DRAW GLOBAL AXES ARROWS ---
axisScale = 0.6;
quiver3(ax, 0, 0, 0, axisScale, 0, 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
quiver3(ax, 0, 0, 0, 0, axisScale, 0, 'g', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
quiver3(ax, 0, 0, 0, 0, 0, axisScale, 'b', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);

%% --- DRAW LASER PATH ---
beamColor = [1 0 0];
laserPath = plot3(ax, P_traj(1,1), P_traj(2,1), P_traj(3,1), '-', ...
    'Color', beamColor, 'LineWidth', 1.5);
laserPoint = plot3(ax, P_traj(1,1), P_traj(2,1), P_traj(3,1), 'o', ...
    'MarkerFaceColor', beamColor, 'MarkerEdgeColor', beamColor);

%% --- ANIMATION LOOP ---
for k = 1:nSteps
    set(laserPoint, 'XData', P_traj(1,k), ...
                    'YData', P_traj(2,k), ...
                    'ZData', P_traj(3,k));
    set(laserPath, 'XData', P_traj(1,1:k), ...
                   'YData', P_traj(2,1:k), ...
                   'ZData', P_traj(3,1:k));
    drawnow;
end
