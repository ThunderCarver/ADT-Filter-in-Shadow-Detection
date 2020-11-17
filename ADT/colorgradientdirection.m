%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%COLORGRADIENTDIRECTION computes the color gradient direction by sobel
%approach to differ shadow boundaries and object boundaries.
%For any candidate edge pixel at a shadow boundary where reflectance is 
%locally constant,the image gradient should have the same direction in all 
%color channels, as the RGB illumination gradients are all perpendicular to
%the shadow boundary. Other kinds of edges may lack this property.
%Notes
%    -----
%  When applying the gradient operator at the boundaries of the image,values 
%outside the bounds of the image are assumed to equal the nearest image 
%border value. This is similar to the 'replicate' boundary option in IMFILTER.
function [ colorgradientdirfeature ] = colorgradientdirection( img,boundaries )
    dimensions=size(img,3);
    for k =1:dimensions
        [~,Gdir(:,:,k)]=imgradient(img(:,:,k));
    end
    %direction=cellfun(@(x) Gdir(x(:,1),x(:,2),:),boundaries,'UniformOutput',0);
    %direction=boundaries; %it's for allocating space to accumulate computing 
    for i=1:length(boundaries)
        if length(boundaries{i,1})==2 && sum(boundaries{i,1}(1,:)==boundaries{i,1}(2,:))==2
           colorgradientdirfeature{i,1}=[]; %removing the point-cell
        else
            for j=1:size(boundaries{i,1},1)-1  %here decrease one in order to euqal with the number of other feature,in each cell due to they obtain value by diff()
                for k=1:dimensions 
                    direction{i,1}(j,k)=Gdir(boundaries{i,1}(j,1),boundaries{i,1}(j,2),k)/180;
                end
                dir=direction{i,1}(j,:);
                colorgradientdirfeature{i,1}(j,:)=min( abs(dir-dir([2,3,1])) , 2*pi-abs(dir-dir([2,3,1])) )/2;
            end
        end
    end
end

