clc; clear all; close all

load Subject7-Session3-Take1_alljoints_matched.mat

% 1D - View Points, 2D - 17576 frames, 3D - 12 joint information, 4D - x, y, confidence locations of given joint
% Views: 1D - Frame #, 2D - Joint, 3D - x, y, confidence of given joint
view1 = squeeze(body2D(1,:,:,:));           % First view point 
view2 = squeeze(body2D(2,:,:,:));           % Second view point
num_of_joints = length(view1(1,:,1));       % Total number of joints

% Plotting the initial data
for i = 1 : num_of_joints
    hold on
    figure(1)
    plot(view1(:,i,1), view1(:,i,2))
end
hold off

% Plotting the initial data
for i = 1 : num_of_joints
    hold on
    figure(2)
    plot(view2(:,i,1), view2(:,i,2))
end
hold off


% Plotting the data after Kalman filtering and thresholding for view 1
for i = 1 : num_of_joints
    x_data_joint_1 = view1(:,i,1);  % num_frames x 1
    y_data_joint_1 = view1(:,i,2);  % num_frames x 1

    % Kalman filter is applied to the given data
    loc_estimate = kalman_filter(x_data_joint_1, y_data_joint_1);

    figure(3)
    hold on
    plot(loc_estimate(1,:) ,loc_estimate(2,:))
end
hold off

% Plotting the data after Kalman filtering and thresholding for view 2
for i = 1 : num_of_joints
    x_data_joint_1 = view2(:,i,1);  % num_frames x 1
    y_data_joint_1 = view2(:,i,2);  % num_frames x 1

    % Kalman filter is applied to the given data
    loc_estimate = kalman_filter(x_data_joint_1, y_data_joint_1);

    figure(4)
    hold on
    plot(loc_estimate(1,:) ,loc_estimate(2,:))
end
hold off