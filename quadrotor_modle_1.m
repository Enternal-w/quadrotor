function [sys,x0,str,ts] = quadrotor_modle_1(t,x,u,flag)
switch flag,
    case 0,
       [sys,x0,str,ts]=mdlInitializeSizes; 
    case 1,
        sys=mdlDerivatives(t,x,u);
    case 3,
        sys=mdlOutputs(t,x,u);
    case {2,4,9}
        str=[];
    otherwise
         error(['Unhandled flag = ',num2str(flag)]);

end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 21;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 48;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1; 
sys = simsizes(sizes);
x0  = [-3,0,-2,0,7,0,0.5,0,0.5,0,0.005,0, 2,0.01,0, 3,0.1,0, 0.785,-5,-5];
%x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10),
%x(11),x(12),F_x,f_x,d1,F_y,f_y,d2,F_z,f_z,
%d3,F_roll,f_roll,d4,F_pitch,f_pitch,d5,F_yaw,f_yaw,d6,
%f_x+d1,f_y+d2,f_z+d3,f_roll+d4,f_pitch+d5,f_yaw+d6,x(13),x(14),x(15),
%x(16),x(17),x(18),x(19),sys(19),x(20),x(21),sys(20),sys(21)
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
%%%%%% x(1)=x; x(2)=x_dot; x(3)=y; x(4)=y_dot; x(5)=z; x(6)=z_dot;
%%%%%% x(7)=roll; x(8)=roll_dot;x(9)=pitch; x(10)=pitch_dot; x(11)=yaw;
%%%%%% x(12)=yaw_dot; x(13)=xt;x(14)=dxt;x(15)=ddxt;    x(16)=yt;x(17)=dyt;x(18)=ddyt;
%%%%%% x(19)=sita x(20)=rx x(20)=ry 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=2;c=0.05;l=0.4;g=9.8;
kx=0.01;ky=0.01;kz=0.01;
a1=0.2;
d_kx=a1*kx;d_ky=a1*ky;d_kz=a1*kz;
%%
Ix1=0.16;Iy1=0.16;Iz1=0.32;
Ix2=0.5;Iy2=0.8;Iz2=0.6;
if t<40
    Ix=Ix1;Iy=Iy1;Iz=Iz1;
end
if t>=40
    Ix=Ix2;Iy=Iy2;Iz=Iz2;
end
%%
a2=0;
d_x=a2*(sin(t)+sin(0.5*t)-cos(0.8*t));%加入的干扰    % dw
d_y=a2*(cos(t)+sin(0.5*t)-cos(0.8*t));
d_z=a2*sin(1.5*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F_x=(u(1)/m)*(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)));  %Ux
f_x=-kx*x(2)/m; %kx表示阻尼系数
d1=(d_x-d_kx*x(2))/m;%d1表示外部的干扰和参数不确定度

F_y=(u(1)/m)*(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)));   %Uy
f_y=-ky*x(4)/m; 
d2=(d_y-d_ky*x(4))/m;

F_z=(u(1)/m)*cos(x(9))*cos(x(7))-g;                                 %Uz
f_z=-kz*x(6)/m;
d3=(d_z-d_kz*x(6))/m;
%重力只有在z轴上存在;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k_roll=0;k_pitch=0;k_yaw=0;
% k_roll=0.012;k_pitch=0.012;k_yaw=0.012;     %其实就是 PIw
a3=0.2;
d_k_roll=a3*k_roll;d_k_pitch=a3*k_pitch;d_k_yaw=a3*k_yaw;
a4=0;
d_l=a4*l;d_c=a4*c;
% a5=0.2;
a5=0.2;
d_roll=a5*(sin(t)+sin(0.5*t));                 
d_pitch=a5*(cos(0.5*t)-cos(0.8*t));
d_yaw=a5*(sin(t)*sin(0.5*t));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F_roll=l*u(2)/Ix;
f_roll=(x(10)*x(12)*(Iy-Iz)-k_roll*x(8))/Ix;
d4=(-d_k_roll*x(8)+d_roll+d_l*u(2))/Ix;
%d_roll表示系统加入的干扰
%k_roll表示阻尼系数,d_k_roll表示参数不确定度

F_pitch=l*u(3)/Iy;
f_pitch=(x(8)*x(12)*(Iz-Ix)-k_pitch*x(10))/Iy;
d5=(-d_k_pitch*x(10)+d_pitch+d_l*u(3))/Iy;

F_yaw=c*u(4)/Iz;
f_yaw=(x(8)*x(10)*(Ix-Iy)-k_yaw*x(12))/Iz;
d6=(-d_k_yaw*x(12)+d_yaw+d_c*u(4))/Iz;

sys(1)=x(2);
sys(2)=F_x+f_x+d1;
sys(3)=x(4);
sys(4)=F_y+f_y+d2;
sys(5)=x(6);
sys(6)=F_z+f_z+d3;
sys(7)=x(8);
sys(8)=F_roll+f_roll+d4;
sys(9)=x(10);
sys(10)=F_pitch+f_pitch+d5;
sys(11)=x(12);
sys(12)=F_yaw+f_yaw+d6;

sys(13)=x(14);
sys(14)=-0.001*sin(0.1*t);

sys(15)=x(18);

sys(16)=x(17);
sys(17)=0;

