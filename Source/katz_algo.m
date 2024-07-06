function [Energy, Avg_Entropy,Std_dev, Mean]=katz_algo(y2,signal_length,fs,y,thresh_signal) 
%Implementing Katz algorithm for segmentation of signal
for it1=1:signal_length-1001               
%For dividing the signal according to the window length 
    for it2=1:1000
        y3(it2)=y2(it1+it2); 
    end
    y32=y3';
    fr_dim(it1)=fd(y32,fs);          %Finding fractal dimension
end
fr_dim=fr_dim';
    
for i=1:length(fr_dim)-1             %For finding G index
    g(i)=abs(fr_dim(i+1)-fr_dim(i));        
end    
g=g';   
pks=findpeaks(g);                    %Finding peak values of the signal
seg_ar=zeros(16000,1000);            %Array to store boundary points
segment=zeros(1600);                 %Array to store segments of the signal
k=1;
g=g';
m=0;
fr_dim=fr_dim';
for i=1:length(pks)
    if pks(i)>=thresh_signal  
    %local maxima of G index greater than threshold indicates boundary point
        for a=1:length(g)
            if pks(i)==g(a)
                for j=1:length(fr_dim)-1
                    temp=abs(fr_dim(j+1)-fr_dim(j));
                    if g(a)==temp
                        m = 1;
                        for l=j:1000+j                      
                            seg_ar(k,m)=y(l);
                            m = m+1;
                        end
                        k=k+1;
                    end
                end
            end
        end
    end
end
p=1;
q=1;
k=1;
m = m-1;
c=1;

for i=1:length(y2)   %Creating the final array consisting of segments of signal
    if c==1
        if y2(i)~= seg_ar(k,1)
            segment(p,q)=y2(i);
            q=q+1;
        else
            for j=1:m
                segment(p,q)=seg_ar(k,j);
                q=q+1;
            end
            p=p+1;                
            i=i+m;
            q=1;
            k=k+1;
        end
        if k==signal_length
            c=0;
        end
    else
        break;
    end
end
len=p-1;    %the number of boundary elements
k=1;        %to store the number of segments
for i=1:len
    [Mean(i,1)]=mean(segment(k,:)); 
    %Calculating Mean of each segment
    [Std_dev(i,1)]=std(segment(k,:));
    %Calculating Standard deviation of each segment
    [Energy(i,1)]= Energy_of_Signal(segment(k,:));
    %Calculating Energy of each segment
    [Avg_Entropy(i,1)]=entropy1(segment(k,:));
    %Calculating Average entropy of each segment
    k=k+1;
end   