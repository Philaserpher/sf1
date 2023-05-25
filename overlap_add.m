% Set up our noisy signal as x_in
len = 10000;
t = (1:len);
x_in_noiseless=0.5*cos(t*pi/4)+sin(t*pi/100);
x_in = x_in_noiseless + +randn(1,len);
y_out=0*x_in;

% N and overlap
N=512;
overlap=256;

% Partition data into samples size N overlapping by overlap
x=buffer(x_in,N,overlap);

% Get dimensions
[N_samps,N_frames]=size(x);

% Extends hanning array
x_w=repmat(hanning(N),1,N_frames).*x;

for frame_no=1:N_frames-2
    X_w(:,frame_no)=fft(x_w(:,frame_no));
    Y_w(:,frame_no)=X_w(:,frame_no);
    Y_w(2:N/8,frame_no)=0.1*X_w(2:N/8,frame_no);
    Y_w(N/4+1:N/2,frame_no)=0.2*X_w(N/4+1:N/2,frame_no);
    Y_w(N:-1:N/2+2,frame_no)=conj(Y_w(2:N/2,frame_no));
    y_w(:,frame_no)=ifft(Y_w(:,frame_no));
    y_out((frame_no-1)*overlap+1:(frame_no-1)*overlap+N)=...
        y_out((frame_no-1)*overlap+1:(frame_no-1)*overlap+N)+y_w(:,frame_no)';
end


hold on
plot(t, x_in)
plot(t, y_out)
plot(t, x_in_noiseless)
legend('Noisy', 'Denoised', 'Original');
xlabel('t')
ylabel('Amplitude')
title('Noisy vs denoised signal')
hold off