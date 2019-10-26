function Value = StageCost2( X,Xd )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Error=X-Xd;
Value=norm(Error(3:6),2)^2;%+norm(Error(9:14),2)^2;%(Error(3)^2+Error(4)^2+Error(5)^2+Error(6)^2);%/4;
end
