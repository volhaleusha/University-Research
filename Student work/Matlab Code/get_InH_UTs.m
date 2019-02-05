function [x,y] = get_InH_UTs(n, centerX, centerY)
    x2 = 60;
    y2 = 0;
    % Produce 2*n random values, we later need to remove the ones with 
    % d < 3
    x = (60 * rand(4*n,1)) - 30;
    y = (50 * rand(4*n,1)) - 25;
    x = x + centerX;
    y = y + centerY;
    
    % Calculate distance and remove nodes with d < 3
    d = sqrt((x - centerX).^2 + (y - centerY).^2);
    out1 = d < 3;
    x = x(~out1); 
    y = y(~out1);
    
    % Only return n positions
    x = x(1:n);
    y = y(1:n);