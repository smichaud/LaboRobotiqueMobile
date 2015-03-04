% initialize
% subscribeKinect

% Loop until the figure is closed
figure('name',sensor)
while(findobj('type','figure','name', sensor))
    image = [];
    depthMap = [];
    rgbImage = [];
    
    while (isempty(image) || isempty(depthMap)) 
        [image, depthMap, timestamp] = ros4mat(sensor);
    end
    
    % Create RGB image from BGR
    rgbImage = image;%flipdim(image,3);
    % Show the RGB image + cross
    subplot(1,2,1);    
    imagesc(rgbImage);
    daspect([1 1 1]);
    c = axis();
    % Create black cross to show the optical center
%    line(c(1:2), [size(rgbImage,1)/2 size(rgbImage,1)/2],'Color','k');
%    line([size(rgbImage,2)/2 size(rgbImage,2)/2],c(3:4),'Color','k');
%    line([size(rgbImage,2)/6 size(rgbImage,2)/6],c(3:4),'Color','k');
%    line([5*size(rgbImage,2)/6 5*size(rgbImage,2)/6],c(3:4),'Color','k');
    
    % Show depth map
    subplot(1,2,2);
    imagesc(depthMap);
%     colorbar; % Show the color legend
    daspect([1 1 1]);    
    
    drawnow;
    
    % Print optical center depth
%      leftDepth = depthMap(round(size(rgbImage,1)/2), round(size(rgbImage,2)/6));
%     opticalCenterDepth = depthMap(size(rgbImage,1)/2, size(rgbImage,2)/2);
%     rightDepth = depthMap(round(size(rgbImage,1)/2), round(5*size(rgbImage,2)/6));
%     fprintf('Left:%f | Center:%f | Right:%f \n', leftDepth, opticalCenterDepth, rightDepth);
end

% finalize
