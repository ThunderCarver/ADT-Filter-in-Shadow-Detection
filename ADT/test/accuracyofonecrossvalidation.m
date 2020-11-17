% read traindata
datapath=cd;
datapath=strcat(fileparts(datapath),'/cross validation/1');
load (strcat(datapath,'/Ttraindata.mat'));
%read testdata
datapath=cd;
datapath=strcat(fileparts(datapath),'/cross validation/1/');
load (strcat(datapath,'/Ttestdata.mat'));
accuracyvector=[];
for i=1:95
    %% permute data
    ordertrain=randperm(length(Ttraindata));
    ordertest=randperm(length(Ttestdata));
    % permute traindata
    TtrainLabel=TtrainLabel(ordertrain,:);
    % permute testdata
    TtestLabel=TtestLabel(ordertest,:);
    %% train mlp20 network
    % set traindata
    x=Ttraindata';
    t=TtrainLabel';
    a=find(t==-1);
    t=cat(1,t,zeros(1,length(t)));
    t(2,a)=1;  %down is non-shadow label
    t(1,a)=0;  %up is shadow label 
    
    % set network and train network 
    trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
    hiddenLayerSize = 20;
    mlp20satCV = patternnet(hiddenLayerSize);
    mlp20satCV.layers{1}.transferFcn='satlin'; %set activation function of first layer
    mlp20satCV.divideFcn='divideind';
    mlp20satCV.divideParam.trainInd=1:length(x); % use all the train data.
    mlp20satCV.trainParam.epochs=1000; % set epochs
    [mlp20satCV,~] = train(mlp20satCV,x,t); % train network
    
    %% calcute accuracy
    % set testdata
    x=Ttestdata';
    t=TtestLabel';
    y=mlp20satCV(x);
    [~,a]=max(y);
    analyselabel=ones(length(x),1);
    aa=find(a==2);
    analyselabel(aa')=-1;
    
    atp=find(analyselabel==1);ttp=find(t==1);
    an=double(ismember(ttp',atp,'rows'));
    TP=length(find(an==1)); 
    afp=find(analyselabel==-1);tfp=find(t==-1);
    an=double(ismember(tfp',afp,'rows'));
    TN=length(find(an==1));
    TPTN=TP+TN;
    accuracy=TPTN/length(t);
    %% record accuracy in a vector
    accuracyvector=[accuracyvector,accuracy];
end
save accuracyvector.mat accuracyvector;
