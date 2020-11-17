currentpath=cd;
imagepath=fullfile(currentpath,'/img');
xmlpath=fullfile(fileparts(currentpath),'datasets/xml/');
files=dir(strcat(imagepath,'/*.jpg'));
Instance=[];
Label=[];
for loop=1:length(files)
    %% extract features
   img=imread(files(loop).name);
   [instance,boundaries]=extractfeature(img);
   %% obtain xml label
   shadowinfo=load_xml(strcat(xmlpath,strrep(files(loop).name,'.jpg','.xml')));
   xcoor=arrayfun(@(x) str2double(x.x),shadowinfo.shadowCoords.pt);
   ycoor=arrayfun(@(x) str2double(x.y),shadowinfo.shadowCoords.pt);
   %consider all neighbor -.5,-.5||-.5,+.5||+.5,-.5||+.5+.5
   xcoor1=xcoor-.5;ycoor1=ycoor-.5;
   xcoor2=xcoor-.5;ycoor2=ycoor+.5;
   xcoor3=xcoor+.5;ycoor3=ycoor-.5;
   xcoor4=xcoor+.5;ycoor4=ycoor+.5;
   coordinate=...,
   cat(1,cat(2,xcoor1',ycoor1'),cat(2,xcoor2',ycoor2'),cat(2,xcoor3',ycoor3'),cat(2,xcoor4',ycoor4'));
   %% removing unexisted points in instance
   for imgBamount=1:length(boundaries)
       if length(boundaries{imgBamount,1})==2 && sum(boundaries{imgBamount,1}(1,:)==boundaries{imgBamount,1}(2,:))==2
           boundaries{imgBamount}=[];   %removing point-cell
       else
           boundaries{imgBamount}(length(boundaries{imgBamount}),:)=[];  %removing the last row in every cell
       end
   end
   %% making label
   imgb=cell2mat(boundaries);
   y=imgb(:,1);x=imgb(:,2);
   imgBT=cat(2,x,y);
   label=double(ismember(imgBT,coordinate,'rows'));
%    q=find(label);
%    figure,imshow(img),hold on;
%    plot(imgBT(q,1),imgBT(q,2),'y+','linewidth',1,'markersize',1);hold off;
%    title(sprintf('corresponding overlap points is %2f',length(q)/length(xcoor)));
   label(label==0)=-1;
   %% use min-max to normalize feature vectors 
   instance=normalize(instance);
   %% balance traindata
   [instance,label]=balancedata(instance,label);
   %% concatenate the balanced and normalized features and its label
   Label=cat(1,Label,label);
   Instance=cat(1,Instance,instance);
end
save traindata.mat Instance Label;
% after running this code, run dividedata.m
