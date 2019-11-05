%Question 2 Code:

plot(ecgsig(:,1));
xlabel('Milliseconds');
ylabel('Volts');
title('Unfiltered ECG Signal'); %inititate the orginal signal graph ;
fs = 1000; %scanning rate = 1000 ; signal sample at 1000 Khz
t = 0:1/fs:1;
x = [1 2]*sin(2*pi*[50 250]'.*t) + randn(size(t))/10;
lowpass(x,20,fs)
highpass(x,400,fs)