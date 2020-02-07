%% Three masses and four springs system
%Assume original distace between masses is 10
option = 3;
%Original postions of the masses 
x0 = [0 10 20];
% The lowest frequency,masses moving together 
if option == 1
    w = sqrt(2)*(1-1/sqrt(2))^(1/2);
    A1 = 1/2;
    A2 = 1/sqrt(2);
    A3 = 1/2;
% The medium frequency 
elseif option == 2
    w = sqrt(2);
    A1 = -1/sqrt(2);
    A2 = 0;
    A3 = 1/sqrt(2);
% Option 3, The highest frequency, masses moving against each other
else
    w = sqrt(2)*(1+1/sqrt(2))^(1/2);
    A1 = 1/2;
    A2 = -1/sqrt(2);
    A3 = 1/2;
end
dt = 0.1; %Timestep 
phi = pi/8;
psi = pi/6;
theta = pi/12;

for nt = 0:1000
t = dt*nt; 
x1 = x0(1)+A1*cos(w*t+phi);
x2 = x0(2)+A2*cos(w*t+psi);
x3 = x0(3)+A3*cos(w*t+theta);
circle(x1,0,1);
circle(x2,0,1);
circle(x3,0,1);
drawnow;
hold off
end 

%Draw a circle
function circle(x,y,r)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,'b','LineWidth',2);
hold on;
xlim([-3 25]);
ylim([-2 2]);
pbaspect([7 1 1])
end