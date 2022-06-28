function [y] = monoNormalise(x)
% Normalise mono file. 

maxval = max(x); % Get loudest sample

y = x / maxval; %Divide whole signal by loudest sample

y = y * 0.99; %Loudest sample will have value 0.99
end