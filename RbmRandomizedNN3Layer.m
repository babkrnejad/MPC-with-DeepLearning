
clc

%% Data
NS = 100000; % Number of Sample
NHN1 = 128; % Number of Hidden Layer 1
NHN2 = 256;
NHN3 = 512;

DI = 4 ; % Dimention of Inputs 
DO = 36; % Dimention of Outputs


input= Generate_Random_Number(DI,NS) ;
target = zeros(NS,DO);
for i=1:NS
    target(i,:) = GXX(input(i,:));
    
end

% Load Weights and biases
W=load('weights.mat');
b=load('biases.mat');

W1=W.W1';
W2=W.W2';
W3=W.W3';

b1=b.Hbias1';
b2=b.Hbias2';
b3=b.Hbias3';

%% training 
say=zeros(NS,NHN3);

for i=1:NS
    say(i,:) = tanh(W3*tanh(W2*tanh(W1*input(i,:)' + b1) + b2)+b3);
            
end

beta = pinv(say)*target ;

TrainError = say*beta - target; % train error
%plot(TR(:,:));


%% test 
NTS = 400 ; % Number of Test Sample
x = Generate_Random_Number(DI,NTS)  ;
y= zeros(NTS,DO);
for i=1:NTS
    y(i,:) = GXX(x(i,:));
  
end
TS=zeros(NTS,NHN3);

for i=1:NTS
    TS(i,:) =tanh(W3*tanh(W2*tanh(W1*x(i,:)' + b1) + b2)+b3);
end




predictY = TS*beta;
TestError = predictY - y ;


%% RMSE for Train data
TrainRMSE = mean(sqrt(sum(TrainError.^2)/NS))
TestRMSE  = mean(sqrt(sum(TestError.^2)/NTS))

save beta.mat beta










