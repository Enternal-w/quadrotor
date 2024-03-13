function y=attitude_control_1(GW_roll,GW_pitch,GW_yaw,w_roll_dot,w_pitch_dot,roll,pitch,yaw,roll_dot,pitch_dot,yaw_dot,t,w_yaw_dot,theta1,theta2,theta3)
%ew表示角速率的跟踪误差；GW表示MLP得到的估计值；w_dot表示通过虚拟控制率得到的角速率的导数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l=0.4;c=0.05;
% Ix=0.16;Iy=0.16;Iz=0.32;
ka=5; kw=10;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
roll_d=1*sin(0.3*t);roll_ddot=0.3*cos(0.3*t);
pitch_d=1*cos(0.3*t);pitch_ddot=-0.3*sin(0.3*t);
yaw_d=0;yaw_ddot=0;

Ix=1/(theta1+1);Iy=1/(theta2+1);Iz=1/(theta3+1);
% Ix=0.4;Iy=0.5;Iz=0.5;            %单独USDE使用
% Ix=0.51;Iy=0.81;Iz=0.63;                        %  RMSE= 0.0071   0.0060  0.0075  单独USDE时使用
% Ix=0.6;Iy=0.5;Iz=0.7;                              %  RMSE= 0.0545,    0.1696, 0.0234

ea1=roll-roll_d;
ea2=pitch-pitch_d;
ea3=yaw-yaw_d;

w_roll=-ka*ea1+roll_ddot;
w_pitch=-ka*ea2+pitch_ddot;
w_yaw=-ka*ea3+yaw_ddot;

ew1=roll_dot-w_roll;
ew2=pitch_dot-w_pitch;
ew3=yaw_dot-w_yaw;

u2=((Ix)/l)*(-kw*ew1-GW_roll+w_roll_dot-ea1);
u3=((Iy)/l)*(-kw*ew2-GW_pitch+w_pitch_dot-ea2);
u4=((Iz)/c)*(-kw*ew3-GW_yaw+w_yaw_dot-ea3);

y=[u2;u3;u4;ew1;ew2;ew3;w_roll;w_pitch;w_yaw;roll_d;pitch_d;yaw_d];
end

