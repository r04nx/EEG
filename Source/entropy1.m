function [ent]=entropy1(x)
tot = 0.0;
ent = 0.0;
count=0;
len=length(x);
for i=1:len-1
    if (x(i)==0 && x(i+1)==0)       %Checking for consecutive zeros
        count=count + 1;
    else
        count=0;
    end
    tot = tot + x(i)^2;
    if count==8
        len=i-7;
        break;
    end
end
t=0;
for i=1:len
    if x(i)~=0
    quo = x(i)^2 / tot;
    t=quo * log10(quo);    
    ent = ent-t;
    else
        continue;               %Skipping zero elements
    end
end
y=-ent;