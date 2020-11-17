plotmlpmd();
% plotaemd();
% plotsvmandcnnmd();

% model=linspace(1,8,8);
% acc=[84.77,0.60,81.71,0.77;
%     82.23,1.06,	84.63,0.63;
%     84.31,0.62,	84.19,0.56;
%     77.54,1.95,	77.51,1.89;
%     76.57,1.00,	76.51,1.04;
%     77.96,0.71,	77.91,0.72;
%     61.31,2.06,	61.27,2.18;
%     73.34,0.7,   72.5,1.95;
%     73.16,1.7,      74,0.9;
%     76.96,0.6,    75.8,1.2;
%     75.94,0.8,	75.3,1.1;];
% 
% 
% models=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
% a=[84.77,0.60;	84.63,0.63;
%     82.23,1.06;	81.71,0.77;
%     84.31,0.62;	84.19,0.56;
%     76.57,1.00;	76.51,1.04;
%     77.54,1.95;	77.51,1.89;
%     77.96,0.71;	77.91,0.72;
%     61.31,2.06;	61.27,2.18;
%     76.96, 0.6;   75.8,1.2;];
% modelsname={'MLP_1Train';'MLP_1Test';'MLP_2Train';'MLP_2Test';'MLP_3Train';'MLP_3Test';...
%     'AE_1Train';'AE_1Test';'AE_2Train';'AE_2Test';'AE_3Train';'AE_3Test';'SVMTrain';...
%     'SVMTest';'CNN_1Train';'CNN_1Test'};
% for i=1:length(a)
%     if mod(i,2)==0
%         figure(1), plot(i,a(i,1),'ko','MarkerSize',10,'MarkerFacecolor',[0.5,0.5,0.5]);hold on;
%     else
%         figure(1), plot(i,a(i,1),' ko','MarkerSize',10,'MarkerFacecolor','black');hold on; 
%     end
% end
% er=errorbar(models,a(:,1),a(:,2),a(:,2));
% er.Color=[1 0 0];
% er.LineWidth=2;
% er.LineStyle='none';
% set(gca,'XTick',(1:16),'XTickLabel',modelsname);
% xtickangle(45);
% ylabel('Accuracy [%]','fontsize',18,'fontweight','normal','fontname','Times New Roman');
% set(gca,'fontsize',15);
% ylim([50 100]);
% legend('Train','Test');
% hold off;




