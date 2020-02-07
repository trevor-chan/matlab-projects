
told = 100; %Initial guess 
fold = f(told,1.0e-8); %Initial value of f
n = 0; %Iteration counter
nmax = 50; % Maximum number of allowed iterations
TOL = 1e-9; %Tolerance for |f(xn)|
error = abs(fold); %Initial error
karray = [0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08];%nonzero values for airresistance
ratioarray = [];
rangearray = [];
tarray = [];
%calculate range in absence of air resistance
while (error >= TOL && n < nmax)
    k = 1.0*10^-8;
    dfold = df(told,k);
    tnew = told - fold/dfold;
    fnew = f(tnew,k);
    error = abs(fnew); %Calculate the new error
    told = tnew;
    fold = fnew;
    n = n + 1; % Update the iteration
end
basetime = tnew;
tarray = [tarray,basetime];
baserange = range(tnew,k);
rangearray = [rangearray, baserange];
ratioarray = [ratioarray,1];
%calculate range with air resistance values k specified
for index = 1:8
    k = karray(index);
    told = basetime;
    fold = f(told,k); %Initial value of f
    n = 0; %Iteration counter
    nmax = 50; % Maximum number of allowed iterations
    error = abs(fold); %Initial error
    while (error >= TOL && n < nmax)
        dfold = df(told,k);
        tnew = told - fold/dfold;
        fnew = f(tnew,k);
        error = abs(fnew); %Calculate the new error
        told = tnew;
        fold = fnew;
        n = n + 1; % Update the iteration 
    end
    newratio = range(tnew,k)/baserange;
    rangearray = [rangearray, range(tnew,k)];
    ratioarray = [ratioarray,newratio];
    tarray = [tarray,tnew];
end

perturbationratio = [];
perturbationratio = [perturbationratio, prange(1e-8)];
for index = 1:8
    perturbationratio = [perturbationratio, prange(karray(index))];
end
karray = [0,karray];

plot(karray,ratioarray,'ro-')
hold on;
plot(karray,perturbationratio,'bo-')
title('range ratios dependent on air resistance, simulated and calculated');
xlabel('air resistance constant k');
ylabel('range ratio');
legend('newtonratio','perturbationratio');

fprintf('   k             T           Ratio\n');
fprintf('-------------------------------\n');
fformat = '%6.3f       %7.3f        %6.3f   \n';
for i=1:9
    fprintf(fformat,karray(i),tarray(i),ratioarray(i))
end




function val = f (t,k)
    val = (((k*600*sin(pi/3)+9.81)/(9.81*k))*(1-exp(-k*t)))-t;
end 

function val = df(t,k)
    val = ((k*600*sin(pi/3)+9.81)/(9.81))*(exp(-k*t))-1;
end

function val = range(t,k)
    val = (600*cos(pi/3)/k)*(1-exp(-k*t));
end

function val = prange(k)
    val = 1-(4/3)*(600*sin(pi/3)*k)/(9.8);
end

%not needed
function val = pprange(k)
    val = ((2*600*600*cos(pi/3)*sin(pi/3))/(9.81))*(1-(4*600*sin(pi/3)*k)/(3*9.81));
end
