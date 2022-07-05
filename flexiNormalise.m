function [y] = flexiNormalise(x)
% Normalise file regardless of channel number. 

channelCount = length(x(1,:)); %Determine how many channels there are
maxValueContainer = zeros(1,channelCount);%Create container to store max values
y = zeros(length(x),channelCount);%Create y container

for n = 1 : channelCount %For each channel
    currentChannel = x(:,n); %Access current channel
    currentMaxVal = max(currentChannel); %Get channel's loudest sample
    maxValueContainer(n) = currentMaxVal; %Add loudest sample to container
end

maxVal = max(maxValueContainer); % Get loudest sample 

for n = 1 : channelCount %For each channel
    y(:,n) = x(:,n)/maxVal; %Divide by the loudest sample
end

y = y * 0.99; %Loudest sample will have value 0.99

end
