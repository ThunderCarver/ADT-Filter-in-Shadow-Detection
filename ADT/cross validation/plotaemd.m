
function []=plotaemd()
    a =[76.57,1.0;
        76.51,1.04];
    subplot(1,3,1);
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
    title(gca,'AE_1','FontWeight','normal');
    hold off;

    a=[77.54,1.95;77.51,1.89];
    subplot(1,3,2);
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
    title(gca,'AE_2','FontWeight','normal');
    hold off;

    a=[77.96,0.71;77.91,0.72];
    subplot(1,3,3);
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
    title(gca,'AE_3','FontWeight','normal');
    hold off;
end
