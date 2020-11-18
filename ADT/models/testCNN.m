%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read the groundtruth file
% read pre.mat from corresponding path
% assess the metrics such as precision,recall and f1-measure
% draw ROC curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for iter=1:7
    %% read groundtruth and predictedlabels 
    datapath=cd;
    groundtruthpath=strcat(fileparts(datapath),'/cross validation/',num2str(iter));
    load (strcat(groundtruthpath,'/Ttestdata.mat'));
    labelpath=fileparts(fileparts(datapath));
    labelpath=strcat(labelpath,'/Documents/ADT-Filter-in-Shadow-Detection/ADT/CNN/5010/');
    labelpath=strcat(labelpath,'pre',num2str(iter));
    load (strcat(labelpath,'.mat'));
    predictedclass=double(predictedclass);
    %% evaluate the results
    groundtruthlabel=TtestLabel;
    a=find(groundtruthlabel==-1);
    groundtruthlabel(a)=0;
    p=length(find(groundtruthlabel==1));
    TP=length(find((groundtruthlabel(1:p)==predictedclass(1,1:p)')==1));
    FP=length(find((groundtruthlabel(p+1:end)~=predictedclass(1,p+1:end)')==1));
    FN=p-TP;
    TN=p-FP;
    accuracte=(TP+TN)/length(groundtruthlabel);
    precision=TP/(TP+FP);
    recall=TP/(TP+FN);
    fscore=2*precision*recall/(precision+recall);
    %% plot ROC 
    [axis_x,axis_y,threhold,auc]=perfcurve(TtestLabel,predictedclass(1,:)',1);
%     figure,plot(axis_x,axis_y);
%     xlabel('False Positive Rate');
%     ylabel('True Positive Rate');
%     title(['ROC curve of (AUC = ' num2str(auc) ' )']);
%     saveas(gcf,strcat(datapath,'/cross validation/',num2str(iter),'/cnn5010ROC.fig'));
%     fprintf('auc=%.4d\n',auc);
    fprintf('%f\t %f\t %f\t %f\t %f\n',precision,recall,fscore,accuracte,auc);
end
