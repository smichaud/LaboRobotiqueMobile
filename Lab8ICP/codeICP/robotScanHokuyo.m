
global HOKUYO_RANGE_MIN
global HOKUYO_RANGE_MAX
global NewScan

% recupere scan
[ranges, ~, extra] = ros4mat('hokuyo');

if isempty(ranges)
    disp('Attention: scan Hokuyo vide!')
end

% conversition des donnees du scan en double
ranges = double(ranges);

angle_min = extra(1);
angle_max = extra(2);
range_min = extra(4);
range_max = extra(5);

% angles correspondant aux donnees
angles = linspace(angle_min, angle_max, length(ranges))';
    
% elimine les donnees "out-of-range"
outOfRangeIndices = find(ranges < HOKUYO_RANGE_MIN | ranges > HOKUYO_RANGE_MAX);
ranges(outOfRangeIndices) = [];
angles(outOfRangeIndices) = [];


[X,Y] = pol2cart(angles, ranges);
NewScan = [X Y]';
