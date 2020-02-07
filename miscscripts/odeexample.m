
%example of how to set up ODE45 to solve kinetic equation
%simple kinetics binding of
%A -> B (reversible, with rate constants k1 and k-1), and
%B -> C (irreversible, with rate constant k2) 

%set up constants (I just used same constants for all of them) 
k1=0.01; %units 1/(Ms)
k_1=0.01;  %units 1/s
k2=0.01; %units 1/s
options=[];

tspan=[0 1500]; %time period you want to solve for in seconds
init=[0.1,0 0]; %initial concentrations of A, B, C (here we have 0.1M of A to start)


[t y]=ode45('kineticsfunc',tspan, init, options, k1,k_1,k2);


A=y(:,1);
B=y(:,2);
C=y(:,3);

plot(t,A,'r',t,B,'b',t,C,'g');




