f = [0.197 0.277 0.371 0.472 0.575 0.673 0.757 0.828];
t = [45.4 46.3 47.2 48.1 49 49.9 50.8 51.7];
t = t+273;
k = ((1-f)./f);
y = reallog(k);

figure(1)
plot(1./(t),y);
title('vant Hoff plot');
xlabel('temperature (K)');
ylabel('ln(Keq)');
[delH,delS] = func1(f,t);

%b; pass f and t(Kelvin) and return H and S
function [delH,delS] = func1(f,t)
    %t = t+273;
    k = ((1-f)./f);
    y = reallog(k);
    fn = polyfit(1./t,y,1);
    R = 8.314;
    delH = -1*fn(1)*R;
    delS = fn(2)*R;
end