%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% After collecting correspoding feature vectors and making the labels,
% we use dividedata.m to randomly divide traindata into 7 groups in order 
% to implement 7-cross validation.
% We manually run this file 7 times and put the results into related path.
% use ADT dataset(traindata.mat) or Huang dataset(Huangdata.mat)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('Huangdata.mat');      % Huang dataset
load ('traindata.mat');  % ADT dataset

postiveind=find(Label==1);                
negativeind=find(Label==-1);
postivefeature=Instance(postiveind,:);    
postiveLabel=Label(postiveind,:);
negativefeature=Instance(negativeind,:);  
negativeLabel=Label(negativeind,:);

len=length(postivefeature);
ind=randperm(len);
number=round(len*0.7);

groupAtrain=postivefeature(ind(1:number),:);    groupAlabel=ones(number,1);
groupCtest=postivefeature(ind(number+1:end),:); groupClabel=ones((len-number),1);
groupBtrain=negativefeature(ind(1:number),:);   groupBlabel=-1*ones(number,1);
groupDtest=negativefeature(ind(number+1:end),:);groupDlabel=-1*ones((len-number),1);

%% concatenate groups
Ttraindata=cat(1,groupAtrain,groupBtrain);
Ttestdata=cat(1,groupCtest,groupDtest);
TtrainLabel=cat(1,groupAlabel,groupBlabel);
TtestLabel=cat(1,groupClabel,groupDlabel);
save Ttraindata.mat Ttraindata  TtrainLabel        % save ADT traindataset 
save Ttestdata.mat Ttestdata TtestLabel            % save ADT testdataset
% save Htraindata.mat Ttraindata  TtrainLabel      % save Huang traingdataset
% save Htestdata.mat Ttestdata TtestLabel          % save Huang testdataset
