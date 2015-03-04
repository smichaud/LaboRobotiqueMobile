function hex = IntToHex(input)
    if ( (input>(2^15-1)) && (input<(-(2^15))) )
        hex = [0 0];
    end
    
    if (input < 0)
        input = 2^16+input;
    end
        
    hex(2) = mod(input,256);
    hex(1) = round((input-hex(2))./256);
end
