function Value = StageCost1( X,Xd)

Error=X-Xd;
R=norm(Error(1:2),2)^2; %+norm(Error(9:14),2)^2;
Value=R;%/R0;
end

 