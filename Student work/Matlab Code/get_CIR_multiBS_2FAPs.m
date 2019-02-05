
function [CIR_fap CIR_common] = get_CIR_multiBS_2FAPs(pl, nodes)

 
for i = 1:nodes
        for j = 1:nodes
        
        % first index shows the number of UT, second index shows to which BS UT belongs, last index shows for which BS SINR is calculated    
        CIR_fap1s = pl(j,2,1)-pl(i,1,1);
        CIR_fap2s = pl(j,1,2)-pl(i,2,2);

        CIR_fap(i,j,1) = CIR_fap1s;
        CIR_fap(i,j,2) = CIR_fap2s; 
             
        end
    end  
    for i = 1:nodes
        for j = 1:nodes  
     
    %find common SINR for both BSs        
    CIR_commons =  CIR_fap(i,j,1)+CIR_fap(j,i,2);
    CIR_common(i,j)=CIR_commons;
        end
    end 
end