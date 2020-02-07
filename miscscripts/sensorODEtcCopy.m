function dydt = sensorODEtcCopy(toxin,y,u)
%% Define input conditions:
toxin = u(1);

%% Define parameter rate constants
% Parameters have units of uM and minutes

%{
%% SECTION adjusted for slower response (10x slower)
%toxin to RTK binding
kon1=6E-1;%kon1=0.1*6E-5;
koff1=5E-4*60*5;

%A->As by t-RTK
k1 = 6;%6
kn1 = .05*60;%kn1 = .05*60;
kcat1 = 0.01*60;%0.01*60;

%As->A by Erev1
k2 = 6*10;%6
kn2 = 0.1*60;%0.1*60;
kcat2 = .01*60*10;%.01*60;

%S->Ss by As
k3 = 6*35;%6
kn3 = 0.01*60;%0.01*60;
kcat3 = 0.01*60*30;%0.01*60;

%Ss->S by Erev2
k4 = 6*.1;%6;
kn4 = 0.1*60*.1;%0.1*60
kcat4 = .01*60*20;%.01*60;

%S to GFP binding
kon2 = 6;
koff2 = .05*60;

%Constitutive expression of GFP
beta = 2.079E-8*60;
alpha = 0.00693*60*1E-6;

%Constitutive expression of Erev2
E2beta = 0.001;
E2alpha = 0.01;

%Constitutive expression of A
Abeta = 0.00001;
Aalpha = 0.0002;

%Constitutive expression of S
Sbeta = 0.0006;
Salpha = 0.0002;
%}

%toxin to RTK binding
kon1=6;%kon1=0.1*6E-5;
koff1=5E-4*60*50;

%A->As by t-RTK
k1 = 60;%6
kn1 = .05*600;%kn1 = .05*60;
kcat1 = 0.01*600;%0.01*60;

%As->A by Erev1
k2 = 6*100;%6
kn2 = 0.1*600;%0.1*60;
kcat2 = .01*60*100;%.01*60;

%S->Ss by As
k3 = 6*350;%6
kn3 = 0.01*600;%0.01*60;
kcat3 = 0.01*60*300;%0.01*60;

%Ss->S by Erev2
k4 = 6;%6;
kn4 = 0.1*60;%0.1*60
kcat4 = .01*60*200;%.01*60;

%S to GFP binding
kon2 = 60;
koff2 = .05*600;

%Constitutive expression of GFP
beta = 2.079E-8*600;
alpha = 0.00693*60*1E-5;

%Constitutive expression of Erev2
E2beta = 0.01;
E2alpha = 0.1;

%Constitutive expression of A
Abeta = 0.0001;
Aalpha = 0.002;

%Constitutive expression of S
Sbeta = 0.006;
Salpha = 0.002;

%% Define state conditions
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

%% Determine ODEs of the system
dRTKdt   = - kon1*toxin*RTK + koff1*tRTK;

dAdt     = - k1*tRTK*A + kn1*(tRTK*A/(A+(kn1+kcat1)/k1))...
           + kcat2*(Erev1*As/(As+(kn2+kcat2)/k2))...
           + Abeta - Aalpha*A;

dAsdt    = kcat1*(tRTK*A/(A+(kn1+kcat1)/k1))...
           + kn2*(Erev1*As/(As+(kn2+kcat2)/k2)) - k2*Erev1*As...
           + (kcat3*SAs) - k3*S*As + kn3*SAs;

dSdt     = - k3*S*As + kn3*SAs + kcat4*(Erev2*Ss/(Ss+(kn4+kcat4)/k4))...
           + Sbeta - Salpha*S;

dSsdt    = kcat3*SAs - k4*Erev2*Ss + kn4*(Erev2*Ss/(Ss+(kn4+kcat4)/k4))...
           - kon2*Ss*GFP + koff2*C;

dGFPdt   = beta - alpha*GFP + koff2*C - kon2*Ss*GFP;

dCdt     = kon2*Ss*GFP - koff2*C;

dErev1dt = - k2*Erev1*As + (kn2+kcat2)*(Erev1*As/(As+(kn2+kcat2)/k2));

dErev2dt = - k4*Erev2*Ss + (kn4+kcat4)*(Erev2*Ss/(Ss+(kn4+kcat4)/k4))...
           + E2beta - E2alpha*Erev2;

dtRTKdt  = kon1*toxin*RTK - koff1*tRTK;

dSAsdt   = k3*S*As - (kn3+kcat3)*SAs;

dtRTKAdt = 0;

dErev1Asdt = 0;

dErev2Ssdt = 0;

%{
QSSA Approximations:
  tRTKA = (tRTK*A/(A+(kn1+kcat1)/k1))
  Erev1As = (Erev1*As/(As+(kn2+kcat2)/k2))
  Erev2Ss = (Erev2*Ss/(Ss+(kn4+kcat4)/k4))
%}

%% Define function output
dydt = [dRTKdt;dAdt;dAsdt;dSdt;dSsdt;dGFPdt;dCdt;dErev1dt;...
    dErev2dt;dtRTKdt;dSAsdt;dtRTKAdt;dErev1Asdt;dErev2Ssdt];

return