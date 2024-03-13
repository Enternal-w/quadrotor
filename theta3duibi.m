figure('numbertitle','off','name','自适应通道3不同更新率对比'); 
subplot(311)
plot(ScopeData1(:,1),theta3(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),thetaJ35(:,3),'linewidth', 2); 

subplot(312)
plot(ScopeData1(:,1),theta3(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),thetaJ315(:,3),'linewidth', 2); 
subplot(313)
plot(ScopeData1(:,1),theta3(:,2),'linewidth', 2); 
hold on
plot(ScopeData1(:,1),thetaJ325(:,3),'linewidth', 2); 