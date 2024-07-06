function [delta,theta,alpha,beta,time]=Segregate(x,fs)
%separate into EEG wave types
%Delta (0-4Hz) - Deep Sleep
%Theta (4-8Hz) - Daydream state/Light Sleep
%Alpha (8-12Hz) - Relaxation/awake but eyes closed
%Beta (12-40Hz) - Active Movements and Thoughts/eyes open
 
N=6;
time = 0:1/fs:(length(x)-1)*1/fs;
len=length(x)-1;		%storing the last smaple number

%delta
Wn_d=5/fs;
[b,a] = butter(N,Wn_d);
delta = filter(b,a,x);
 
%theta 
W1 = 8/fs;
W2 = 14/fs;
Wn_t = [W1 W2];
[c,d] = butter(N,Wn_t);
theta = filter(c,d,x);
 
%alpha 
W3 = 16/fs;
W4 = 22/fs;
Wn_a = [W3 W4];
[e,f] = butter(N,Wn_a);
alpha = filter(e,f,x);
 
%beta 
W5 = 22/fs;
W6 = 80/fs;
Wn_b = [W5 W6];
[g,h] = butter(N,Wn_b);
beta = filter(g,h,x);
 
%% Figures    
figure
hold on
title('x Wave Patterns')
subplot(5,1,1), plot(time, x)
    xlabel('Time(s)')
    ylabel('Amplitude')
    title('Raw EEG Signal')
    XLIM([0 time(len)])
subplot(5,1,2), plot(time, delta) 
    xlabel('Time(s)')
    ylabel('Amplitude')
    title('Delta Waves')
    XLIM([0 time(len)])
subplot(5,1,3), plot(time, theta) 
    xlabel('Time(s)')
    ylabel('Amplitude')
    title('Theta Waves')
    XLIM([0 time(len)])
subplot(5,1,4), plot(time, alpha) 
    xlabel('Time(s)')
    ylabel('Amplitude')
    title('Alpha Waves')
    XLIM([0 time(len)])
subplot(5,1,5), plot(time, beta) 
    xlabel('Time(s)')
    ylabel('Amplitude')
    title('Beta Waves') 
    XLIM([0 time(len)])
hold off
 
end