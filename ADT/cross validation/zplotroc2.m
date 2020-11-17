
h1=open('MLP20ROC.fig');
D=get(gca,'Children'); %get the handle of the line object
XData1=get(D,'XData'); %get the x data
YData1=get(D,'YData'); %get the y data
close(h1);

h2=open('HuangROC.fig');
D=get(gca,'Children'); %get the handle of the line object
XData2=get(D,'XData'); %get the x data
YData2=get(D,'YData'); %get the y data
close(h2);

h3=open('LalondeROC.fig');
D=get(gca,'Children'); %get the handle of the line object
XData3=get(D,'XData'); %get the x data
YData3=get(D,'YData'); %get the y data
close(h3);

figure(4),title('ROC : results of MLP1 VS Huang VS Lalonde',...
    'fontname','Times New Roman','fontweight','normal','fontsize',18);hold on;
xlabel('False Positive Rate','fontsize',18,...
    'fontweight','normal','fontname','Times New Roman');
ylabel('True Positive Rate','fontsize',18,...
    'fontweight','normal','fontname','Times New Roman');
plot(XData1,YData1,'LineWidth',2);
plot(XData2,YData2,'LineWidth',2);
plot(XData3,YData3,'LineWidth',2);
set(gca,'fontsize',15);
legend('MLP1 AUC=0.92±0.005','Huang AUC=0.62±0.056','Lalonde AUC=0.53±0.001',...
    'fontsize',18,'fontname','Times New Roman','fontweight','normal');
hold off;