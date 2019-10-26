function MPC=ModelPredictiveControl(n,m,Nu,tf,Dt,X0,Xd,Umax,W1,W2,W3,b1,b2,b3,beta)

X(:,1)=X0;
t(1)=0;
kf=fix(tf/Dt);
Up=zeros(1,Nu*m);
U(:,1)=zeros(m,1);
RealTime=[0];
RealX=X0';
RealDX=zeros(1,n);
RealU=U';
Uub=Umax*ones(1,Nu*m);Ulb=-Umax*ones(1,Nu*m);
OptTime(1)=0;

%**********************************************************************
for k=2:kf
    InitialUp=Up;
    t(k)=(k-1)*Dt;
    Options = optimoptions(@fmincon,'Algorithm','sqp','Display','off','Useparallel',1);

    t1=cputime;
    [Up,Fval]=fmincon(@ObjectiveFuction,InitialUp,[],[],[],[],Ulb,Uub,[],Options);
    t2=cputime;
    OptTime(k)=t2-t1;
    U(:,k)=Up(1,1:m)';
    Cost(k)=Fval;
    Up=[Up(m+1:Nu*m) Up(Nu*m-m+1:Nu*m)];
    [Time,Z]=ode113(@(tt,q) PlantCAM(tt,q,U(:,k)),[t(k-1) t(k)],X(:,k-1));

    L=length(Time);
    X(:,k)=Z(L,:);
    
        clear RDX uu
    for h = 1:length(Time)
        RDX(h,:)=PlantCAM(Time(h),Z(h,:),U(:,k));
       
        uu(h,:)=U(:,k)';
    end
    RealTime=[RealTime;Time];
    RealX=[RealX;Z];
    RealDX=[RealDX;RDX];
    RealU=[RealU;uu];
    disp([num2str(fix(k*100/kf)) '%']);
end
MPC{1}=[t(1:kf);X(:,1:kf);Cost;U;OptTime];
MPC{2}=RealTime;
MPC{3}=RealX;
MPC{4}=RealDX;
MPC{5}=RealU;
% *****************************************************************
function J=ObjectiveFuction(Input)
       
        for s=1:Nu
            ControlInput(:,s)=Input(1,(s-1)*m+1:s*m)';
        end
        
        PreviousX=X(:,k-1);
        
        for s=1:Nu

            %[Time1,Z1]=ode113(@(tt,q) PlantCAM(tt,q,ControlInput(:,s)),[0 Dt],PreviousX);
            
            [Time1,Z1]=ode113(@(tt,q) nnplant1(tt,q,ControlInput(:,s),W1,W2,W3,b1,b2,b3,beta),[0 Dt],PreviousX);
            

            L1=length(Time1);
            Xp(:,s)=Z1(L1,:);
            PreviousX=Xp(:,s);       

           
            
        end
        
        
        Sum2=0;
        Sum=StageCost1(X(:,k-1),Xd)+StageCost2(X(:,k-1),Xd);
        for s=1:Nu-1
            Sum=Sum+StageCost1(Xp(:,s),Xd)+StageCost2(Xp(:,s),Xd);%+APF(Xp(:,s),Xd,X0,No,Po,Ro,.3,D_safe,APF_max,s);
            Sum2=Sum2+norm(ControlInput(:,s),2)^2;
        end 
        Sum2=Sum2+norm(ControlInput(:,Nu),2)^2;
        J=Sum+1e8*StageCost1(Xp(:,Nu),Xd)+1e8*StageCost2(Xp(:,Nu),Xd)+.5*Sum2 ;

        
    end
end 
    
