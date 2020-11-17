
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% positive label represent shadow boundary
% -1 label represent non-shadow boundary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [traindata,trainlabel]=balancedata(instance,label)
poslabel=find(label==1);
positivetraindata=instance(poslabel,:);
positivelabel=label(poslabel);

negalabel=find(label==-1);% find all nagative label
negalabel=negalabel(1:length(poslabel));% positive label length=negative label length

negativetraindata=instance(negalabel,:);
negativelabel=label(negalabel);

traindata=cat(1,positivetraindata,negativetraindata);
trainlabel=cat(1,positivelabel,negativelabel);
end