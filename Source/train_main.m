clc;
clear all;
close all;
dir=input('Enter the record number with .csv extension:','s');
epi=0;
non_epi=0;
sr=1;       %Serial number for figures
Array1=csvread(dir,2,0);
x1= Array1(:, 1);
fs = 200;
figure(sr)
subplot(2,1,1);
plot(x1);
xlabel('Samples');
ylabel('Magnitude');
XLIM([0 500]);
title('Original EEG signal');
            
%filtering stage
for n=3:length(x1)
    y(n)=sum(x1(n-2:n))/3;       %y[n] is the filtered signal
end
y2=y';
subplot(2,1,2);
plot(y);
xlabel('Samples');
ylabel('Magnitude');
title('Filtered EEG signal')
XLIM([0 500]);
sr=sr+1;
        
%Decomposing signal into different frequency subbands
[delta,theta,alpha,beta,time]= Segregate(y,fs);
sr=sr+1;
        
%Spike detection
[ex]=Teager(y);
figure(sr)
subplot(2,1,1);
plot(y);
xlabel('Samples');
ylabel('Magnitude');
title('Original EEG signal');
XLIM([0 1000]);
    
subplot(2,1,2);
plot(ex);
xlabel('Samples');
ylabel('Magnitude');
title('Teager Energy of Detected Spikes');
XLIM([0 1000]);
        
sr=sr+1;
    
%splitting the filtered signal in two parts
signal_length=length(y2);
l2=signal_length/2;
j=1;
for q=1:signal_length
    if q<=l2
        part1(q)=y2(q);
    else
        part2(j)=y2(q);
        j=j+1;
    end
end
thresh_signal=mean(y2);                    %Mean/Threshold
p1=part1;
part1=part1';
p2=part2;
part2=part2';
len=length(part1);

%Applying Katz algorithm for segmentation on first part of signal
[en1,ent1,std1,mean1]=katz_algo(part1,len,fs,p1,thresh_signal);
Energy=en1;
Avg_Entropy=ent1;
Std_dev=std1;
Mean=mean1;
q=length(en1)+1;
len=length(part2);
    
%Applying Katz algorithm for segmentation on second part of signal
[en2,ent2,std2,mean2]=katz_algo(part2,len,fs,p2,thresh_signal);
for j=1:length(en2)
    Energy(q)=en2(j);
    Avg_Entropy(q)=ent2(j);
    Mean(q)=mean2(j);
    Std_dev(q)=std2(j);
    q=q+1;
end 
  
d=[Energy Avg_Entropy Mean Std_dev];