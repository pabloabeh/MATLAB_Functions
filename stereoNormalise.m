function [y] = stereoNormalise(x)
% Normalise stereo file. 

maxval = max(x); % Get loudest samples from both channels

if maxval(:,1) > maxval(:,2) % Determine which of the two samples is loudest
    maxvalue = maxval(:,1); %L sample won
else
    maxvalue = maxval(:,2); %R sample won
end

y(:,1) = x(:,1)/maxvalue; %Divide left channel by loudest sample
y(:,2) = x(:,2)/maxvalue; %Divide right channel by loudest sample
y = y * 0.99; %Loudest sample will have value 0.99
end


