figure('numbertitle','off','name','��̬�������'); 
% subplot(212)
plot(ScopeData1(:,1),e1(:,2)/57.3,'linewidth', 2); %��
hold on
plot(ScopeData1(:,1),e2(:,2)/57.3,'--','linewidth', 2); %��
hold on
plot(ScopeData1(:,1),e3(:,2)/57.3,'-.','linewidth', 2); %��
%%
figure('numbertitle','off','name','USDE��һͨ��'); 
subplot(212)
plot(ScopeData1(:,1),G1(:,2),'linewidth', 2); %command  ��ֵ
hold on
plot(ScopeData1(:,1),G1(:,3),'--','linewidth', 2);    %command  ��ɫ����ֵ

figure('numbertitle','off','name','USDE�ڶ�ͨ��'); 
subplot(212)
plot(ScopeData1(:,1),G2(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),G2(:,3),'--','linewidth', 2); 

figure('numbertitle','off','name','USDE����ͨ��'); 
% subplot(312)
plot(ScopeData1(:,1),G3(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),G3(:,3),'--','linewidth', 2); 
%%
figure('numbertitle','off','name','�������Ƶ�һͨ��'); 
plot(ScopeData1(:,1),theta1(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),thetaJ1(:,3),'linewidth', 2); 

figure('numbertitle','off','name','�������Ƶڶ�ͨ��'); 
plot(ScopeData1(:,1),theta2(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),thetaJ2(:,3),'linewidth', 2); 

figure('numbertitle','off','name','�������Ƶ���ͨ��'); 
plot(ScopeData1(:,1),theta3(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),thetaJ3(:,3),'linewidth', 2); 

%%
figure('numbertitle','off','name','��̬����'); 
subplot(311)
plot(ScopeData1(:,1),ScopeData1(:,3), 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),ScopeData1(:,2),'--', 'linewidth', 2); 
% title('��̬����');
subplot(312)
plot(ScopeData1(:,1),ScopeData2(:,3), 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),ScopeData2(:,2), '--','linewidth', 2); 
subplot(313)
plot(ScopeData1(:,1),ScopeData3(:,3), 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),ScopeData3(:,2),'--', 'linewidth', 2); 

%%
% std(e1(75000:80000,2))
% std(e2(75000:80000,2))
% std(e3(75000:80000,2))

std(e1(1:80000,2))
std(e2(1:80000,2))
std(e3(1:80000,2))

%%
% �������
data_row1=[0.0038,   8.1444e-04,   0.0022];%����ӦUSDE 
data_row2=[0.0091,   0.0424,          0.0214];%����Ӧ  
data_row3=[0.0071,    0.0060,         0.0075];%USDE   
data=[data_row1;data_row2;data_row3];
%���ɱ���������ƣ�m��n��
str1='��ʽ';str2='ͨ��';
m=3;n=3;
column_name=strcat(str1,num2str((1:n)'));
row_name=strcat(str2,num2str((1:m)'));
%�����ͼ
set(figure(1),'position',[200 200 450 330]);
uitable(gcf,'Data',data,'Position',[20 20 400 290],'Columnname',column_name,'Rowname',row_name);

%%

% gama1 =5;
% gama2 =5;
% gama3 =5;
% 0.1079 0.1492  0.0050         1.2441  1.2948    0.0486

% gama1 =10;
% gama2 =10;
% gama3 =10;
%0.0181  0.0194  0.0023        1.2203    1.2665    0.0351

% gama1 =15;
% gama2 =15;
% gama3 =15;
% 0.0038  8.1444e-04  0.0022      1.2099      1.2559     0.0294

% gama1 =20;
% gama2 =20;
% gama3 =20;
%  0.0026 0.0020 0.0023      1.2031      1.2502      0.0261

% gama1 =25;
% gama2 =25;
% gama3 =25;
% 0.0026  0.0020  0.0023    1.1979    1.2465    0.0239

% gama1 =30;
% gama2 =30;
% gama3 =30;
% 0.0027  0.0024  0.0023    1.1935    1.2438    0.0223