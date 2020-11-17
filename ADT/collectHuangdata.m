currentpath=cd;
imagepath=fullfile(currentpath,'/img');
xmlpath=fullfile(fileparts(currentpath),'datasets/xml/');
files=dir(strcat(imagepath,'/*.jpg'));
Instance=[];
Label=[];
for loop=1:length(files)
    %% extract features
   img=imread(files(loop).name);
   imHeight = size(img, 1);
   imWidth = size(img, 2);
   [row, col] = find(edge(rgb2gray(img),'canny'));
   instance = HuangbuildFeatures(img, [col, row], length(row));
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
    %% making Label
   imgBT=cat(2,col,row);
   label=double(ismember(imgBT,coordinate,'rows'));
   label(label==0)=-1;
    %% use min-max to normalize feature vectors 
   instance=normalize(instance);
    %% balance traindata
   [instance,label]=balancedata(instance,label);
    %% concatenate the balanced and normalized features and its label
   Label=cat(1,Label,label);
   Instance=cat(1,Instance,instance);
end
save Huangdata.mat Instance Label;
%% after finishing the collection of feature vectors, use 'dividedata.m'.
