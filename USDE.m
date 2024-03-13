function [sys,x0,str,ts] = USDE(t,x,u,flag)
switch flag, 
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 1,
    sys=mdlDerivatives(t,x,u);
  case 3,
    sys=mdlOutputs(t,x,u);
  case {2, 4, 9 }
    sys = [];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1; 
sys = simsizes(sizes);
x0 = [0;0;0;0;0;0];
str = [];
ts  = [0 0];

function sys=mdlDerivatives(t,x,u)
%u(1)=roll;u(2))=F_roll;u(3)=pitch; u(4)=F_pitch;u(5)=yaw;u(6)=F_yaw;
%x(1)=oroll;x(2)=oroll_dot;x(3)=G_4;
%x(4)=opitch;x(5)=opitch_dot;x(6)=G_5
%x(7)=oyaw;x(8)=oyaw_dot;x(9)=G_6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w0=100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sys(1)=w0*(u(1)-x(1));
sys(2)=w0*(u(2)-x(2));
sys(3)=w0*(u(3)-x(3));
sys(4)=w0*(u(4)-x(4));
sys(5)=w0*(u(5)-x(5));
sys(6)=w0*(u(6)-x(6));


function sys=mdlOutputs(t,x,u)
w0=100;
G1=-(x(2)-w0*(u(1)-x(1)));
G2=-(x(4)-w0*(u(3)-x(3)));
G3=-(x(6)-w0*(u(5)-x(5)));
sys =[G1,G2,G3];