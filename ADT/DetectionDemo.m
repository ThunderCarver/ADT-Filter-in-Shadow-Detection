%% read image
img=imread('/Documents/ADT-Filter-in-Shadow-Detection/datasets/images/zhu-dsc01657.jpg');
%% extract features
[instance,boundaries]=extractfeature(img);
%% normalize data
instance=normalize(instance);
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
%% load MLP/AE model
load ('cross validation/1/AE2010satCV.mat');
y=AE2010satCV(instance');
[~,a]=max(y);
analyselabel=ones(length(instance'),1);
aa=find(a==2);
analyselabel(aa')=-1;
coor=find(analyselabel==1);
co=TT(coor,:);
rows=co(:,1);cols=co(:,2);
figure,imshow(img),hold on,plot(rows,cols,'r.','markersize',1),hold off;
saveas(gcf,'/Documents/screenshoot/zhu-dsc01657AE2010.png');
%% load svm model
% load ('cross validation/6/SVMCV.mat');
% [preLabel,~,probEstimate] = predict(SVMCV, instance);
% coor=find(preLabel==1);
% co=TT(coor,:);
% rows=co(:,1);cols=co(:,2);
% figure,imshow(img),hold on,plot(rows,cols,'r.','markersize',1.5),hold off;
% saveas(gcf,'/Documents/screenshoot/zhu-dsc01657svm.png');
