
img=imread('Documents/ADT-Filter-in-Shadow-Dataset/datasets/images/zhu-labelme_0003.jpg');
[instance,boundaries]=extractfeature(img);
%% normalize data
instance=normalize(instance);
%% read ground truth
xml=load_xml('Documents/ADT-Filter-in-Shadow-Dataset/datasets/xml/zhu-labelme_0003.xml');
x=arrayfun(@(a) str2double(a.x),xml.shadowCoords.pt);
y=arrayfun(@(a) str2double(a.y),xml.shadowCoords.pt);
coordinate=cat(1,cat(2,(x-0.5)',(y-0.5)'),cat(2,(x-0.5)',(y+0.5)'),cat(2,(x+0.5)',(y-0.5)'),cat(2,(x+0.5)',(y+0.5)'));
%% eliminate extra coordinates
for imgBamount=1:length(boundaries)
       if length(boundaries{imgBamount,1})==2 && sum(boundaries{imgBamount,1}(1,:)==boundaries{imgBamount,1}(2,:))==2
           boundaries{imgBamount}=[];   %removing point-cell
       else
           boundaries{imgBamount}(length(boundaries{imgBamount}),:)=[];  %removing the last row in every cell
       end
 end
T=cell2mat(boundaries);
TT=cat(2,T(:,2),T(:,1));
testLabel=double(ismember(TT,coordinate,'rows'));
testLabel(testLabel==0)=-1;
%% conduct MLP anticipate  (You can also change to AE or SVM models)
load ('cross validation/3/mlp10satCV.mat');
feedinput=instance';
y=mlp10satCV(feedinput);
[~,a]=max(y);
analyselabel=ones(length(feedinput),1);
aa=find(a==2);
analyselabel(aa')=-1;
coor=find(analyselabel==1);
co=TT(coor,:);
rows=co(:,1);cols=co(:,2);
figure,imshow(img),hold on,plot(rows,cols,'r.','markersize',1),hold off;
%% ROC
auc = roc_curve(y(1,:)', testLabel);
%% accuracy,precision,recall
% atp=find(analyselabel==1);ttp=find(testLabel==1);
% an=double(ismember(ttp,atp,'rows'));
% TP=length(find(an==1)); FP=length(ttp)-TP;
% afp=find(analyselabel==-1);tfp=find(testLabel==-1);
% an=double(ismember(tfp,afp,'rows'));
% TN=length(find(an==1)); FN=length(tfp)-TN;
% 
% TPTN=TP+TN;
% accuracy=TPTN/length(testLabel);
% precision=TP/(TP+FP);
% recall=TP/(TP+FN);
% fprintf('accuracy=%f\t precision=%f\t recall=%f\n',accuracy,precision,recall);
