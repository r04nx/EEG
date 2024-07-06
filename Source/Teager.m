function [ex]=Teager(x)
ex=zeros(1,10^5);
squ1=x(2:length(x)-1).^2;
oddi1=x(1:length(x)-2);
eveni1=x(3:length(x));
ex=squ1 - (oddi1.*eveni1);
ex = [ex(1) ex ex(length(x)-2)]; %to make it the same length
end