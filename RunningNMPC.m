clear all
clc
Nu=4;
tf=30;
Dt=0.5;
m=2;
n=6;
Rs=.3;
Umax=100;
W=load('weights.mat');
b=load('biases.mat');

W1=W.W1';
W2=W.W2';
W3=W.W3';

b1=b.Hbias1';
b2=b.Hbias2';
b3=b.Hbias3';
load('beta.mat');
CaseNum=input('Enter case number: ');
switch CaseNum
    case 1
        X0=[-2 -3 .03 .454 .88 .1363]';
        Xd=[0 0 1 0 0 0]';
    case 2
        X0=[1 2 .5 .5 .5 .5]';
        Xd=[0 0 .7071 0 .7071 0]';
        
    case 3
        X0=[0 0 .6521 .1132 .1115 .7413]';
        Xd=[0 0 1 0 0 0]';
    case 4
        X0=[0 0 .2734 .5628 .4281 .6521]';
        Xd=[0 0 .7071 0 .7071 0]';
    case 5
        X0=[0 0 sin(pi/3) cos(pi/3) 0 0]';
        Xd=[0 0 sin(pi/8) cos(pi/8) 0 0]';
end
t1=cputime;
MPC=ModelPredictiveControl(n,m,Nu,tf,Dt,X0,Xd,Umax,W1,W2,W3,b1,b2,b3,beta);
t2=cputime;
SimulationTime=t2-t1;
StepNum=tf/Dt;
StepTimeSimulation=SimulationTime/StepNum;
subplot(2,2,1)
plot(MPC{2},MPC{3})
xlabel('Time (s)');
ylabel('State Variables');
title('Time - State Variables');
grid on
hold on
subplot(2,2,2)
plot(MPC{2},MPC{3}(:,1:2))
xlabel('Time (s)');
ylabel('Position (m)');
title('Time - Position');
grid on
hold on
subplot(2,2,3)
plot(MPC{3}(:,1),MPC{3}(:,2))
xlabel('X (m)');
ylabel('Y (m)');
title('Position Trajectory');
grid on
hold on
subplot(2,2,4)
plot(MPC{2},MPC{3}(:,3:6))
xlabel('Time (s)');
ylabel('Euler Angles (rad)');
title('Time - Attitude');
grid on

