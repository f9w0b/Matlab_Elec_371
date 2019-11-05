
% Citation : code was typed based on the help of referencing wavelet transform -MATLAB ;
% Source: https://www.mathworks.com/help/wavelet/ug/r-wave-detection-in-the-ecg.html?fbclid=IwAR0WioE32K9bUyI_rvLe3V62Ib6_g3682Fk51vv70fka9VLuOtValGIV3j0  

load mit200 % contains the column vector with the signal of interest channel 1
tm = numel(ecgsig):1 ;  % load number of elements generated
qrsEx = ecgsig(34088:34800);
[mpdict,~,~,longs] = wmpdictionary(numel(qrsEx),'lstcpt',{{'sym4',3}});
figure
plot(qrsEx)
hold on
plot(2*circshift(mpdict(:,11),[-2 0]),'r')
axis tight
legend('QRS Complex','Sym4 Wavelet')
title('Comparison of Sym4 Wavelet and QRS Complex')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wt = modwt(ecgsig,5);
wtrec = zeros(size(wt));
wtrec(4:5,:) = wt(4:5,:);
y = imodwt(wtrec,'sym4');

y = abs(y).^2;
[qrspeaks,locs] = findpeaks(y,tm,'MinPeakHeight',0.08,... %% how much of a spike before you read as a peak
    'MinPeakDistance',0.08);
figure
plot(tm,y)
hold on
plot(locs,qrspeaks,'ro')
xlabel('Milliseconds')
title('R Peaks Localized by Wavelet Transform with Automatic Annotations')

plot(tm(locs),y(locs),'k*')
title('R peaks Localized by Wavelet Transform with Expert Annotations')

peaks_second = length(qrspeaks)/87.8; %code ran for an average of 87.8 seconds roughly
bmp =  peaks_second*60 %output for bpm