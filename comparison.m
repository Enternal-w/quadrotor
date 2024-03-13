figure('numbertitle','off','name','×ËÌ¬¸ú×Ù'); 
subplot(311)
plot(ScopeData1(:,1),ScopeData1(:,3), 'k','linewidth', 2); 
hold on
plot(ScopeData1(:,1),ScopeData1(:,2),'r--','linewidth', 2); 
hold on
plot(ScopeData1(:,1),ESO1(:,2),'g-.', 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),RBF1(:,2),'b.', 'linewidth', 2); 
% title('×ËÌ¬¸ú×Ù');
subplot(312)
plot(ScopeData1(:,1),ScopeData2(:,3), 'k','linewidth', 2); 
hold on
plot(ScopeData1(:,1),ScopeData2(:,2), 'r--','linewidth', 2); 
hold on
plot(ScopeData1(:,1),ESO2(:,2),'g-.', 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),RBF2(:,2),'b.', 'linewidth', 2); 
subplot(313)
plot(ScopeData1(:,1),ScopeData3(:,3), 'k','linewidth', 2); 
hold on
plot(ScopeData1(:,1),ScopeData3(:,2),'r--', 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),ESO3(:,2),'g-.', 'linewidth', 2); 
hold on
plot(ScopeData1(:,1),RBF3(:,2),'b.', 'linewidth', 2); 