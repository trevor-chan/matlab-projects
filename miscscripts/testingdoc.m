
xold = 80; %Initial guess 
fold = f(xold,1.0e-8); %Initial value of f
n = 0; %Iteration counter
nmax = 50; % Maximum number of allowed iterations
TOL = 1e-9; %Tolerance for |f(xn)|
error = abs(fold); %Initial error
karray = [0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08];
timearray = [];
xnew = 60;
while (error >= TOL && n < nmax)
    k = 1.0*10^-8;
    dfold = df(xold,k);
    xnew = xold - fold/dfold;
    fnew = f(xnew,k);
    error = abs(fnew); %Calculate the new error
    xold = xnew;
    fold = fnew;
    n = n + 1; % Update the iteration 
end
baserange = xnew;
baserange
timearray = [timearray,xnew];

function val = f (t,k)
    %val = ((k*600*sin(pi/3)+9.81)/(9.81*k))*(1-exp(-1*k*t))-t;
    val = ((k*600*sin(pi/3)+9.81)/(9.81*k))*(1-exp(-1*k*t))-t;
end 

function val = df(t,k)
    val = ((k*600*sin(pi/3)+9.81)/(9.81))*(exp(-1*k*t));
end 

