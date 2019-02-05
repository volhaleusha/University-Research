function [x,y] = get_InH_UTs_multiBS(n, xfap, yfap, rcell, faps)
    
    %Create matrix m size #UT*#BS filled with random numbers from -1 to 1 
    %right method
    for i= 1:faps
    for j=1:n

    r(j,i) = rcell*sqrt(rand(1,1));
    theta(j,i)=2*pi*rand(1,1);

    x(j,i)=r(j,i)*cos(theta(j,i))+xfap(i);
    y(j,i)=r(j,i)*sin(theta(j,i))+yfap(i);
        
    end
    end
        
  
    
 
% %     m = sqrt(rand(4*n,faps));
% % %     m = m.*2;
% % %     m = m-1
% %    
% %     for i= 1:faps
% %     xy = rcell*m(:,i);
% %     
% %     xi = xy*cos(2*pi*rand(1,1)) + xfap(i);
% %     yi = xy*sin(2*pi*rand(1,1)) + yfap(i);
%   
%     % Calculate distance and remove nodes with d < 3
% %     d = sqrt((xi(j,i)- xfap(i)).^2 + (yi(j,i) - yfap(i)).^2);
% %     out1 = d < 3;
% %     xi = xi(~out1); 
% %     yi = yi(~out1);
%     
%     
%     
%     
%     % Only return n positions
%     xi = xi(1:n);
%     yi = yi(1:n);
%     
%     % Set coordinates of UTs belonging to BS with index i as a column i of
%     % matrix with all the UTs coordinates 
    
%     x(:,i)=xi;
%     y(:,i)=yi;
%     end
%    end
   