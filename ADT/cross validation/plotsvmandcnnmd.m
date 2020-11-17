
function []=plotsvmandcnnmd()
    a =[61.31,2.06;
        61.27,2.18];
    subplot(1,2,1);
    figure(1),plot(1,61,'ko','color','white');hold on;
    figure(1),plot(2,a(1,1),' ko','MarkerSize',10,'MarkerFacecolor','black');
    figure(1),plot(3,a(2,1),'ko','MarkerSize',10,'MarkerFacecolor',[0.5,0.5,0.5]);
    figure(1),plot(4,61,'ko','color','white');
    er=errorbar([2,3],a(:,1),a(:,2),a(:,2));
    er.Color=[1 0 0];
    er.LineWidth=2;
    er.LineStyle='none';
    set(gca,'xtick',[1:1:4],'XTickLabel',{'','Train','Test'});
    ylabel('Accuracy [%]','fontsize',18,'fontweight','normal','fontname','Times New Roman');
    set(gca,'fontsize',15);
    ylim([58 86]);
    title(gca,'SVM','FontWeight','normal');
    hold off;


    a=[76.96,0.6;75.81,1.2];
    subplot(1,2,2);
    figure(1),plot(1,76,'ko','color','white');hold on;
    figure(1),plot(2,a(1,1),' ko','MarkerSize',10,'MarkerFacecolor','black');
    figure(1),plot(3,a(2,1),'ko','MarkerSize',10,'MarkerFacecolor',[0.5,0.5,0.5]);
    figure(1),plot(4,76,'ko','color','white');
    er=errorbar([2,3],a(:,1),a(:,2),a(:,2));
    er.Color=[1 0 0];
    er.LineWidth=2;
    er.LineStyle='none';
    set(gca,'xtick',[1:1:4],'XTickLabel',{'','Train','Test'});
    ylabel('Accuracy [%]','fontsize',18,'fontweight','normal','fontname','Times New Roman');
    set(gca,'fontsize',15);
    ylim([58 86]);
    title(gca,'1D-CNN','FontWeight','normal');
    hold off;
end