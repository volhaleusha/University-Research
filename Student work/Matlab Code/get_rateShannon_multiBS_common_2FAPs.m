function      r_common = get_rateShannon_multiBS_common_2FAPs(r_fap, nodes)

    for i = 1:nodes
        for j = 1:nodes  
            
    r_commons =  r_fap(i,j,1)+r_fap(j,i,2);
    r_common(i,j)=r_commons;
        end
    end 