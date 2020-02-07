%ProblemSet1Problem3

r = 2:0.1:20;
cc=zeros(1,length(r));
cp=zeros(1,length(r));
pp=zeros(1,length(r));

%charge charge interaction
for i = 1:length(r)
    a = potential(.5,-.5,r(i)-1);
    b = potential(.5,-.5,r(i)+1);
    c = potential(.5,-.5,r(i));
    cc(i) = a+b+2*c;
end

%charge polar interaction
for i = 1:length(r)
    a = potential(.5,.5,r(i));
    b = potential(.5,-.5,r(i)-1);
    c = potential(.5,-.5,r(i));
    d = potential(.5,.5,r(i)+1);
    cp(i) = a+b+c+d;
end

%polar polar interaction
for i = 1:length(r)
    a1 = potential(.5,-.5,r(i)-1);
    a2 = potential(-.5,.5,r(i)+1);
    b = potential(.5,.5,r(i));
    pp(i) = a1+a2+2*b;
end

%plotting graphs
figure(1)
plot(r,cc);
hold on;
plot(r,cp);
plot(r,pp);
ylim([-7E-19,1E-19])

title('coulombic interactions between charged particles');
xlabel('interparticle distance (angstroms)');
ylabel('interaction energy (J)');
legend('charge-charge','charge-polar','polar-polar');

function U = potential(q1,q2,r)
    e = 1.6*10^-19;
    E = 8.85*10^-12;
    D = 2;
    U = (q1*q2*e^2)/(D*4*pi*E*r*10^-10);
end

