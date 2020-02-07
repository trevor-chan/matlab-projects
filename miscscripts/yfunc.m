function dydt=yfunc(t,y,flag,k1,kn1,kcat)
    %y(1)=E, y(2)=S, y(3)=ES
    dydt = [-k1*y(1)*y(2)+kn1*y(3)+kcat*y(3);-k1*y(1)*y(2)+kn1*y(3);k1*y(1)*y(2)-kn1*y(3)-kcat*y(3)];