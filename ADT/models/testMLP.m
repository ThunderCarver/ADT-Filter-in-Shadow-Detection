for iter=1:7
    datapath=cd;
    datapath=strcat(fileparts(datapath),'/cross validation/',num2str(iter));
    load (strcat(datapath,'/Ttestdata.mat'));
    traindata=Ttestdata';
    mlplabel=TtestLabel';
    a=find(mlplabel==-1);
    mlplabel=cat(1,mlplabel,zeros(1,length(mlplabel)));
    mlplabel(2,a)=1;  %down is non-shadow label
    mlplabel(1,a)=0;  %up is shadow label
    x=traindata;
    t = mlplabel; 
    load (strcat(datapath,'/mlp2010satCV.mat'));
    y=mlp2010satCV(x);
%     figure,plotconfusion(t,y);
%     saveas(gcf,strcat(datapath,'/mlp10satCV-test.png'));
%     close(gcf);
    %% plot ROC 
    [axis_x,axis_y,threhold,auc]=perfcurve(TtestLabel,y(1,:)',1);
    figure,plot(axis_x,axis_y);
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title(['ROC curve of (AUC = ' num2str(auc) ' )']);
    saveas(gcf,strcat(datapath,'/MLP2010ROC.fig'));
%     fprintf('auc=%d...',auc);
end
