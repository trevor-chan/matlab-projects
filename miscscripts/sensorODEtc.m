function dydt = sensorODEtc(toxin,y,u)
% Define input conditions: * Do Not Alter *
toxin = u(1);

% Define parameter rate constants
% Parameters will have units of uM and minutes

kon1=6E-1;%kon1=0.1*6E-5;
koff1=5E-4*60*5;
k1 = 6*10;%6
kn1 = .05*60;%kn1 = .05*60;
kcat1 = 0.01*60*20;%0.01*60;
k2 = 6*50;%6
kn2 = 0.1*60;%0.1*60;
kcat2 = .01*60*50;%.01*60;
k3 = 6*5;%6
kn3 = 0.01*60;%0.01*60;
kcat3 = 0.01*60*50;%0.01*60;
k4 = 6*100;%6;
kn4 = 0.1*60;
kcat4 = .01*60;%.01*60;
kon2 = 6;
koff2 = .05*60;
beta = 2.079E-8*60;
alpha = 0.00693*60*1E-6;

% Define state conditions, should be in the same order as your intial
% condition vector, 
%t = y(1);
RTK = y(1);
A = y(2);
As = y(3);
S = y(4);
Ss = y(5);
GFP = y(6);
C = y(7);
Erev1 = y(8);
Erev2 = y(9);
tRTK = y(10);
SAs = y(11);
tRTKA = y(12);
Erev1As = y(13);
Erev2Ss = y(14);

% Determine ODEs of the system
%dtdt = 0;
dRTKdt = - kon1*toxin*RTK + koff1*tRTK;
dAdt = - k1*tRTK*A + kn1*(tRTK*A/(A+(kn1+kcat1)/k1))...
    + kcat2*(Erev1*As/(As+(kn2+kcat2)/k2));% tRTKA = (tRTK*A/(A+(kn1+kcat1)/k1))
dAsdt = kcat1*(tRTK*A/(A+(kn1+kcat1)/k1))...
    + kn2*(Erev1*As/(As+(kn2+kcat2)/k2)) - k2*Erev1*As...
    + (kcat3*SAs)*1.00 - k3*S*As + kn3*SAs; %SAs = (As*S)/(S+(kn3+kcat3)/k3))
dSdt = - k3*S*As + kn3*SAs + kcat4*(Erev2*Ss/(Ss+(kn4+kcat4)/k4));
dSsdt = kcat3*SAs - k4*Erev2*Ss + kn4*(Erev2*Ss/(Ss+(kn4+kcat4)/k4))...
    - kon2*Ss*GFP + koff2*C;
dGFPdt = beta - alpha*GFP + koff2*C - kon2*Ss*GFP;
dCdt = kon2*Ss*GFP - koff2*C;
dErev1dt = - k2*Erev1*As + (kn2+kcat2)*(Erev1*As/(As+(kn2+kcat2)/k2));
    % Erev1As = (Erev1*As/(As+(kn2+kcat2)/k2))
dErev2dt = - k4*Erev2*Ss + (kn4+kcat4)*(Erev2*Ss/(Ss+(kn4+kcat4)/k4));
    % Erev2Ss = (Erev2*Ss/(Ss+(kn4+kcat4)/k4))
dtRTKdt = kon1*toxin*RTK - koff1*tRTK;
dSAsdt = k3*S*As - (kn3+kcat3)*SAs;
dtRTKAdt = 0;
dErev1Asdt = 0;
dErev2Ssdt = 0;


% Define function output, should be in same order as intial condition
% vector, separated by semicolon
dydt = [dRTKdt;dAdt;dAsdt;dSdt;dSsdt;dGFPdt;dCdt;dErev1dt;...
    dErev2dt;dtRTKdt;dSAsdt;dtRTKAdt;dErev1Asdt;dErev2Ssdt];
%dydt = [dtdt;dRTKdt;dAdt;dAsdt;dSdt;dSsdt;dGFPdt;dCdt;dErev1dt;...
%    dErev2dt;dtRTKdt;dSAsdt;dtRTKAdt;dErev1Asdt;dErev2Ssdt];

return