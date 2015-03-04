function drawCloud(pointCloud, rgbImage)
    pointsSize = 2;
    samplingConst = 5;
    
    subsampledCloud = pointCloud(1:samplingConst:end,1:samplingConst:end,:);
    subsampledRGB = rgbImage(1:samplingConst:end,1:samplingConst:end,:);
    
    xMatrix = subsampledCloud(:,:,1);
    xVector = xMatrix(:);
    yMatrix = subsampledCloud(:,:,2);
    yVector = yMatrix(:);
    zMatrix = subsampledCloud(:,:,3);
    zVector = zMatrix(:);

    rMatrix = subsampledRGB(:,:,1);
    rVector = rMatrix(:)./255;
    gMatrix = subsampledRGB(:,:,2);
    gVector = gMatrix(:)./255;
    bMatrix = subsampledRGB(:,:,3);
    bVector = bMatrix(:)./255;

    scatter3(xVector, yVector, zVector, pointsSize, [rVector gVector bVector], 'filled');
    daspect([1 1 1]);