function  common = get_common_multiBS_4FAPs(fap, nodes)

   for i = 1:nodes
        for j = 1:nodes
            for k = 1:nodes
                for n = 1:nodes
                     
   commons =  fap(i,j,k,n,1)+fap(j,i,k,n,2)+fap(k,i,j,n,3)+fap(n,i,j,k,4);
   common(i,j,k,n)=commons;
                       
                 end
            end
        end
    end 