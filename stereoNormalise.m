function [y] = stereoNormalise(x)
% Normalise stereo file. If input file is mono,
% then make stereo and then normalise

if size(x,2) == 1 %If source is mono
    x = [x x]; %Make it stereo!
end

maxval = max(x); % Get loudest samples from both channels

if maxval(:,1) > maxval(:,2) % Determine which of the two samples is loudest
    maxvalue = maxval(:,1); %L sample won
else
    maxvalue = maxval(:,2); %R sample won
end

y(:,1) = x(:,1)/maxvalue; %Divide by loudest sample
y(:,2) = x(:,2)/maxvalue; %Divide by loudest sample
y = y * 0.99;
end


