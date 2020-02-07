M = [5/4 sqrt(3)/4 -1 0 -1/4 -sqrt(3)/4 ; sqrt(3)/4 3/4 0 0 -sqrt(3)/4 -3/4 ; -1 0 5/4 -sqrt(3)/4 -1/4 sqrt(3)/4 ; 0 0 -sqrt(3)/4 3/4 sqrt(3)/4 -3/4 ; -1/4 -sqrt(3)/4 -1/4 sqrt(3)/4 1/2 0 ; -sqrt(3)/4 -3/4 sqrt(3)/4 -3/4 0 3/2];

[V,D] = eig(M);

l = 20;
x0 = [0 l l/2];
y0 = [0 0 sqrt(3)*l/2];
w = D(6,6);
A = zeros(1,6);
for i=1:6
    A(i) = V(i,6);
end


dt = 0.1; %Timestep 
phi = pi/8;
psi = pi/6;
theta = pi/12;

for nt = 0:1000
t = dt*nt; 
x1 = x0(1)+A(1)*cos(w*t);
x2 = x0(2)+A(3)*cos(w*t);
x3 = x0(3)+A(5)*cos(w*t);
y1 = y0(1)+A(2)*cos(w*t);
y2 = y0(2)+A(4)*cos(w*t);
y3 = y0(3)+A(6)*cos(w*t);

circle(x1,y1,1);
circle(x2,y2,1);
circle(x3,y3,1);
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
xlim([-3 23]);
ylim([-3 23]);
pbaspect([1 1 1])
end