sys(18)=0;
% dy_1=sys(3);dyt=sys(16);dx_1=sys(1);dxt=sys(13)
% dw_1=(((dy_1-dyt)*(x_1-xt)-(dx_1-dxt)*(y_1-yt))/(x_1-xt)^2)/(1+((y_1-yt)/(x_1-xt))^2);
sys(19)=( ( (sys(3)-sys(16))*(x(1)-x(13)) - (sys(1)-sys(13))*(x(3)-x(16)) )/ (x(1)-x(13))^2 )/(1+( (x(3)-x(16))/(x(1)-x(13)) )^2);

sys(20)=x(2)-x(14);
sys(21)=x(4)-x(17);



function sys=mdlOutputs(t,x,u)
%%%%%% x(1)=x; x(2)=x_dot; x(3)=y; x(4)=y_dot; x(5)=z; x(6)=z_dot;
%%%%%% x(7)=roll; x(8)=roll_dot;x(9)=pitch; x(10)=pitch_dot; x(11)=yaw;
%%%%%% x(12)=yaw_dot;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=2;c=0.05;l=0.4;g=9.8;
kx=0.01;ky=0.01;kz=0.01;
a6=0.2;
d_kx=a6*kx;d_ky=a6*ky;d_kz=a6*kz;
%%
Ix1=0.16;Iy1=0.16;Iz1=0.32;
Ix2=0.5;Iy2=0.8;Iz2=0.6;
if t<40
    Ix=Ix1;Iy=Iy1;Iz=Iz1;
end
if t>=40
    Ix=Ix2;Iy=Iy2;Iz=Iz2;
end
%%
a7=0;
d_x=a7*(sin(t)+sin(0.5*t)-cos(0.8*t));%加入的干扰
d_y=a7*(cos(t)+sin(0.5*t)-cos(0.8*t));
d_z=a7*sin(1.5*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F_x=(u(1)/m)*(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)));
f_x=-kx*x(2)/m; %kx表示阻尼系数
d1=(d_x-d_kx*x(2))/m;%d1表示外部的干扰和参数不确定度

F_y=(u(1)/m)*(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)));
f_y=-ky*x(4)/m; 
d2=(d_y-d_ky*x(4))/m;

F_z=(u(1)/m)*cos(x(9))*cos(x(7))-g;
f_z=-kz*x(6)/m;
d3=(d_z-d_kz*x(6))/m;
%重力只有在z轴上存在;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k_roll=0;k_pitch=0;k_yaw=0;
% k_roll=0.012;k_pitch=0.012;k_yaw=0.012;
a8=0.2;
d_k_roll=a8*k_roll;d_k_pitch=a8*k_pitch;d_k_yaw=a8*k_yaw;
a9=0;
d_l=a9*l;d_c=a9*c;
% a9=0.2;
a9=0.2;
d_roll=a9*(sin(t)+sin(0.5*t));
d_pitch=a9*(cos(0.5*t)-cos(0.8*t));
d_yaw=a9*(sin(t)*sin(0.5*t));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F_roll=l*u(2)/Ix;
f_roll=(x(10)*x(12)*(Iy-Iz)-k_roll*x(8))/Ix;
d4=(-d_k_roll*x(8)+d_roll+d_l*u(2))/Ix;
%d_roll表示系统加入的干扰
%k_roll表示阻尼系数,d_k_roll表示参数不确定度

F_pitch=l*u(3)/Iy;
f_pitch=(x(8)*x(12)*(Iz-Ix)-k_pitch*x(10))/Iy;
d5=(-d_k_pitch*x(10)+d_pitch+d_l*u(3))/Iy;

F_yaw=c*u(4)/Iz;
f_yaw=(x(8)*x(10)*(Ix-Iy)-k_yaw*x(12))/Iz;
d6=(-d_k_yaw*x(12)+d_yaw+d_c*u(4))/Iz;

sys(1)=x(2);
sys(2)=F_x+f_x+d1;
sys(3)=x(4);
sys(4)=F_y+f_y+d2;
sys(5)=x(6);
sys(6)=F_z+f_z+d3;
sys(7)=x(8);
sys(8)=F_roll+f_roll+d4;
sys(9)=x(10);
sys(10)=F_pitch+f_pitch+d5;
sys(11)=x(12);
sys(12)=F_yaw+f_yaw+d6;

sys(13)=x(14);
sys(14)=-0.001*sin(0.1*t);

sys(15)=x(18);

sys(16)=x(17);
sys(17)=0;

sys(18)=0;

sys(19)=( ( (sys(3)-sys(16))*(x(1)-x(13)) - (sys(1)-sys(13))*(x(3)-x(16)) )/ (x(1)-x(13))^2 )/(1+( (x(3)-x(16))/(x(1)-x(13)) )^2);

J1=1/Ix;
J2=1/Iy;
J3=1/Iz;

sys = [x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10),x(11),x(12),F_x,f_x,d1,F_y,f_y,d2,F_z,f_z,d3,F_roll,f_roll,d4,F_pitch,f_pitch,d5,F_yaw,f_yaw,d6,f_x+d1,f_y+d2,f_z+d3,f_roll+d4,f_pitch+d5,f_yaw+d6,x(13),x(14),x(15),x(16),x(17),x(18),x(19),sys(19),x(20),J1,J2,J3];


















