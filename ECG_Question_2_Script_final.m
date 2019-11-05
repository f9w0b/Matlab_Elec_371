load('mit200.mat') %load vector file with ecg values
Fs = 1000;
t = (0:length(ecgsig)-1)/Fs;
%t = 0:1/Fs:1;

plot(t,ecgsig, 'k');
ylabel('Voltage (V)');
xlabel('Time (milliseconds)');
legend('Original Signal');
title('Unfiltered Signal');

high_pass_cascade = highpass(ecgsig(:,1),400,Fs); %initialize low_pass_after notch (Cascade)
%plot(t,high_pass_cascade, 'b');
%ylabel('Voltage (V)');
%xlabel('Time (milliseconds)');
%legend('High Pass filtered Signal');
%title('High Pass filtered Signal');

low_pass_cascade = lowpass(high_pass_cascade,20,Fs); %initialize high_pass_after low + notch filter (Cascade)
%plot(t,low_pass_cascade, 'm');
%ylabel('Voltage (V)');
%xlabel('Time (milliseconds)');
%legend('High Pass -> Low Pass filtered Signal');
%title('High Pass -> Low Pass filtered Signal');

%plot(t,ecgsig, 'b',t,high_pass_cascade, 'r',t,low_pass_cascade, 'g')

d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',2,'HalfPowerFrequency2',4, ...
               'DesignMethod','butter','SampleRate',Fs);

fvtool(d,'Fs',Fs);
buttLoop = filtfilt(d,low_pass_cascade);

plot(t,buttLoop,'r')
ylabel('Voltage (milliV)');
xlabel('Time (millseconds)');
legend('High-pass -> Low pass -> Filter Signal')
title('High Pass -> Low Pass -> Notch filtered Signal filters IS RED (FINAL FILTERED SIGNAL)')