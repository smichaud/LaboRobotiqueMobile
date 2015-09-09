function distances = irOutput2Distance(range, ir_output, removeOutOfRange)

IR_SHORT_MIN_RANGE = 6;
IR_SHORT_MAX_RANGE = 80;
IR_LONG_MIN_RANGE = 15;
IR_LONG_MAX_RANGE = 150;

IR_SHORT_LOOKUP_TABLE = [6 5;
                         6 3.14;
                         7 2.98;
                         8 2.74;
                         10 2.31;
                         15 1.65;
                         20 1.31;
                         25 1.08;
                         30 0.92;
                         40 0.73;
                         50 0.60;
                         60 0.50;
                         70 0.44;
                         80 0.39;
                         80 0];

IR_LONG_LOOKUP_TABLE = [15 5;
                        15 2.76;
                        20 2.53;
                        30 1.99;
                        40 1.53;
                        50 1.23;
                        60 1.04;
                        70 0.91;
                        80 0.82;
                        90 0.72;
                        100 0.66;
                        110 0.6;
                        120 0.55;
                        130 0.50;
                        140 0.46;
                        150 0.435;
                        150 0];

if strcmp(range, 'short')
    lookup_table = IR_SHORT_LOOKUP_TABLE;
    min_range = IR_SHORT_MIN_RANGE;
    max_range = IR_SHORT_MAX_RANGE;
elseif strcmp(range, 'long')
    lookup_table = IR_LONG_LOOKUP_TABLE;
    min_range = IR_LONG_MIN_RANGE;
    max_range = IR_LONG_MAX_RANGE;
end

x = lookup_table(:,1);
y = lookup_table(:,2);
distances = interp1(y,x,ir_output);

if removeOutOfRange
    distances(distances <= min_range) = [];
    distances(distances >= max_range) = [];
end

end
