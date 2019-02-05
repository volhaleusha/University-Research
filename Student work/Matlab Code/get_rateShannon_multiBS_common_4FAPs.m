function      r_common = get_rateShannon_multiBS_common_4FAPs(r_fap, nodes)

   for i = 1:nodes
        for j = 1:nodes
            for k = 1:nodes
                for n = 1:nodes
                    
   r_commons =  r_fap(n,i,j,k,1)+r_fap(i,n,j,k,2)+r_fap(i,j,n,k,3)+r_fap(i,j,k,n,4);
   r_common(n,i,j,k)=r_commons;
                       
                 end
            end
        end
    end 