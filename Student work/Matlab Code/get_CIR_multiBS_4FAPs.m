  

function [CIR_fap CIR_common] = get_CIR_multiBS_4FAPs(pl, nodes)


        for j = 1:nodes
            for k = 1:nodes
                for n = 1:nodes
                    for i = 1:nodes
                        
            % first index shows the number of UT, second index shows to which BS UT belongs, last index shows for which BS SINR is calculated            
            CIR_fap1s = (10*log10(10^(0.1*pl(j,2,1))+10^(0.1*pl(k,3,1))+10^(0.1*pl(n,4,1))))-pl(i,1,1);         
            CIR_fap2s = (10*log10(10^(0.1*pl(j,1,2))+10^(0.1*pl(k,3,2))+10^(0.1*pl(n,4,2))))-pl(i,2,2);            
            CIR_fap3s = (10*log10(10^(0.1*pl(j,1,3))+10^(0.1*pl(k,2,3))+10^(0.1*pl(n,4,3))))-pl(i,3,3);           
            CIR_fap4s = (10*log10(10^(0.1*pl(j,1,4))+10^(0.1*pl(k,2,4))+10^(0.1*pl(n,3,4))))-pl(i,4,4);
            
             CIR_fap(i,j,k,n,1) = CIR_fap1s;
             CIR_fap(i,j,k,n,2) = CIR_fap2s;
             CIR_fap(i,j,k,n,3) = CIR_fap3s;
             CIR_fap(i,j,k,n,4) = CIR_fap4s;
                       
                 end
            end
        end
    end

        for j = 1:nodes
            for k = 1:nodes
                for n = 1:nodes
                        for i = 1:nodes
   
   %find common SINR                          
   CIR_commons =  CIR_fap(i,j,k,n,1)+CIR_fap(j,i,k,n,2)+CIR_fap(k,i,j,n,3)+CIR_fap(n,i,j,k,4);
   CIR_common(i,j,k,n)=CIR_commons;
                       
                 end
            end
        end
    end 
end  