kcat = 30800;
k1 = 1E7;
kn1 = 10000;
S0 = 10E-3;
Km = (kn1+kcat)/k1;
E0 = [9.315E-9,9.315E-8,9.315E-7];

for i=1:3

%plot implicit solution
f = @(t,S) ((S+reallog(S)*Km)+(kcat*E0(i)*t)+.0088);
figure(i)
fimplicit(f,[0 30 0 0.011])

%plot(t,S);
%title('Implicit Solution to Michaelis Menten (QSSA)');
%xlabel('time (s)');
%ylabel('urea concentration (M)');

options=[];
tspan=[0 30]; %time period you want to solve for in seconds
init=[E0(i),S0,0]; %initial concentrations of A, B, C (here we have 0.1M of A to start)
[t y]=ode45('yfunc',tspan,init,options, k1,kn1,kcat);

E=y(:,1);
S2=y(:,2);
ES=y(:,3);

%figure(2);
hold on
%plot(t,E,'r',t,S2,'b',t,ES,'g');
plot(t,S2,'b');
%title('Implicit Solution to Michaelis Menten (QSSA) and Numerical Solution (no QSSA)');
xlabel('time (s)');
ylabel('concentration (M)');
%legend('S (MM approximation)','E','S (numerical)','ES');
legend('S (MM approximation)','S (numerical)');
hold off

end
figure(1)
title('Implicit Solution (QSSA) and Numerical Solution (no QSSA), E0 = 9.315E-9');
figure(2)
title('Implicit Solution (QSSA) and Numerical Solution (no QSSA), E0 = 9.315E-8');
figure(3)
title('Implicit Solution (QSSA) and Numerical Solution (no QSSA), E0 = 9.315E-7');


%{
Answer to part B:
Based off of the graphs, the maximum discrepancy between the QSSA
approximation and the numerical approximation is about 
5E-5 M for E0 = 9.315E-9
1E-5 M for E0 = 9.315E-8
5E-6 M for E0 = 9.315E-7
The approximations seem to converge with larger starting
concentrations of enzyme.
%}





