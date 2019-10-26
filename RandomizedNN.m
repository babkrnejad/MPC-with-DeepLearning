clear all 
clc
% %Data
NS = 100000 ; % Number of Sample
NHN = 100; % Number of Hidden Layer
DI = 4 ; % Dimention of Inputs 
DO = 36; % Dimention of Outputs


input= Generate_Random_Number(DI,NS) ;
target = zeros(NS,DO);
for i=1:NS
    target(i,:) = GXX(input(i,:));
    
end

%% Rnadomized Weights and bias  
% RBM = load('W.mat');
% W = RBM.W';
% b = RBM.Hbias';
W = 2*rand(NHN,DI) - ones(NHN,DI);
b = 2*rand(NHN,1) - ones(NHN,1);


%% training 
say=zeros(NS,NHN);

for i=1:NS
    
        say(i,:) =Sigma(W*input(i,:)' + b);
        
    
    
end

beta = pinv(say)*target ;

TrainError = say*beta - target; % train error
%plot(TR(:,:));

%% test 
NTS = 50 ; % Number of Test Sample
x = Generate_Random_Number(DI,NTS)  ;
y= zeros(NTS,DO);
for i=1:NTS
    y(i,:) = GXX(x(i,:));
  
end

TS=zeros(NTS,NHN);

for i=1:NTS
    for j=1:NHN
        TS(i,j) =Sigma(W(j,:)*x(i,:)' + b(j));
        
    end
    
end




predictY = TS*beta;
TestError = predictY - y ;


TrainRMSE = mean(sqrt(sum(TrainError.^2)/NS))
TestRMSE  = mean(sqrt(sum(TestError.^2)/NTS)) 
predictY=round(predictY,6);

save('b.mat')

