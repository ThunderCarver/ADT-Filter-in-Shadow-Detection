function [ shadowboundaryfeature ] = illfeature( ill,boundaries,edgeorientation )
%BOUNDARYILLFEATURE computes the features of neighborhoods around boundaries
%in illuminant invariant image. 
%   Due to nobody can decide which channel determine the shadow boundaries,
%   so we should consider the results of each three channels to ensure 
%   which boundaries are shadow edge.
%   As long as there is significant difference, would it be the shadow
%   edge.

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


    ill1=ill(:,:,1);
    ill2=ill(:,:,2);
    ill3=ill(:,:,3);
    % handle boundary overflowing  Repeats border elements of A.
    ill1pad=padarray(ill1',2,'replicate','both')';
    ill1pad=padarray(ill1pad,2,'replicate','both');
    ill1pad3=padarray(ill1',3,'replicate','both')';
    ill1pad3=padarray(ill1pad3,3,'replicate','both');
    
    ill2pad=padarray(ill2',2,'replicate','both')';
    ill2pad=padarray(ill2pad,2,'replicate','both');
    ill2pad3=padarray(ill2',3,'replicate','both')';
    ill2pad3=padarray(ill2pad3,3,'replicate','both');
    
    ill3pad=padarray(ill3',2,'replicate','both')';
    ill3pad=padarray(ill3pad,2,'replicate','both');
    ill3pad3=padarray(ill3',3,'replicate','both')';
    ill3pad3=padarray(ill3pad3,3,'replicate','both');

%allocate space to save boundaries features in ILL color space,where 1-4 represent 1st channel,5-8 represent 2nd channel,9-12 represent 3rd channel
    sythesischannelfeat=cell(length(edgeorientation),12);
%% Calculate the feature
    for i=1:length(edgeorientation)
        dimension=size(edgeorientation{i});
        for j=1:dimension(1,1)
            if sum(edgeorientation{i}(j,:)==[0,1])==2 || sum(edgeorientation{i}(j,:)==[0,-1])==2 %???????? 
               sythesischannelfeat{i,1}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*fhorizen));
               sythesischannelfeat{i,2}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*OPfhorizen));
               sythesischannelfeat{i,3}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*fhorizen3));
               sythesischannelfeat{i,4}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*OPfhorizen3));              
               sythesischannelfeat{i,5}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*fhorizen));
               sythesischannelfeat{i,6}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*OPfhorizen));
               sythesischannelfeat{i,7}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*fhorizen3));
               sythesischannelfeat{i,8}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*OPfhorizen3));
               sythesischannelfeat{i,9}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*fhorizen));
               sythesischannelfeat{i,10}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2)+1:boundaries{i}(j,2)+3).*OPfhorizen));
               sythesischannelfeat{i,11}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*fhorizen3));
               sythesischannelfeat{i,12}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2)+2:boundaries{i}(j,2)+4).*OPfhorizen3));
            elseif sum(edgeorientation{i}(j,:)==[1,0])==2||sum(edgeorientation{i}(j,:)==[-1,0])==2 %????????
               sythesischannelfeat{i,1}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fvertical));
               sythesischannelfeat{i,2}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfvertical));
               sythesischannelfeat{i,3}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical3));
               sythesischannelfeat{i,4}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical3));
               sythesischannelfeat{i,5}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fvertical));
               sythesischannelfeat{i,6}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfvertical));
               sythesischannelfeat{i,7}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical3));
               sythesischannelfeat{i,8}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical3));             
               sythesischannelfeat{i,9}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fvertical));
               sythesischannelfeat{i,10}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1)+1:boundaries{i}(j,1)+3,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfvertical));
               sythesischannelfeat{i,11}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fvertical3));
               sythesischannelfeat{i,12}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1)+2:boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfvertical3));
            elseif sum(edgeorientation{i}(j,:)==[1,1])==2||sum(edgeorientation{i}(j,:)==[-1,-1])==2 %-45??????
               sythesischannelfeat{i,1}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fnegative));
               sythesischannelfeat{i,2}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfnegative)); 
               sythesischannelfeat{i,3}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               sythesischannelfeat{i,4}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));              
               sythesischannelfeat{i,5}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fnegative));
               sythesischannelfeat{i,6}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfnegative));
               sythesischannelfeat{i,7}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               sythesischannelfeat{i,8}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));             
               sythesischannelfeat{i,9}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fnegative));
               sythesischannelfeat{i,10}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfnegative));
               sythesischannelfeat{i,11}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fnegative3));
               sythesischannelfeat{i,12}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfnegative3));
            elseif sum(edgeorientation{i}(j,:)==[1,-1])==2||sum(edgeorientation{i}(j,:)==[-1,1])==2 %+45??????
               sythesischannelfeat{i,1}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fpositive));
               sythesischannelfeat{i,2}(j,1)=sum(sum(ill1pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfpositive));
               sythesischannelfeat{i,3}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               sythesischannelfeat{i,4}(j,1)=sum(sum(ill1pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));
               sythesischannelfeat{i,5}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fpositive));
               sythesischannelfeat{i,6}(j,1)=sum(sum(ill2pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfpositive));
               sythesischannelfeat{i,7}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               sythesischannelfeat{i,8}(j,1)=sum(sum(ill2pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));           
               sythesischannelfeat{i,9}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*fpositive));
               sythesischannelfeat{i,10}(j,1)=sum(sum(ill3pad(boundaries{i}(j,1):boundaries{i}(j,1)+4,boundaries{i}(j,2):boundaries{i}(j,2)+4).*OPfpositive));
               sythesischannelfeat{i,11}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*fpositive3));
               sythesischannelfeat{i,12}(j,1)=sum(sum(ill3pad3(boundaries{i}(j,1):boundaries{i}(j,1)+6,boundaries{i}(j,2):boundaries{i}(j,2)+6).*OPfpositive3));
            end
        end            
    end
%% get result
    shadowboundaryfeature=sythesischannelfeat;
end


