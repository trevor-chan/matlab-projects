function [output,outputTime,input,inputTime] = ...
    sensorODE_solver(sensorODE_fh,inputStates,chatter,stochasticity,...
    maxInputAmpl,initCond)
%--------------------------------------------------------------------------
narginchk(2,6)
if ~isa(sensorODE_fh, 'function_handle')
    error('sensorODE_solver:sensorODE_fhChk','%s is not a valid fuction handle.',...
        func2str(sensorODE_fh))
end

if ~all(inputStates(:,1) == 0 | inputStates(:,1) == 1) || ~isequal(size(inputStates,2),2)
   error('sensorODE_solver:inputStatesChk',...
  'The ''inputStates'' argument must be a matrix with 1 column of either 0s or 1s and 1 column of time.')
end

if ~islogical(chatter)
    error('sensorODE_solver:chatterChk',...
        'The ''chatter'' flag must be set to ''true'' or ''false''.')
end
if ~islogical(stochasticity)
    error('sensorODE_solver:stochasticityChk',...
        'The ''stochasticity'' flag must be set to ''true'' or ''false''.')
end
if chatter && stochasticity
    error('sensorODE_solver:chatterAndstochasticityChk',...
        'The ''chatter'' and ''stochasticity'' flags may not be ''true'' simultaneously.')
end

%% Define simulation time characteristics
nSteps = size(inputStates,1);
for i=1:nSteps
    tStep(i) = inputStates(i,2);
end
tMax = sum(tStep);
tSpan = [0 tMax-1];

%% Define input characteristics
maxInput = maxInputAmpl;
inputTime = 0:1:tSpan(end);

%% Create input vectors
input = [];
for aStep = 1:nSteps
    thisStepVector = repmat(inputStates(aStep,1),tStep(aStep),1);
    input = [input thisStepVector'];
end

if chatter
    noiseProb = 0.02;
    randV = rand(1,tMax);
    input(randV<noiseProb) = ~input(randV<noiseProb);
end

if stochasticity
    noiseMean = 0;
    noiseVar = .01/maxInput;
    input = abs(input+(noiseMean + sqrt(noiseVar)*randn(1,tMax)));
end

input = input*maxInput;
%% Define the initial conditions and run ODE solver
y0 = initCond;
[outputTime,output] = ode23s(@(t,y) sensorODEVectorInputs(sensorODE_fh,...
    t,y,inputTime,input),tSpan,y0);
end
function dydt = sensorODEVectorInputs(sensorODE_fh,t,y,inputTime,input)
in1 = interp1(inputTime,input(1,:),t);
dydt = sensorODE_fh(t,y,[in1]);
end