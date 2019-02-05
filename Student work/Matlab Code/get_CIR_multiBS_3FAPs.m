
function [CIR_fap CIR_common] = get_CIR_multiBS_3FAPs(pl, nodes)


    for k = 1:nodes 
        for j = 1:nodes 
            for i = 1:nodes
        
        % first index shows the number of UT, second index shows to which BS UT belongs, last index shows for which BS SINR is calculated        
        CIR_fap1s = (10*log10(10^(0.1*pl(j,2,1))+10^(0.1*pl(k,3,1))))-pl(i,1,1);
        CIR_fap2s = (10*log10(10^(0.1*pl(j,1,2))+10^(0.1*pl(k,3,2))))-pl(i,2,2);
        CIR_fap3s = (10*log10(10^(0.1*pl(j,1,3))+10^(0.1*pl(k,2,3))))-pl(i,3,3);
        
             CIR_fap(i,j,k,1) = CIR_fap1s;
             CIR_fap(i,j,k,2) = CIR_fap2s;
             CIR_fap(i,j,k,3) = CIR_fap3s;

            end
        end
    end

    for k = 1:nodes
        for j = 1:nodes
            for i = 1:nodes

   %find common SINR               
   CIR_commons =  CIR_fap(i,j,k,1)+CIR_fap(j,i,k,2)+CIR_fap(k,i,j,3);
   CIR_common(i,j,k)=CIR_commons;

            end
        end
    end
end