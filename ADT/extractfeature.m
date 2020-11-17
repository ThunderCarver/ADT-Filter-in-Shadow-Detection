
function [instance,boundaries]=extractfeature(img)
    %% smooth image
    imgsmooth=imguidedfilter(img);
    %% color space transform 
    imggray=rgb2gray(imgsmooth);
    imgill=rgb2ill(imgsmooth);
    imglab=rgb2lab(imgsmooth);
    imgb=double(imglab(:,:,3));
    %% finding boundaries on gray image
    imgedge=edge(imggray,'canny',0.2,3);
    boundaries=bwboundaries(imgedge,8,'noholes');
    edgeorientation=cellfun(@(x) diff(x),boundaries,'UniformOutput',0);
    %% show the boundaries on corresponding image
%     depictboundary(img,boundaries,'blue',1);
    %% calculate the boundary features on different fundations
    imggray=double(imggray);
    labshadowboundaryfeature=labfeature(imggray,imgb,boundaries,edgeorientation);
    illshadowboundaryfeature=illfeature(imgill,boundaries,edgeorientation);
    rgbshadowboundaryfeature=rgbratiofeature(img,boundaries,edgeorientation);
    colorgradientdirfeature=colorgradientdirection(img,boundaries);
    instance=cell2mat([labshadowboundaryfeature.lightness,labshadowboundaryfeature.skew,labshadowboundaryfeature.kurto,...
           labshadowboundaryfeature.bchannel,illshadowboundaryfeature,rgbshadowboundaryfeature,colorgradientdirfeature]);
    %% let NaN=0
       instance(isnan(instance))=0;
end
