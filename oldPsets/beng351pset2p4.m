

L = 0:1E-10:2E-6;
Kd = 20E-9;
y = L./(Kd+L);
y(length(y)-1) %to determine range of y

%plot 1 approx
figure(1)
subplot(1,2,1);
plot(L,y);
title('Insulin Receptor Equilibrium Binding Curve');
xlabel('Initial Ligand Concentration (M)');
ylabel('Fraction Bound');
hold on;

P = 5*10^-9;
y2 = ((Kd+P+L)-((Kd+P+L).^2-4*P.*L).^.5)./(2*P);
%plot 1 exact
plot(L,y2);
legend('pseudo first order approximation','exact solution');

%Part C:

Kd2 = 2E-9;
y = L./(Kd2+L);
y(length(y)-1)

subplot(1,2,2);
%plot 2 approx
plot(L,y);
title('High Affinity Insulin Receptor Binding');
xlabel('Initial Ligand Concentration (M)');
ylabel('Fraction Bound');
hold on;

P = 5*10^-9;
y2 = ((Kd2+P+L)-((Kd2+P+L).^2-4*P.*L).^.5)./(2*P);
%plot 2 exact
plot(L,y2);
legend('pseudo first order approximation','exact solution');


%{
Explanation: The error between the approximate and exact functions
increases as the binding affinity increases (ErrorKD=2nM > ErrorKD=20nM).
This makes sense as the approximate function (pseudo first order) makes the
assumption that the initial concentration of ligand is high enough relative 
to that of the protein that the concentration of the ligand in equilibrium 
is about the same as the initial concentration. However, as the binding 
affinity increases, this approximation becomes less accurate. The reaction 
binds more protein and more ligand, and the concentration of the ligand in 
equilibrium relative to the initial concentration varies more.
%}