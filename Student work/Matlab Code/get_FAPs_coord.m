
 % rcell- cell radius, rinter- intercell distance, n- number of FAPS = faps
function [xfap,yfap] = get_FAPs_coord (n, rc, rint); 
    
    ri= (2*rc+rint)/2;
    a= 2*pi/n;
    % r- radius of circle in which faps are placed
    
    r= sqrt((2*(ri^2))/(1-cos(a)));
  
    % x, y -coordinates for each FAP
    
    for i=1:n
    xfap(i) = r*cos(2*pi*i/n);
    yfap(i) = r*sin(2*pi*i/n);
 
    end