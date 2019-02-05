function      common = get_common_multiBS_2FAPs(fap, nodes)

    for i = 1:nodes
        for j = 1:nodes  
            
    commons =  fap(i,j,1)+fap(j,i,2);
    common(i,j)=commons;
        end
    end 