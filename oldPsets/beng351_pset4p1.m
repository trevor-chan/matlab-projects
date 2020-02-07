
syms p0 p1 p2 p3 p4;
Ku = 10E-9;
%l0 = 2E-9;
l0 = 1E-9:1E-10:1.5E-8;
pi = 1E-12;
%kd = [1/4*Ku;2/3*Ku;3/2*Ku;4*Ku];
for i = 1:length(l0)
    S(i) = solve(1/4*Ku==p0*l0(i)/p1,2/3*Ku==p1*l0(i)/p2,3/2*Ku==p2*l0(i)/p3,4*Ku==p3*l0(i)/p4,pi==p0+p1+p2+p3+p4);
end
figure(1);


p1c = [];
p2c = [];
for i = 1:length(l0)
    p1c(i) = vpa(S(i).p1);
    p2c(i) = vpa(S(i).p2);
end

plot(l0,p1c);
hold on
plot(l0,p2c);
legend('concentration of p1','concentration of p2');
