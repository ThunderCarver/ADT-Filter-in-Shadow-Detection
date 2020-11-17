function [ shadowboundaryfeature ] = labfeature( imggray,imgb,boundaries,edgeorientation )
%BOUNDARYLABFEATURE computes features of the neighborhoods of the boundary
%in LAB color space.
%Includes lightness feature and 'b' channel feature.
%Negative values indicate blue and positive values indicate yellow.
%skew feature is the skewness of a specific area.Horizental vertical,etc has
%corresponding weights for each oritation.After each dim detemined,average it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %two piexls width of filter 
    fvertical=[1.0 1 0 0 0;1 1 0 0 0;1 1 0 0 0];
    OPfvertical=rot90(fvertical,2);
    fhorizen=fvertical';
    OPfhorizen=rot90(fhorizen,2);
    fnegative=[0.0 0 0 0 0;1 0 0 0 0;1 1 0 0 0;1 1 1 0 0;1 1 1 1 0];
    OPfnegative=fnegative';
    fpositive=[1.0 1 1 1 0;1 1 1 0 0;1 1 0 0 0;1 0 0 0 0;0 0 0 0 0];
    OPfpositive=rot90(fpositive,2);
    %three piexls width of filter
    fvertical3=[1.0 1 1 0 0 0 0;1 1 1 0 0 0 0;1 1 1 0 0 0 0];
    OPfvertical3=rot90(fvertical3,2);
    fhorizen3=fvertical3';
    OPfhorizen3=rot90(fhorizen3,2);
    fnegative3=[0.0 0 0 0 0 0 0;1 0 0 0 0 0 0;1 1 0 0 0 0 0;1 1 1 0 0 0 0;1 1 1 1 0 0 0;1 1 1 1 1 0 0;1 1 1 1 1 1 0];
    OPfnegative3=fnegative3';
    fpositive3=[1.0 1 1 1 1 1 0;1 1 1 1 1 0 0;1 1 1 1 0 0 0;1 1 1 0 0 0 0;1 1 0 0 0 0 0;1 0 0 0 0 0 0;0 0 0 0 0 0 0];
    OPfpositive3=rot90(fpositive3,2);
    %five piexls width of filter
    fvertical5=[1.0 1 1 1 1 0 0 0 0 0 0;1 1 1 1 1 0 0 0 0 0 0;1 1 1 1 1 0 0 0 0 0 0];
    OPfvertical5=rot90(fvertical5,2);
    fhorizen5=fvertical5';
    OPfhorizen5=rot90(fhorizen5,2);
    
    
    % handle boundary overflowing
    imglpad=padarray(imggray',2,'replicate','both')';
    imglpad=padarray(imglpad,2,'replicate','both');
    imglpad3=padarray(imggray',3,'replicate','both')';
    imglpad3=padarray(imglpad3,3,'replicate','both');
    imglpad5=padarray(imggray',5,'replicate','both')';
    imglpad5=padarray(imglpad5,5,'replicate','both');
    
    imgbpad=padarray(imgb',2,'replicate','both')';
    imgbpad=padarray(imgbpad,2,'replicate','both');
    imgbpad3=padarray(imgb',3,'replicate','both')';
    imgbpad3=padarray(imgbpad3,3,'replicate','both');
    imgbpad5=padarray(imgb',5,'replicate','both')';
    imgbpad5=padarray(imgbpad5,5,'replicate','both');
    %allocate space to save boundaries features in LAB color space
    lightnessfeat=cell(length(edgeorientation),6);
    blue2yellowfeat=cell(length(edgeorientation),6);
    skew=cell(length(edgeorientation),1);
    kurto=cell(length(edgeorientation),1);
    
    for i=1:length(edgeorientation)
        dimension=size(edgeorientation{i});
        for j=1:dimension(1,1)
            if sum(edgeorientation{i}(j,:)==[0,1])==2 || sum(edgeorientation{i}(j,:)==[0,-1])==2 % horizen 
               lightnessfeat{i,1}(j,1)=sum(sum(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*fhorizen));
               lightnessfeat{i,2}(j,1)=sum(sum(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*OPfhorizen));
               lightnessfeat{i,3}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*fhorizen3));
               lightnessfeat{i,4}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*OPfhorizen3));
               lightnessfeat{i,5}(j,1)=sum(sum(imglpad5(boundaries{i}(j,1):boundaries{i}(j,1)+10,boundaries{i}(j,2)+4:boundaries{i}(j,2)+6).*fhorizen5));
               lightnessfeat{i,6}(j,1)=sum(sum(imglpad5(boundaries{i}(j,1):boundaries{i}(j,1)+10,boundaries{i}(j,2)+4:boundaries{i}(j,2)+6).*OPfhorizen5));
               
               skew{i,1}(j,1)=mean(skewness(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3),1,1));
               skew{i,1}(j,2)=mean(skewness(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4),1,1));
               skew{i,1}(j,3)=mean(skewness(imglpad5(boundaries{i}(j,1):boundaries{i}(j,1)+10,boundaries{i}(j,2)+4:boundaries{i}(j,2)+6),1,1));
               kurto{i,1}(j,1)=mean(kurtosis(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3),1,1));
               kurto{i,1}(j,2)=mean(kurtosis(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4),1,1));
               kurto{i,1}(j,3)=mean(kurtosis(imglpad5(boundaries{i}(j,1):boundaries{i}(j,1)+10,boundaries{i}(j,2)+4:boundaries{i}(j,2)+6),1,1));
               
               blue2yellowfeat{i,1}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*fhorizen));
               blue2yellowfeat{i,2}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*OPfhorizen));
               blue2yellowfeat{i,3}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*fhorizen3));
               blue2yellowfeat{i,4}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*OPfhorizen3));
               blue2yellowfeat{i,5}(j,1)=sum(sum(imgbpad5(boundaries{i}(j,1):boundaries{i}(j,1)+10,boundaries{i}(j,2)+4:boundaries{i}(j,2)+6).*fhorizen5));
               blue2yellowfeat{i,6}(j,1)=sum(sum(imgbpad5(boundaries{i}(j,1):boundaries{i}(j,1)+10,boundaries{i}(j,2)+4:boundaries{i}(j,2)+6).*OPfhorizen5));
            elseif sum(edgeorientation{i}(j,:)==[1,0])==2||sum(edgeorientation{i}(j,:)==[-1,0])==2 % vertical
               lightnessfeat{i,1}(j,1)=sum(sum(imglpad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fvertical));
               lightnessfeat{i,2}(j,1)=sum(sum(imglpad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfvertical)); 
               lightnessfeat{i,3}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical3));
               lightnessfeat{i,4}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical3));
               lightnessfeat{i,5}(j,1)=sum(sum(imglpad5(boundaries{i}(j,1)+4:boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+10).*fvertical5));
               lightnessfeat{i,6}(j,1)=sum(sum(imglpad5(boundaries{i}(j,1)+4:boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+10).*OPfvertical5));
               
               skew{i,1}(j,1)=mean(skewness(imglpad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4),1,2));
               skew{i,1}(j,2)=mean(skewness(imglpad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6),1,2));
               skew{i,1}(j,3)=mean(skewness(imglpad5(boundaries{i}(j,1)+4:boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+10),1,2));
               kurto{i,1}(j,1)=mean(kurtosis(imglpad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4),1,2));
               kurto{i,1}(j,2)=mean(kurtosis(imglpad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6),1,2));
               kurto{i,1}(j,3)=mean(kurtosis(imglpad5(boundaries{i}(j,1)+4:boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+10),1,2));
               
               blue2yellowfeat{i,1}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fvertical));
               blue2yellowfeat{i,2}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfvertical));
               blue2yellowfeat{i,3}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical3));
               blue2yellowfeat{i,4}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical3));
               blue2yellowfeat{i,5}(j,1)=sum(sum(imgbpad5(boundaries{i}(j,1)+4:boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+10).*fvertical5));
               blue2yellowfeat{i,6}(j,1)=sum(sum(imgbpad5(boundaries{i}(j,1)+4:boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+10).*OPfvertical5));
            elseif sum(edgeorientation{i}(j,:)==[1,1])==2||sum(edgeorientation{i}(j,:)==[-1,-1])==2 %-45 slope
               lightnessfeat{i,1}(j,1)=sum(sum(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fnegative));
               lightnessfeat{i,2}(j,1)=sum(sum(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfnegative)); 
               lightnessfeat{i,3}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               lightnessfeat{i,4}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));
               lightnessfeat{i,5}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               lightnessfeat{i,6}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));
               
               skew{i,1}(j,1)=skewness(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4),1,'all');
               skew{i,1}(j,2)=skewness(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6),1,'all');
               skew{i,1}(j,3)=skew{i,1}(j,2);
               kurto{i,1}(j,1)=kurtosis(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4),1,'all');
               kurto{i,1}(j,2)=kurtosis(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6),1,'all');
               kurto{i,1}(j,3)=kurto{i,1}(j,2);
               
               blue2yellowfeat{i,1}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fnegative));
               blue2yellowfeat{i,2}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfnegative));
               blue2yellowfeat{i,3}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               blue2yellowfeat{i,4}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));
               blue2yellowfeat{i,5}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               blue2yellowfeat{i,6}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));
            elseif sum(edgeorientation{i}(j,:)==[1,-1])==2||sum(edgeorientation{i}(j,:)==[-1,1])==2 %+45 slope
               lightnessfeat{i,1}(j,1)=sum(sum(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fpositive));
               lightnessfeat{i,2}(j,1)=sum(sum(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfpositive));
               lightnessfeat{i,3}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               lightnessfeat{i,4}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));
               lightnessfeat{i,5}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               lightnessfeat{i,6}(j,1)=sum(sum(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));
               
               skew{i,1}(j,1)=skewness(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4),1,'all');
               skew{i,1}(j,2)=skewness(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6),1,'all');
               skew{i,1}(j,3)=skew{i,1}(j,2);
               kurto{i,1}(j,1)=kurtosis(imglpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4),1,'all');
               kurto{i,1}(j,2)=kurtosis(imglpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6),1,'all');
               kurto{i,1}(j,3)=kurto{i,1}(j,2);
               
               blue2yellowfeat{i,1}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fpositive));
               blue2yellowfeat{i,2}(j,1)=sum(sum(imgbpad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfpositive));
               blue2yellowfeat{i,3}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               blue2yellowfeat{i,4}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));
               blue2yellowfeat{i,5}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               blue2yellowfeat{i,6}(j,1)=sum(sum(imgbpad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));
            end
        end            
    end
    shadowboundaryfeature.lightness=lightnessfeat;
    shadowboundaryfeature.skew=skew;
    shadowboundaryfeature.kurto=kurto;
    shadowboundaryfeature.bchannel=blue2yellowfeat;
end



