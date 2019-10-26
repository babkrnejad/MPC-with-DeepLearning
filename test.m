
X0=[0 0 1 0 0 0]';
U=[25,-60];

W=load('weights.mat');
b=load('biases.mat');

W1=W.W1';
W2=W.W2';
W3=W.W3';

b1=b.Hbias1';
b2=b.Hbias2';
b3=b.Hbias3';
load('beta.mat');
[Time,Zreal]=ode113(@(tt,q) PlantCAM(tt,q,U),[0 5],X0)

[Time1,Zpredict] = ode113(@(tt,q) nnplant1(tt,q,U,W1,W2,W3,b1,b2,b3,beta),[0 5],X0);

p=plot(Time1,Zpredict(:,1:2),'.');
p(1).LineWidth = 1.5;
hold on 
p=plot(Time,Zreal(:,1:2));
p(1).LineWidth = 1.5;








