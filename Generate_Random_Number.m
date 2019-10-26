% Genarate random number with this relation: q1^2  + q2^ 2 + q3^2 + q4^2=1
function q =Generate_Random_Number(NVN,NS)

q1 =2*rand(NS,NVN) - ones(NS,NVN) ;

for i = 1:NS 
    if q1(i,1)^2 >=1 
       q1(i,1)=1 ;
       q1(i,2:4)=0 ;
    end
       
    if q1(i,1)^2 + q1(i,2)^2 >=1
        x=sqrt(1-q1(i,1)^2);
        q1(i,2) = 2*x*rand - x ;
    end
        
    if q1(i,1)^2 + q1(i,2)^2 + q1(i,3)^2 >=1
        y=sqrt(1- q1(i,1)^2 - q1(i,2)^2);
        q1(i,3)=2*y*rand - y ;
    end
        
    if q1(i,1)^2 + q1(i,2)^2 + q1(i,3)^2  + q1(i,4)^2 ~=1
        q1(i,4)=sqrt(1- q1(i,1)^2 - q1(i,2)^2 - q1(i,3)^2);
    end  
end

q2 =2*rand(NS,NVN) - ones(NS,NVN) ;

for i = 1:NS 
    if q2(i,4)^2 >=1 
       q2(i,4)=1 ;
       q2(i,1:3)=0 ;
    end
       
    if q2(i,4)^2 + q2(i,3)^2 >=1
        x=sqrt(1-q2(i,4)^2);
        q2(i,3) = 2*x*rand - x ;
    end
        
    if q2(i,4)^2 + q2(i,3)^2 + q2(i,2)^2 >=1
        y=sqrt(1- q2(i,4)^2 - q2(i,3)^2);
        q2(i,2)=2*y*rand - y ;
    end
        
    if q2(i,4)^2 + q2(i,3)^2 + q2(i,2)^2  + q2(i,1)^2 ~=1
        q2(i,1)=-sqrt(1- q2(i,4)^2 - q2(i,3)^2 - q2(i,2)^2);
    end   
end


for i=1:NS
    j=randi([1,NS]);
    if mod(i,2)==0
        q2(i,:) = q1(j,:);
    end
end
q=q2;

for i=1:0.04*NS/4
    q(randperm(NS,4),:)=eye(4);
end
p=0.005*NS;
q14 = zeros(2,2*p);
q1 = linspace(-sqrt(2)/2,sqrt(2)/2,p);
q4 = real(sqrt(1/2 - q1.^2));
q14(:,1:p)=[q1;q4];
q14(:,p+1:2*p)=[q1;-q4];

q23 = zeros(2,2*p);
q2 = linspace(-sqrt(2)/2,sqrt(2)/2,p);
q3 = real(sqrt(1/2 - q2.^2));
q23(:,1:p)=[q2;q3];
q23(:,p+1:2*p)=[q2;-q3];
qlinspace = [q14;q23]';
for i=1:2*p
    q(randperm(NS,1),:) = qlinspace(i,:);
end

end



