v = [0,0,1];
n = [0,0,0];
nn = [0,0,0];

prompt = 'input coordinate for n(1):   ';
v(1) = input(prompt);
prompt = 'input coordinate for n(2):   ';
v(2) = input(prompt);
prompt = 'input coordinate for n(3):   ';
v(3) = input(prompt);

%length = sqrt(dot(v,v));
%for i=1:3
%   n(i) = v(i)/length; 
%end
%phi = acos(n(1)/sin(acos(n(3))));
phi = atan(n(2)/n(1));
if n(1) < 0
    phi = phi+pi;
end
theta = acos(n(3));

Mz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0;0 0 1];
My = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];

nn = Mz*My*v;
    

fprintf('theta = %4.3f , phi = %4.3f , resulting unit vector = {%4.3f,%4.3f,%4.3f}',theta,phi,nn(1),nn(2),nn(3));