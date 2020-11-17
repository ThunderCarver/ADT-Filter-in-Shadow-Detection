
%BOUNDARYRGBRATIOFEATURE This function is based on the theorem that shadow
%all have a blue mask,which means the propopation of blue color should take
%more percentage in rgb color sapce.
%   One can calculate the color intensity in different channel seperately.
%   Causing the shadow always have lower intensity compared with area 
%   illustrated by sun,we can determined that L is shadow,H is sun lit.
%   We define Tr=Lr/Hr,Tg=Lg/Hg,Tb=Lb/Hb.The feature vector is made of 
%   (Tr+Tg+Tb)/3 , Tbr=Tb/Tr ,Tbg=Tb/Tg in 1st 2nd 3rd column seperately. 
function [ rgbshadowboundaryfeature ] = rgbratiofeature(img,boundaries,edgeorientation)
r=double(img(:,:,1));
g=double(img(:,:,2));
b=double(img(:,:,3));
%three piexls width of filter
fvertical=[1.0 1 1 0 0 0 0];
OPfvertical=rot90(fvertical,2);
fhorizen=fvertical';
OPfhorizen=rot90(fhorizen,2);
fnegative=[0.0 0 0 0 0 0 0;1 0 0 0 0 0 0;1 1 0 0 0 0 0;1 1 1 0 0 0 0;1 1 1 1 0 0 0;1 1 1 1 1 0 0;1 1 1 1 1 1 0];
OPfnegative=fnegative';
fpositive=[1.0 1 1 1 1 1 0;1 1 1 1 1 0 0;1 1 1 1 0 0 0;1 1 1 0 0 0 0;1 1 0 0 0 0 0;1 0 0 0 0 0 0;0 0 0 0 0 0 0];
OPfpositive=rot90(fpositive,2);
%matrix fill    Repeats border elements of A.
r3=padarray(r,3,'replicate','both')';
r3=padarray(r3,3,'replicate','both')';
g3=padarray(g,3,'replicate','both')';
g3=padarray(g3,3,'replicate','both')';
b3=padarray(b,3,'replicate','both')';
b3=padarray(b3,3,'replicate','both')';
%allocate space
ratio=cell(length(edgeorientation),3);

%calculate rgb ratio
for i=1:length(edgeorientation)
    dimension=size(edgeorientation{i});
    for j=1:dimension(1,1)
        if sum(edgeorientation{i}(j,:)==[0,1])==2 || sum(edgeorientation{i}(j,:)==[0,-1])==2 %horizontal direction
            ratio{i,1}(j,1)=sum(sum(r3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+3).*fhorizen));
            ratio{i,1}(j,2)=sum(sum(r3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+3).*OPfhorizen));
            ratio{i,2}(j,1)=sum(sum(g3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+3).*fhorizen));
            ratio{i,2}(j,2)=sum(sum(g3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+3).*OPfhorizen));
            ratio{i,3}(j,1)=sum(sum(b3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+3).*fhorizen));
            ratio{i,3}(j,2)=sum(sum(b3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+3).*OPfhorizen));
        elseif sum(edgeorientation{i}(j,:)==[1,0])==2||sum(edgeorientation{i}(j,:)==[-1,0])==2 %vertical direction
            ratio{i,1}(j,1)=sum(sum(r3(boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical));
            ratio{i,1}(j,2)=sum(sum(r3(boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical));
            ratio{i,2}(j,1)=sum(sum(g3(boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical));
            ratio{i,2}(j,2)=sum(sum(g3(boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical));
            ratio{i,3}(j,1)=sum(sum(b3(boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical));
            ratio{i,3}(j,2)=sum(sum(b3(boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical));
        elseif sum(edgeorientation{i}(j,:)==[1,1])==2||sum(edgeorientation{i}(j,:)==[-1,-1])==2 %-45 direction
            ratio{i,1}(j,1)=sum(sum(r3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative));
            ratio{i,1}(j,2)=sum(sum(r3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative));
            ratio{i,2}(j,1)=sum(sum(g3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative));
            ratio{i,2}(j,2)=sum(sum(g3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative));
            ratio{i,3}(j,1)=sum(sum(b3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative));
            ratio{i,3}(j,2)=sum(sum(b3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative));
        elseif sum(edgeorientation{i}(j,:)==[1,-1])==2||sum(edgeorientation{i}(j,:)==[-1,1])==2 %+45 direction
            ratio{i,1}(j,1)=sum(sum(r3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive));
            ratio{i,1}(j,2)=sum(sum(r3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive));
            ratio{i,2}(j,1)=sum(sum(g3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive));
            ratio{i,2}(j,2)=sum(sum(g3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive));
            ratio{i,3}(j,1)=sum(sum(b3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive));
            ratio{i,3}(j,2)=sum(sum(b3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive));
        end
    end
end
%% Obtain the percentage of blue color in different metrics
rgbshadowboundaryfeature=obtainblueratio(ratio);
