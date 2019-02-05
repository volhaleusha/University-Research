function      r_common = get_rateShannon_multiBS_common_3FAPs(r_fap, nodes)
    for i = 1:nodes
        for j = 1:nodes
            for k = 1:nodes

   r_commons =  r_fap(i,j,k,1)+r_fap(j,i,k,2)+r_fap(k,i,j,3);
   r_common(k,i,j)=r_commons;

            end
        end
    end
    