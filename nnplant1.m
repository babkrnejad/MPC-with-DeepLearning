function dqdt=nnplant1(tt,q,U,W1,W2,W3,b1,b2,b3,beta)



Ir1=0.008;
x=zeros(1,4);
x(1) = q(3) ; x(2)=q(4); x(3) = q(5); x(4) = q(6);
TS=tanh(W3*tanh(W2*tanh(W1*x' + b1) + b2)+b3);
Gx = TS'*beta;
Gx=reshape(Gx,[6,6]);
 
u1=U(1);u2=U(2);
B=[0;0;0;0;0;0];
B(1)=0;
B(2)=0;
B(3)=Ir1*u1;
B(4)=Ir1*u2;
B(5)=0;
B(6)=0;
D2q=Gx\(-B);
dqdt=D2q ;


end