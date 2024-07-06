function f=fd(x,fs)
x=(x-mean(x))/std(x);
n = length(x);
t=(0:1/fs:(n-1)/fs);
t=t';
x1=[t x];
for i=1:n-1
    d(i)=sqrt(abs(x1(i+1,1)-x1(i,1))^2+abs(x1(i+1,2)-x1(i,2))^2);
    dmax(i)=sqrt((abs(x1(i+1,1)-x1(1,1))^2+abs(x1(i+1,2)-x1(1,2))^2));
end
totlen=sum(d);
avglen=mean(d);
maxdist=max(dmax);
numstep=double(totlen/avglen);
den=double(maxdist/totlen);
f=(log(numstep))/((log(den)+log(numstep)));