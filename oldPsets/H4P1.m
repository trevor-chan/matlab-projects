load('config1.mat');

beta = acos(dot(z,zp));
alpha = asin(dot(y,zp)/sin(beta));
gamma = asin(dot(z,yp)/sin(beta));

Rzalpha = [cos(-alpha),sin(-alpha),0;-sin(-alpha),cos(-alpha),0;0,0,1];
Rybeta = [cos(-beta),0,-sin(-beta);0,1,0;sin(-beta),0,cos(-beta)];
Rzgamma = [cos(-gamma),sin(-gamma),0;-sin(-gamma),cos(-gamma),0;0,0,1];

A = Rzalpha*Rybeta*Rzgamma;
xcalc = A*x;
ycalc = A*y;
zcalc = A*z;

%Plot the original and rotated vectors
figure(1)
subplot(1,2,1);
rotate3d on;
zerovect = zeros(3,1);
hold on;
plot3([0,xp(1)],[0,xp(2)],[0,xp(3)],'b','LineWidth',2);
plot3([0,yp(1)],[0,yp(2)],[0,yp(3)],'b','LineWidth',2);
plot3([0,zp(1)],[0,zp(2)],[0,zp(3)],'b','LineWidth',2);
plot3([0,xcalc(1)],[0,xcalc(2)],[0,xcalc(3)],'k--','Linewidth',4);
plot3([0,ycalc(1)],[0,ycalc(2)],[0,ycalc(3)],'k--','Linewidth',4);
plot3([0,zcalc(1)],[0,zcalc(2)],[0,zcalc(3)],'k--','Linewidth',4);

xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
grid on;

%PART B

load('config2.mat');
b = asin(-dot(z,xp));
g = asin(dot(y,xp)/cos(b));
a = asin(dot(z,yp)/cos(b));

Rxa = [1,0,0;0,cos(a),-sin(a);0,sin(a),cos(a)];
Ryb = [cos(b) 0 sin(b) ; 0 1 0 ; -sin(b) 0 cos(b)];
Rzg = [cos(g) -sin(g) 0 ; sin(g) cos(g) 0 ; 0 0 1];

D = Rzg*Ryb*Rxa;
xcalc2 = D*x;
ycalc2 = D*y;
zcalc2 = D*z;

subplot(1,2,2);
hold on;
plot3([0,xp(1)],[0,xp(2)],[0,xp(3)],'b','LineWidth',2);
plot3([0,yp(1)],[0,yp(2)],[0,yp(3)],'b','LineWidth',2);
plot3([0,zp(1)],[0,zp(2)],[0,zp(3)],'b','LineWidth',2);
plot3([0,xcalc2(1)],[0,xcalc2(2)],[0,xcalc2(3)],'k--','Linewidth',4);
plot3([0,ycalc2(1)],[0,ycalc2(2)],[0,ycalc2(3)],'k--','Linewidth',4);
plot3([0,zcalc2(1)],[0,zcalc2(2)],[0,zcalc2(3)],'k--','Linewidth',4);

xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
grid on;