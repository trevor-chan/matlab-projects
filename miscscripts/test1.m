function dydt = sensorODE(t,y,u)
% Vector 'y' contains initial conditions for each state value.
% Vector 'u' contains values for input 1 which is the toxin concentration
% You do not need to modify 'u' within the code (ie you should not have an
% ODE for toxin concentration, you can assume it is large enough that
% binding will not deplete it. 
%
% Each time that the toxin would be interacting with your species, simply
% multiply that portion by toxin, ie for protein ligand binding, where L is
% the toxin, the ODEs would be written as:
%   dpdt = -kon*p*toxin + koff*c;
%   dcdt = kon*p*toxin - koff*c;
%
% The toxin does not need an ODE to track its concentration, as we have set
% up the problem such that toxin concentration is much larger. 
%
% The function output should be a vector describing only dydt.

% Define input conditions: * Do Not Alter *
toxin = u(1);

%% Alter the following for your system

% Define parameter rate constants
% Parameters will have units of uM and minutes
kon= ... etc, 

% Define state conditions, should be in the same order as your intial
% condition vector, 
p = y(1) ... etc,


% Determine ODEs of the system
dpdt = ... etc,

% Define function output, should be in same order as intial condition
% vector, separated by semicolon
dydt = [...; ];

return