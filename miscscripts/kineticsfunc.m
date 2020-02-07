
function dydt=f(t,y,flag,k1,k_1,k2)
%y(1)=A, y(2)=B, y(3)=C

%set up differential equations

dydt=[-k1*y(1)+k_1*y(2);
    k1*y(1)-k_1*y(2)-k2*y(2);
    k2*y(2)];

