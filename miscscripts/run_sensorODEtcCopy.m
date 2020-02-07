%% run sensorODE.m

%% Clear Workspace
clear; clc; close all;
%% Define Inputs 

%sensorInput = [0,100;1,100;0,100;1,100;0,100];
sensorInput = [0,200;1,1500;0,1500];
%sensorInput = [0,100;1,100;0,100;1,100;0,100;1,100;0,100];

%% Define Initial State Conditions

initCond = [0.001;0.05;0;3;0;3;0;0.005;0.1;0;0;0;0;0];

% Set Noise Flags
chatter = false;
stochasticity = false;

%Initial conditions for the toxin added (max input) in uM
maxInputAmpl = 1; 

%% Solve "sensorODE"
[output,outputTime,input,inputTime] = sensorODE_solver(@sensorODEtcCopy,...
sensorInput,chatter,stochasticity,maxInputAmpl,initCond);

t = outputTime;
toxin = input;
RTK = output(:,1);
A = output(:,2);
As = output(:,3);
S = output(:,4);
Ss = output(:,5);
GFP = output(:,6);
C = output(:,7);
Erev1 = output(:,8);
Erev2 = output(:,9);
tRTK = output(:,10);
SAs = output(:,11);

%% Plot Results


figure(2);
subplot(2,3,1);
plot(inputTime,toxin);
title('Toxin');
legend('toxin');

subplot(2,3,2);
plot(t,RTK);
hold on;
plot(t,tRTK);
title({'Receptor Tyrosine Kinase','Bound and Unbound'});
legend('RTK','tRTK');

subplot(2,3,3);
plot(t,A);
hold on;
plot(t,As);
title({'Intermediate A, As','Activated and Inactivated'});
legend('A','As');

subplot(2,3,4);
plot(t,S);
hold on;
plot(t,Ss);
title({'Effector S, Ss','Activated and Inactivated'});
legend('S','Ss');

subplot(2,3,5);
plot(t,GFP);
hold on;
plot(t,C);
title('Unbound GFP and Bound GFP (C)')
legend('GFP','C');

subplot(2,3,6);
plot(t,SAs);
title('S-As Complex');
legend('SAs');


figure (1);

subplot(1,3,1);
plot(t,RTK,'-');hold on;
plot(t,tRTK,'-');
plot(t,A,'.-');
plot(t,As,'.-');
plot(t,S,'--');
plot(t,Ss,'--');
plot(t,GFP);
plot(t,C);
plot(t,SAs,'--');
plot(t,Erev1,':');
plot(t,Erev2,':');
title('All State Dynamics');
xlabel('time (minutes)');
ylabel('Concentration (uM)');
legend('RTK','tRTK','A','As','S','Ss','GFP','C','SAs','Erev1',...
    'Erev2');

subplot(1,3,2);

plot(t,GFP);
hold on;
plot(t,C);
title('Unbound GFP and Bound GFP (C)');
xlabel('time (minutes)');
ylabel('Concentration (uM)');
legend('GFP','complex');

subplot(1,3,3);
plot(inputTime,toxin);
title('Toxin');
xlabel('time (minutes)');
ylabel('Concentration (uM)');
legend('toxin');


% Use a single figure that consists of 3 subplots:
% 1 - The first subplot should depict all state dynamics as a function of
% time.
% 2 - The second subplot should depict GFP dynamics as a function of time.
% 3 - The third subplot should depict the sensor's input dynamics as a
% function of time. (The input and inputTime from the sensorODE_solver can
% be used).
% Remember to label your axes and units clearly!

% Remember to plot system dynamics using a variety of colors and line
% properties. You want the reader to easily discern different states
% irrespective of using a color or black-and-white printer.
