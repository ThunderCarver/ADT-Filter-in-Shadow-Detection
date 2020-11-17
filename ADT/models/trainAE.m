for iter=1:7
    datapath=cd;
    datapath=strcat(fileparts(datapath),'/cross validation/');
    datapath=strcat(datapath,num2str(iter),'/');
    load (strcat(datapath,'Ttraindata.mat'));
    %% change data format
    traindata=Ttraindata';
    AElabel=TtrainLabel';
    a=find(AElabel==-1);
    AElabel=cat(1,AElabel,zeros(1,length(AElabel)));
    AElabel(2,a)=1;  %down is non-shadow label
    AElabel(1,a)=0;  %up is shadow label
    x=traindata;
    t = AElabel; 
    %% configure network
    hiddensize=20;
    auto1=trainAutoencoder(x,hiddensize,'EncoderTransferFunction','satlin',...
        'DecoderTransferFunction','satlin','MaxEpochs',500,...
        'L2WeightRegularization',0.001,'ScaleData',false,'TrainingAlgorithm','trainscg',...
        'SparsityProportion',0.2);
    feat1=encode(auto1,x);
    hiddensize2=10;
    auto2=trainAutoencoder(feat1,hiddensize2,'EncoderTransferFunction','satlin',...
        'DecoderTransferFunction','satlin','MaxEpochs',500,...
        'L2WeightRegularization',0.001,'ScaleData',false,'TrainingAlgorithm','trainscg',...
        'SparsityProportion',0.2);
    feat2=encode(auto2,feat1);
    softnet=trainSoftmaxLayer(feat2,t,'MaxEpochs',200,'TrainingAlgorithm','trainscg');
    stackednet=stack(auto1,auto2,softnet);
    %% train network
    [AE2010satCV,tr]=train(stackednet,x,t);
    %% Test the network
    y=AE2010satCV(x);
    % e=gsubtract(t,y);
    % performance=perform(mlp10satCV,t,y);
    % tind=vec2ind(t);
    % yind=vec2ind(y);
    % percentErrors=sum(tind~=yind)/numel(tind);
    %% Plots
    % Uncomment these lines to enable various plots.
    % figure, plotperform(tr)
    % figure, plottrainstate(tr)
    % figure, ploterrhist(e)
    figure, plotconfusion(t,y);
    saveas(gcf,strcat(datapath,'AE2010satCV-train.png'));
    close(gcf);
    % figure, plotroc(t,y)

    save (strcat(datapath,'AE2010satCV.mat'),'AE2010satCV');
end
