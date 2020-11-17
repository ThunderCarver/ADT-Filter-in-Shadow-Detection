for iter=1:7
    datapath=cd;
    datapath=strcat(fileparts(datapath),'/cross validation/');
    datapath=strcat(datapath,num2str(iter),'/');
    load (strcat(datapath,'Ttraindata.mat'));
    
        
    SVMCV=fitcsvm(Ttraindata,TtrainLabel,'KernelFunction','rbf',...
    'KernelScale','auto','OutlierFraction',0.1,'IterationLimit',1000);
    [preLabel,~,probEstimate] = predict(SVMCV, Ttraindata);    

    %% change data format
    label=TtrainLabel';
    a=find(label==-1);
    label=cat(1,label,zeros(1,length(label)));
    label(2,a)=1;  %down is non-shadow label
    label(1,a)=0;  %up is shadow label
    t=label;
    y=probEstimate';
    
%     figure, plotconfusion(t,y);
%     saveas(gcf,strcat(datapath,'SVMCV-train.png'));
%     close(gcf);

    save (strcat(datapath,'SVMCV.mat'),'SVMCV');
end
