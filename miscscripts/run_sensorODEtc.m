%% run sensorODE.m

%% Clear Workspace
clear; clc; close all;
%% Define Inputs 
% The following matrix must be M x 2, where input1 is defined in the left
% column and time in the right column. Input1 represents the state of toxin
% input (either 0 or 1).  The second column represents the time of the
% toxin pulse in minutes. (The number of rows may be
% modified to include multiple pulses, separated by semicolon).

sensorInput = [0,500;1,500;0,500];

%% Define Initial State Conditions
% The following vector must be Sn x 1, where Sn reflects the number of states
% in your system.

%initCond = [0.001,0.05,0,3,0,3,0,0.005,0.01,0,0,0,0,0];
initCond = [0.001;0.05;0;3;0;3;0;0.005;0.1;0;0;0;0;0];
%initCond = [0.001,0.05,0,3,0,3,0,0.005,0.01,0,0,0,0,0];


% Set Noise Flags
chatter = false;
stochasticity = false;

%Initial conditions for the toxin added (max input) in uM
maxInputAmpl = 1; 

%% Solve "sensorODE"
[output,outputTime,input,inputTime] = sensorODE_solver(@sensorODEtc,...
sensorInput,chatter,stochasticity,maxInputAmpl,initCond);
%change @sensorODE to whatever you name the new program

t = outputTime;
toxin = input;%plot toxin vs inputtime
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
figure(1);
subplot(2,3,1);
plot(inputTime,toxin);
legend('toxin');

subplot(2,3,2);
plot(t,RTK);
hold on;
plot(t,tRTK);
legend('RTK','tRTK');

subplot(2,3,3);
plot(t,A);
hold on;
plot(t,As);
legend('A','As');

subplot(2,3,4);
plot(t,S);
hold on;
plot(t,Ss);
legend('S','Ss');

subplot(2,3,5);
plot(t,GFP);
hold on;
plot(t,C);
legend('GFP','C');

subplot(2,3,6);
plot(t,SAs);
legend('SAs');

%figure(2);
%subplot(1,3,1);


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
