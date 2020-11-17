
%OBTAINBLUERATIO obtain the blue ratio in different aspects.The first column
%is Tb/(Tr+Tg+Tb), the second column is Tbr=Tb/Tr, the third column is  
%Tbg=Tb/Tg.
%In ratio data structure, ratio{i,1}->red, ratio{i,2}->green, ratio{i,3}->blue
%Pay a attention to the each row with additional one, because it is
%used to eliminate the phenomenon 0/0->NaN and constant/0->Inf
function [ rgbbluefeature ] = obtainblueratio( ratio )
rgbbluefeature=cell(length(ratio),3);
T=rgbbluefeature;
for i=1:length(ratio)
    for j=1:length(ratio{i,1})
        if ratio{i,1}(j,1)<ratio{i,1}(j,2)
            T{i,1}(j,1)=(ratio{i,1}(j,1)+1)/(ratio{i,1}(j,2)+1);
        else
            T{i,1}(j,1)=(ratio{i,1}(j,2)+1)/(ratio{i,1}(j,1)+1);
        end
        if ratio{i,2}(j,1)<ratio{i,2}(j,2)
            T{i,2}(j,1)=(ratio{i,2}(j,1)+1)/(ratio{i,2}(j,2)+1);
        else
            T{i,2}(j,1)=(ratio{i,2}(j,2)+1)/(ratio{i,2}(j,1)+1);
        end
        if ratio{i,3}(j,1)<ratio{i,3}(j,2)
            T{i,3}(j,1)=(ratio{i,3}(j,1)+1)/(ratio{i,3}(j,2)+1);
        else
            T{i,3}(j,1)=(ratio{i,3}(j,2)+1)/(ratio{i,3}(j,1)+1);
        end
    end
end
for i=1:length(ratio)
    for j=1:length(ratio{i,1})
        %rgbbluefeature{i,1}(j,1)=(T{i,1}(j,1)+T{i,2}(j,1)+T{i,3}(j,1))/3;
        rgbbluefeature{i,1}(j,1)=T{i,3}(j,1)./(T{i,1}(j,1)+T{i,2}(j,1)+T{i,3}(j,1));
        rgbbluefeature{i,2}(j,1)=T{i,3}(j,1)./T{i,1}(j,1);
        rgbbluefeature{i,3}(j,1)=T{i,3}(j,1)./T{i,2}(j,1);
    end
end
%cellfun(@(a) find(isnan(a)==0),rgbbluefeature);
end

