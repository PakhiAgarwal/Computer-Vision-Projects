clc; clear all; close all;

load Subject7-Session3-Take1_alljoints_matched.mat

% 1D - View Points, 2D - 17576 frames, 3D - 12 joint information, 4D - x, y, confidence locations of given joint
% Views: 1D - Frame #, 2D - Joint, 3D - x, y, confidence of given joint
view1 = squeeze(body2D(1,:,:,:));           % First view point 
view2 = squeeze(body2D(2,:,:,:));           % Second view point
num_of_joints = length(view1(1,:,1));       % Total number of joints

% Plotting the initial data
for i = 1 : num_of_joints
    figure(i)
    title(['Joint #' num2str(i)])
    subplot(2,1,1)
    hold on
    plot(1:length(view1(:,i,1)), view1(:,i,1),'-','Color',[0, 0.4470, 0.7410],'LineWidth',1.5)
    subplot(2,1,2)
    hold on
    plot(1:length(view1(:,i,2)), view1(:,i,2),'-','Color',[0, 0.4470, 0.7410],'LineWidth',1.5)
end
% hold off

% Plotting the data after Kalman filtering and thresholding
for i = 1 : num_of_joints
    x_data_joint_1 = view1(:,i,1);  % num_frames x 1
    y_data_joint_1 = view1(:,i,2);  % num_frames x 1

    % Kalman filter is applied to the given data
    loc_estimate = kalman_filter(x_data_joint_1, y_data_joint_1);

    figure(i)
%     plot(1:17576,loc_estimate(1,:),'-g')
%     plot(1:17576,x_data_joint_1,'--b')
    subplot(2,1,1)
    plot(1:length(loc_estimate(1,:)) ,loc_estimate(1,:),'--','Color',[0.8500, 0.3250, 0.0980],'LineWidth',1.5);
    legend('Observed','Smoothed')
    title(['Joint #' num2str(i) ',X-location along Timeframe'])
    subplot(2,1,2)
    plot(1:length(loc_estimate(2,:)) ,loc_estimate(2,:),'--','Color',[0.8500, 0.3250, 0.0980],'LineWidth',1.5);
    legend('Observed','Smoothed')
    title(['Joint #' num2str(i) ',Y-location along Timeframe'])
end
% hold off