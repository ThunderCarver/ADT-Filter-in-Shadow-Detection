function   depictboundary( image,boundary,color,width)
%DEPICTBOUNDARY depict the boundary on specific image.
%   image is the specific image\boundary is extracted by user\color is the
%   color of boundary\width is the width of line.

figure,imshow(image),hold on;
cellfun(@(x) plot(x(:,2),x(:,1),'Color',color,'LineWidth',width),boundary);
title(sprintf('%d boundaries have been found',length(boundary)));
hold off;
end

