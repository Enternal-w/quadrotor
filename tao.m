function [sys,x0,str,ts] = tao(t,x,u,flag)
switch flag 
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 1
    sys=mdlDerivatives(t,x,u);
  case 3
    sys=mdlOutputs(t,x,u);
  case {2, 4, 9 }
    sys = [];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1; 
sys = simsizes(sizes);

x0 = [6;5.5;3];
str = [];
ts  = [0 0];

function sys=mdlDerivatives(t,x,u)
%%
gama1 =25;
gama2 =25;
gama3 =25;

% gama1 =25;   % RMSE
% gama2 =30;
% gama3 =25;

% gama1 =5;     %单独自适应使用
% gama2 =5;
% gama3 =1;
%%
sys(1)=gama1*u(1)*u(4);   %gama*u*ew
sys(2)=gama2*u(2)*u(5);
sys(3)=gama3*u(3)*u(6);
dian1=gama1*u(1)*u(4);   %gama*u*ew
dian2=gama2*u(2)*u(5);
dian3=gama3*u(3)*u(6);

theta1min=2;theta1max=6.4;
theta2min=1.25;theta2max=6;
theta3min=1.6;theta3max=3.2;

if x(1)==theta1max&&dian1>0
    sys(1)=0;
elseif x(1)==theta1min&&dian1<0
    sys(1)=0;
else
    sys(1)=dian1;
end

if x(2)==theta2max&&dian2>0
    sys(2)=0;
elseif x(2)==theta2min&&dian2<0
    sys(2)=0;
else
    sys(2)=dian2;
end

if x(3)==theta3max&&dian3>0
    sys(3)=0;
elseif x(3)==theta3min&&dian3<0
    sys(3)=0;
else
    sys(3)=dian3;
end

function sys=mdlOutputs(t,x,u)
%%
theta1 = x(1);
theta2 = x(2);
theta3 = x(3);
tao1 = theta1*u(1);
tao2 = theta2*u(2);
tao3 = theta3*u(3);

sys =[tao1;tao2;tao3;theta1;theta2;theta3];