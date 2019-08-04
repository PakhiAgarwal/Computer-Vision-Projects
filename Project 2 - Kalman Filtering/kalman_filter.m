function loc_estimate = kalman_filter(x_data_joint_1, y_data_joint_1)
    num_of_frames = length(x_data_joint_1);       % Total number of frames
    state = [x_data_joint_1'; y_data_joint_1'; ones(2,num_of_frames)];
    
    % Frame rate
    dt = 1;
    
    % Standard Deviations
    std_acc = 50; % motion
    std_pos = 30; % measurememt

    % Constant velocity model's matrices H and F
    F = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
    H = [1 0 0 0; 0 1 0 0];
    
    % Covariance of motion model
    Q = std_acc^2 * [dt^4/4 0 dt^3/2 0; 
                     0 dt^4/4 0 dt^3/2; 
                     dt^3/2 0 dt^2 0;
                     0 dt^3/2 0 dt^2];

    % Covariance of measurement model
    R = std_pos^2 * H * H';
    
    % Initial prediction is taken as Q, which is the covariance of motion
    % model
    P = Q;

    % Initialize variables for estimating location and state
    loc_estimate = zeros(2,num_of_frames);
    state_estimate = [0; 0; 1; 1];

    for t = 1 : num_of_frames
        % Predict Step.
        state_estimate = F * state_estimate;
        P = F * P * F' + Q;
        
        % Update step.
        y = state(1:2,t) - H * state_estimate;
        S = H * P * H' + R;

        % Kalman Gain
        K = P*H'*inv(S);
        state_estimate_updated = state_estimate + K * y;
        
%         disp(y'*inv(S)*y)
        P = (eye(4)-K*H)*P;        
        % Update covariance estimation 
%         *inv(S)
%         disp(y'*y)
        if max(state(1:2,t)) == 0
%             disp("Hi")
            loc_estimate(:,t) = [state_estimate(1),state_estimate(2)];
        else
            loc_estimate(:,t) = [state_estimate_updated(1), state_estimate_updated(2)];
            state_estimate = state_estimate_updated;
        end
    end