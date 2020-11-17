

h1=open('MLP10ROC.fig');
D=get(gca,'Children'); %get the handle of the line object
XData1=get(D,'XData'); %get the x data
YData1=get(D,'YData'); %get the y data
close(h1);

h2 = open('MLP20ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData2=get(D,'XData'); %get the x data
YData2=get(D,'YData'); %get the y data
close(h2);

h3 = open('MLP2010ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData3=get(D,'XData'); %get the x data
YData3=get(D,'YData'); %get the y data
close(h3);

h4 = open('AE10ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData4=get(D,'XData'); %get the x data
YData4=get(D,'YData'); %get the y data
close(h4);

h5 = open('AE20ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData5=get(D,'XData'); %get the x data
YData5=get(D,'YData'); %get the y data
close(h5);

h6 = open('AE2010ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData6=get(D,'XData'); %get the x data
YData6=get(D,'YData'); %get the y data
close(h6);

h7 = open('SVMROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData7=get(D,'XData'); %get the x data
YData7=get(D,'YData'); %get the y data
close(h7);

h8 = open('cnn30ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData8=get(D,'XData'); %get the x data
YData8=get(D,'YData'); %get the y data
close(h8);

h9 = open('cnn50ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData9=get(D,'XData'); %get the x data
YData9=get(D,'YData'); %get the y data
close(h9);

h10 = open('cnn5010ROC.fig'); % open figure
D=get(gca,'Children'); %get the handle of the line object
XData10=get(D,'XData'); %get the x data
YData10=get(D,'YData'); %get the y data
close(h10);

figure(11),title('ROC : results of diverse models',...
    'fontname','Times New Roman','fontweight','normal','fontsize',18);hold on;
xlabel('False Positive Rate','fontsize',18,...
    'fontweight','normal','fontname','Times New Roman');
ylabel('True Positive Rate','fontsize',18,...
    'fontweight','normal','fontname','Times New Roman');
plot(XData2,YData2,'LineWidth',2);
plot(XData1,YData1,'LineWidth',2);

plot(XData3,YData3,'LineWidth',2);
plot(XData5,YData5,'LineWidth',2);
plot(XData4,YData4,'LineWidth',2);

plot(XData6,YData6,'LineWidth',2);
plot(XData7,YData7,'LineWidth',2);

plot(XData8,YData8,'LineWidth',2);
plot(XData9,YData9,'LineWidth',2);
plot(XData10,YData10,'LineWidth',2);
set(gca,'fontsize',15);
legend('MLP1 AUC=0.92±0.005','MLP2 AUC=0.89±0.008','MLP3 AUC=0.91±0.005',...
    'AE1 AUC=0.84±0.012','AE2 AUC=0.85±0.021','AE3 AUC=0.85±0.008','SVM AUC=0.61±0.022',...
    'cnn30 AUC=0.72±0.019','cnn50 AUC=0.74±0.009','cnn5010 AUC=0.76±0.012',...
    'fontsize',18,'fontname','Times New Roman','fontweight','normal');
hold off;