clc;
clear all;
close all;
d=importdata('traindatafinal.dat');
figure(1)
plot(d(:,1),d(:,2),'.'); %hold on
figure(2)
plot(d(:,3),d(:,4),'.');
[center,U,obj_fcn] = fcm(d,2,10);
maxU = max(U);
index1 = find(U(1, :) == maxU);
index2 = find(U(2, :) == maxU);
figure(3)
line(d(index1, 1), d(index1, 2), 'linestyle',...
'none','marker', 'o','color','g');
hold on
line(d(index2, 1), d(index2, 2), 'linestyle',...
'none','marker', 'o','color','g');
hold on
line(d(index1, 3),d(index1, 4),'linestyle',...
'none','marker', 'x','color','r');
hold on
line(d(index2, 3), d(index2, 4), 'linestyle',...
'none','marker', 'x','color','r');
hold on
plot(center(1,1),center(1,2),'ko','markersize',8,'LineWidth',2)
plot(center(1,3),center(1,4),'kx','markersize',8,'LineWidth',2)
title('Scatter Plot');
ylabel('Energy');
xlabel('Average Entropy');