% Root finding Newton's method for f = x^2 - 5 = 0
% Created by Aya Nawano on September 20th, 2017

xold = 1; %Initial guess 
fold = f(xold); %Initial value of f
n = 0; %Iteration counter
nmax = 50; % Maximum number of allowed iterations
TOL = 1e-5; %Tolerance for |f(xn)|
error = abs(fold); %Initial error

while (error >= TOL && n < nmax)
    dfold = df(xold);
    xnew = xold - fold/dfold;
    fnew = f(xnew);
    error = abs(fnew); %Calculate the new error
    
    xold = xnew;
    fold = fnew;
    n = n + 1; % Update the iteration 
end
fprintf('Newton method converged to %.6f after %d interations.\n',xnew,n);

%Evaluate value of the function x^2 - 5 with a given x 
function val = f (x)
    val = x^2-5;
end 

%Evaluate values of the derivative of x^2 - 5 with a given x 
function val = df(x)
    val = 2*x;
end 

