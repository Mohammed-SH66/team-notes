function [Position , orientation] = Position_and_orientation(TM)
    % --- POSITION EXTRACTION ---
    % Extract translation vector from the last column
    Position = TM(1:3 , 4);
    % --- ROTATION MATRIX EXTRACTION ---
    % Extract the 3x3 rotation matrix
    R = TM(1:3 , 1:3);
    % --- RPY ANGLE EXTRACTION ---
    % Compute Beta (Pitch)
    Beta  = atan2(-R(3,1) , sqrt(R(1,1)^2 + R(2,1)^2));
    % Check for gimbal lock (cos(Beta) close to zero)
    if abs(cos(Beta)) > 1e-6
        % Normal case
        Alfa  = atan2(R(3,2) , R(3,3));   % Roll
        Gamma = atan2(R(2,1) , R(1,1));   % Yaw
    else
        % Gimbal lock case
        Alfa  = 0;
        Gamma = atan2(-R(1,2) , R(2,2));
    end
    % Final orientation vector [Roll, Pitch, Yaw]
    orientation = [Alfa , Beta , Gamma];
end
