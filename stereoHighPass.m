function [highPassedSound] = stereoHighPass(x,filterCutoff)
%Highpass input stereo signal

frame_size = 1024; % The number of samples in a frame
H = ones(44100,1); %Create impulse vector
H(2:floor(length(H)/(length(H)/filterCutoff)),1) = 0; %From 2 to filter cutoff'th sample = 1
H(length(H)-length(H)/(length(H)/filterCutoff)-1:length(H)-1,1) = 0; %From length-filter cutoff to length = 1
h = real(ifft(H)); %Create IR 
h = circshift(h,frame_size/2); 
IR = h;
Ninput = length(x); % The number of samples in the input signal
NIR = length(IR); % The number of samples in the impulse response
Noutput = Ninput+NIR-1; % The number of samples created by convolving x and IR
frame_conv_len = frame_size+NIR-1; %  The number of samples created by convolving a frame of x and IR
step_size = frame_size/2; % Step size for 50% overlap-add
w = hann(frame_size, 'periodic');  % Generate the Hann function to window a frame
Nframes = floor((Ninput-frame_size) / step_size); 
y_L = zeros(Noutput,1); % Initialise the output vector y to zero
y_R = zeros(Noutput,1); % Initialise the output vector y to zero

disp('Computing convolution by conv overlap-and-add')
tic
% Convolve each frame of the input vector with the impulse response
frame_start = 1;
for n = 1 : Nframes
    % Apply the window to the current frame of the input vector x
    x_frame_L = x(1+(n-1)*step_size:(n-1)*step_size+frame_size,1);
    x_frame_R = x(1+(n-1)*step_size:(n-1)*step_size+frame_size,2);
    x_frame_L_windowed = w.*x_frame_L;
    x_frame_R_windowed = w.*x_frame_R;
    % Convolve the impulse response with this frame
    x_conv_L = conv(x_frame_L_windowed,IR);
    x_conv_R = conv(x_frame_R_windowed,IR);
    % Add the convolution result for this frame into the output vector y
    y_L(frame_start:frame_start+frame_conv_len-1) = y_L(frame_start:frame_start+frame_conv_len-1) + x_conv_L;
    y_R(frame_start:frame_start+frame_conv_len-1) = y_R(frame_start:frame_start+frame_conv_len-1) + x_conv_R;
    % Advance to the start of the next frame
    frame_start = frame_start+step_size;
end
disp(['Computation took ' num2str(toc) ' seconds'])
toc
highPassedSound = [y_L y_R];
end

