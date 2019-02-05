function [distance]= get_distance_multiBS(x, y, xfap, yfap,faps);


for i=1:faps
    for j= 1:faps
           xi= x(:,i);
           yi= y(:,i);
           di = sqrt((xi- xfap(j)).^2 + (yi- yfap(j)).^2); 
          distance(:,i,j) = di;
    end   
end
