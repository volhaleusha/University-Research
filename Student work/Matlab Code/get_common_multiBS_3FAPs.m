function      common = get_common_multiBS_3FAPs(fap, nodes)
    for i = 1:nodes
        for j = 1:nodes
            for k = 1:nodes

   commons =  fap(i,j,k,1)+fap(j,i,k,2)+fap(k,i,j,3);
   common(i,j,k)=commons;

            end
        end
    end
    