close all;
load('SPR_data.mat');

t1 = zeros(33,1);
R1 = zeros(33,1);
R2 = zeros(33,1);
R3 = zeros(33,1);

for i = 5:37 %Concentrations after ligand was added (at 5th datapoint, 74 seconds)
    t1(i-4) = t(i);
    R1(i-4) = RU_10nM(i);
    R2(i-4) = RU_20nM(i);
    R3(i-4) = RU_30nM(i);
end

%Defining fit function
customExp = fittype('a-a*exp(b*x)+c','dependent',{'y'},'independent',{'x'},'coefficients',{'a','b','c'});
%fitting curves
fit10 = fit(t1,R1,customExp,'StartPoint',[60,0,10]);
fit20 = fit(t1,R2,customExp,'StartPoint',[60,0,10]);
fit30 = fit(t1,R3,customExp,'StartPoint',[60,0,10]);

%plotting
figure(1)
plot(fit10);hold on; plot(t, RU_10nM,'.'); hold off;
title('SPR association phase data 10nM');
xlabel('time (s)');
ylabel('RU');
figure(2)
plot(fit20);hold on; plot(t,RU_20nM,'.'); hold off;
title('SPR association phase data 20nM');
xlabel('time (s)');
ylabel('RU');
figure(3)
plot(fit30);hold on; plot(t,RU_30nM,'.'); hold off;
title('SPR association phase data 30nM');
xlabel('time (s)');
ylabel('RU');

%Calculating Residuals
residual1 = zeros(33,1);
residual2 = zeros(33,1);
residual3 = zeros(33,1);
a = [117.3,235.8,468.7];
kobs = [.009437,0.01661,0.02403];
c = [-46.32,-148.8,-383.2];

for i=1:length(t1)
    residual1(i) = R1(i)-(a(1)-a(1)*exp(-kobs(1)*t1(i))+c(1));
    residual2(i) = R2(i)-(a(2)-a(2)*exp(-kobs(2)*t1(i))+c(2));
    residual3(i) = R3(i)-(a(3)-a(3)*exp(-kobs(3)*t1(i))+c(3));
end

%Plotting residuals
figure(4)
title('Goodness of Fit');
xlabel('time (s)');
ylabel('residuals (experimental - fit association fraction)');
hold on;
plot(t1,residual1)
plot(t1,residual2)
plot(t1,residual3)
legend('residuals for 10nM data and fit','residuals for 20nM data and fit','residuals for 30nM data and fit');

%Plotting the residuals of the three fit functions to their respective
%experimental data sets indicates that the curves are decent fits;
%residuals oscilate around 0 and rarely
%exceed more than a 5% variation between the fit function and the
%data.

%plotting kobs vs L0
figure(5)
L0 = [10E-9,20E-9,30E-9];
kcoef = [];
kcoef = polyfit(L0,kobs,1);
kfit = kcoef(2)+kcoef(1)*L0;
plot(L0,kobs);
hold on;
plot(L0,kfit);
title('kobserved vs [L]0');
xlabel('[L]0');
ylabel('kobs');
legend('data','fit');

%calculating koff,kon,Kd
koff = kcoef(2)
kon = kcoef(1)
Kd = koff/kon

%The values for Kd, koff, and kon obtained from the fit curves are
%relatively close to the assumed values (Kd = 20nM and kon = 1*10^5 1/M*s)
%koff was almost exactly the same, and while kon and Kd were slightly further
%from the estimates, they were no more than about a factor of 7 off.
%Overall as the initial estimates were within about one maginitude, they
%were reasonable guesses.
%{
koff =
    0.0021 1/s
kon =
   7.2965e+05 1/Ms
Kd =
   2.8772e-09 M
%}
