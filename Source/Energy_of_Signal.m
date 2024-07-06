function[Energy]=Energy_of_Signal(signal)
s=0;
for i=1:(length(signal))
    s=s+((signal(i))^2);
end
Energy=s;
end