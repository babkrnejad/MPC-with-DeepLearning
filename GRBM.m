tic

clc ;
close all ;
%% Constant 
NVN = 4 ;  % Number of Visible Neurons
NHN1 = 128; % Number of Hidden Layer 1
NHN2 = 256;
NHN3 = 512;

LR1 = 0.0001; % Learning Rate 
LR2 = 0.0001;
LR3 = 0.0001;
NS = 1000 ;   % Number of Sample
epoch =10;






%% Data  Normalization 

% Genarate random number with this relation: q1^2  + q2^ 2 + q3^2 + q4^2=1
q = Generate_Random_Number(NVN,NS);
%q = 2*rand(NS,NVN) - ones(NS,NVN);
input = q ;
Std = std(input);
Mean = mean(input);
V=zeros(NS,NVN);
for i=1:NVN
    
    for j=1:NS
        V(j,i)=(input(j,i)-Mean(1,i))/Std(1,i); % 
    end
    
end 
%% RBM 1
% Initialize the weights randomly and set the bias values to zero 

W1=4*rand(NVN,NHN1) - ones(NVN,NHN1); %  initial  weight with 0.01 std and 0 mean
Vbias1 = zeros(1,NVN) ;     % Inintial Visible bias are zero
Hbias1 = zeros(1,NHN1) ;     % Initial Hidden bias are zero
PH1 = zeros(NS,NHN1);
NH1 = zeros(NS,NHN1);

% Traning phase 

H1=zeros(1,NHN1) ;
Vprime1=zeros(1,NVN);

for i=1:NS
    for k=1:epoch
    
        
    PH1(i,:)=tanh(V(i,:)*W1 + Hbias1(1,:) ); % Posetive Hidden 
    for j=1:NHN1
    if PH1(i,j)>rand(1)
        H1(i,j)=1;
    else
        H1(i,j)=0;
    end    
    end
    
    Vprime1(i,:) =  H1(i,:)*W1' + Vbias1(1,:) ;
    
    
    NH1(i,:)=tanh(Vprime1(i,:)*W1 + Hbias1(1,:)); % Negative Hidden
    
    % Update Weights and biases
    
    DW1=LR1*(V(i,:)'*PH1(i,:) - Vprime1(i,:)'*NH1(i,:));
    Dvb1=LR1*(V(i,:) - Vprime1(i,:));
    Dhb1=LR1*(PH1(i,:) - NH1(i,:));
    
    W1 = W1 + DW1 ;
    Vbias1 = Vbias1 + Dvb1 ;
    Hbias1 = Hbias1 + Dhb1 ;
    end
    
   
end 
%% RBM 2
W2=2*rand(NHN1,NHN2) - ones(NHN1,NHN2); %  initial  weight with 0.01 std and 0 mean
Vbias2 = zeros(1,NHN1) ;     % Inintial Visible bias are zero
Hbias2 = zeros(1,NHN2) ;     % Initial Hidden bias are zero
PH2 = zeros(NS,NHN2);
NH2 = zeros(NS,NHN2);

% Traning phase 
H2=zeros(1,NHN2) ;
Vprime2=zeros(1,NHN1);

for i=1:NS
    for k=1:epoch
    
        
    PH2(i,:)=tanh(H1(i,:)*W2 + Hbias2(1,:) ); % Posetive Hidden 
    for j=1:NHN2
    if PH2(i,j)>rand(1)
        H2(i,j)=1;
    else
        H2(i,j)=0;
    end    
    end
    
    Vprime2(i,:) =  H2(i,:)*W2' + Vbias2(1,:) ;
    
    
    NH2(i,:)=tanh(Vprime2(i,:)*W2 + Hbias2(1,:)); % Negative Hidden
    
    % Update Weights and biases
    
    DW2=LR2*(H1(i,:)'*PH2(i,:) - Vprime2(i,:)'*NH2(i,:));
    Dvb2=LR2*(H1(i,:) - Vprime2(i,:));
    Dhb2=LR2*(PH2(i,:) - NH2(i,:));
    
    W2 = W2 + DW2 ;
    Vbias2 = Vbias2 + Dvb2 ;
    Hbias2 = Hbias2 + Dhb2 ;
    end
end
%% RBM 3
W3=2*rand(NHN2,NHN3) - ones(NHN2,NHN3); %  initial  weight with 0.01 std and 0 mean
Vbias3 = zeros(1,NHN2) ;     % Inintial Visible bias are zero
Hbias3 = zeros(1,NHN3) ;     % Initial Hidden bias are zero
PH3 = zeros(NS,NHN3);
NH3 = zeros(NS,NHN3);

% Traning phase 
H3=zeros(1,NHN3) ;
Vprime3=zeros(1,NHN2);

for i=1:NS
    for k=1:epoch
    
        
    PH3(i,:)=tanh(H2(i,:)*W3 + Hbias3(1,:) ); % Posetive Hidden 
    for j=1:NHN3
    if PH3(i,j)>rand(1)
        H3(i,j)=1;
    else
        H3(i,j)=0;
    end    
    end
    
    Vprime3(i,:) =  H3(i,:)*W3' + Vbias3(1,:) ;
    
    
    NH3(i,:)=tanh(Vprime3(i,:)*W3 + Hbias3(1,:)); % Negative Hidden
    
    % Update Weights and biases
    
    DW3=LR3*(H2(i,:)'*PH3(i,:) - Vprime3(i,:)'*NH3(i,:));
    Dvb3=LR3*(H2(i,:) - Vprime3(i,:));
    Dhb3=LR3*(PH3(i,:) - NH3(i,:));
    
    W3 = W3 + DW3 ;
    Vbias3 = Vbias3 + Dvb3 ;
    Hbias3 = Hbias3 + Dhb3 ;
    end
end  
toc

save Weights W1 W2 W3
save biases Hbias1 Hbias2 Hbias3










