function drawCloud(pointCloud)
    plot3(pointCloud(:,:,1), pointCloud(:,:,2), pointCloud(:,:,3),...
        '.', 'Color', 'black');
    daspect([1 1 1]);