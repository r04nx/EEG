function [threshold]=thresh_calc(wih,who,bh,bo)

%Load the FCM centers obtained
load('threshold_center.mat');
data=threshold_center(2,:);

%input to hidden layer
for i=1:4
    y1(i)=0;
    for j=1:4
        y1(i)=y1(i)+data(i)*wih(i,j);
    end
    y1(i)=y1(i)+bh(i);
    yo1(i)=(1/1+exp(-1*y1(i)));%output after activation
end

%hidden to output layer
yin=0;
for j=1:4
    yin=yin+yo1(i)*who(j);
end
yin=yin+bo;
threshold=(1/1+exp(-1*yin));%output after activation
end