for iter=1:7
    datapath=cd;
    datapath=strcat(fileparts(datapath),'/cross validation/',num2str(iter));
    load (strcat(datapath,'/Ttestdata.mat'));
    
    load (strcat(datapath,'/SVMCV.mat'));
    [preLabel,~,probEstimate] = predict(SVMCV, Ttestdata); 
    label=TtestLabel';
    a=find(label==-1);
    label=cat(1,label,zeros(1,length(label)));
    label(2,a)=1;  %down is non-shadow label
    label(1,a)=0;  %up is shadow label
    t=label;
    y=probEstimate';
    
%     figure,plotconfusion(t,y);
%     saveas(gcf,strcat(datapath,'/SVMCV-test.png'));
%     close(gcf);
    %% plot ROC 
    [axis_x,axis_y,threhold,auc]=perfcurve(TtestLabel,y(1,:)',1);
    figure,plot(axis_x,axis_y);
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title(['ROC curve of (AUC = ' num2str(auc) ' )']);
    saveas(gcf,strcat(datapath,'/SVMROC.fig'));
%     fprintf('auc=%d...',auc);
end
