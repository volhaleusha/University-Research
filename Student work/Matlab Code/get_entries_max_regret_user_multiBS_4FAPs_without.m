function [opt] = get_entries_max_regret_user_multiBS_4FAPs(fap, common)

T=common;
l = size(T,1);
opt = zeros(1, 4 * l);
max_value = zeros(1, l);

for j=1:l
    
reg_raw = zeros(1, l);
reg_column = zeros(1, l);
reg_t = zeros(1, l);
      for i=1:l
                 
         T1 = T;
         T2 = T;
         T3 = T;
         T4 = T;
         
         [ca indt1]= max(max(max(T1(i,:,:,:))));
         [ca indz1]= max(max(T1(i,:,:,indt1)));
         [ca indy1]= max(max(T1(i,:,indz1,indt1)));
         
         [cd indt2]= max(max(max(T2(:,i,:,:))));
         [cd indz2]= max(max(T2(:,i,:,indt2)));
         [cd indx2]= max(max(T2(:,i,indz2,indt2)));
       
         [cf indt3]= max(max(max(T3(:,:,i,:))));
         [cf indy3]= max(max(T3(:,:,i,indt3)));
         [cf indx3]= max(max(T3(:,indy3,i,indt3)));
         
         [ch indz4]= max(max(max(T4(:,:,:,i))));
         [ch indy4]= max(max(T4(:,:,indz4,i)));
         [ch indx4]= max(max(T4(:,indy4,indz4,i)));
         
         T1(i,indy1,indz1,indt1)=-1000;
         T2(indx2,i,indz2,indt2)=-1000;
         T3(indx3,indy3,i,indt3)=-1000; 
         T4(indx3,indy3,indz4,i)=-1000; 
         
         [cb indt1]= max(max(max(T1(i,:,:,:))));
         [cb indz1]= max(max(T1(i,:,:,indt1)));
         [cb indy1]= max(max(T1(i,:,indz1,indt1)));
         
         [ce indt2]= max(max(max(T2(:,i,:,:))));
         [ce indz2]= max(max(T2(:,i,:,indt2)));
         [ce indx2]= max(max(T2(:,i,indz2,indt2)));
       
         [cg indt3]= max(max(max(T3(:,:,i,:))));
         [cg indy3]= max(max(T3(:,:,i,indt3)));
         [cg indx3]= max(max(T3(:,indy3,i,indt3)));
         
         [ci indz4]= max(max(max(T4(:,:,:,i))));
         [ci indy4]= max(max(T4(:,:,indz4,i)));
         [ci indx4]= max(max(T4(:,indy4,indz4,i)));

         
        reg_raw(i)=ca-cb;
        reg_column(i)=cd-ce;
        reg_z(i)=cf-cg;
        reg_t(i)=ch-ci;
        
   end
         
        [maxreg_raw indx]=max(reg_raw);
        [maxreg_column indy]=max(reg_column);
        [maxreg_z indz]=max(reg_z);
        [maxreg_t indt]=max(reg_t);
        
        if (maxreg_raw>maxreg_column) & (maxreg_raw>maxreg_z)&(maxreg_raw>maxreg_t)
            
           [max_value indt]=max(max(max(T(indx,:,:,:))));
           [max_value indy]= max(max(T(indx,:,:,indt))); 
           [max_value indy]= max(T(indx,:,indz,indt)); 
            maxreg=maxreg_raw;

        elseif (maxreg_column>maxreg_raw)& (maxreg_column>maxreg_z)&(maxreg_column>maxreg_t)
            
            [max_value indt]=max(max(max(T(:,indy,:,:))));
            [max_value indz]=max(max(T(:,indy,:,indt)));
            [max_value indx]= max(T(:,indy,indz,indt)); 
            maxreg=maxreg_column;
          
        elseif (maxreg_z>maxreg_raw)& (maxreg_z>maxreg_column)&(maxreg_z>maxreg_t)
            
            [max_value indt]=max(max(max(T(:,:,indz,:))));
            [max_value indy]=max(max(T(:,:,indz,indt)));
            [max_value indx]= max(T(:,indy,indz,indt)); 
             maxreg=maxreg_z;
             
        elseif (maxreg_t>maxreg_raw)& (maxreg_t>maxreg_column)&(maxreg_t>maxreg_z)  
            
            [max_value indz]=max(max(max(T(:,:,:,indt))));
            [max_value indy]=max(max(T(:,:,indz,indt)));
            [max_value indx]= max(T(:,indy,indz,indt)); 
             maxreg=maxreg_t;    
             
        elseif (maxreg_raw==maxreg_column) & (maxreg_raw>maxreg_z)&(maxreg_raw>maxreg_t)
            
                [max_valuee1 indt_max_valuee1]=max(max(max(T(indx,:,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:,indt_max_valuee1)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,indy,:,:))));
                [max_valuee2 indz_max_valuee2]=max(max(T(:,indy,:,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy,indz_max_valuee2,indt_max_valuee2)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indz =indz_max_valuee2;
                   indt =indt_max_valuee2;
                end
        
     
           elseif (maxreg_raw>maxreg_column) & (maxreg_raw==maxreg_z)&(maxreg_raw>maxreg_t)
            
                [max_valuee1 indt_max_valuee1]=max(max(max(T(indx,:,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:,indt_max_valuee1)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,:,indz,:))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz,indt_max_valuee2)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indt =indt_max_valuee2;
                end           
             
           elseif (maxreg_raw>maxreg_column) & (maxreg_raw>maxreg_z)&(maxreg_raw==maxreg_t)
            
                [max_valuee1 indt_max_valuee1]=max(max(max(T(indx,:,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:,indt_max_valuee1)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indz_max_valuee2]=max(max(max(T(:,:,:,indt))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz_max_valuee2,indt)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz_max_valuee2,indt)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indz =indz_max_valuee2;
                end   
                
       elseif (maxreg_column>maxreg_raw)& (maxreg_column==maxreg_z)&(maxreg_column>maxreg_t)
           
                [max_valuee1 indt_max_valuee1]=max(max(max(T(:,indy,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(:,indy,:,indt_max_valuee1)));
                [max_valuee1 indx_max_valuee1]= max(T(:,indy,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,:,indz,:))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz,indt_max_valuee2)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indt =indt_max_valuee2;
                end      
                
        elseif (maxreg_column>maxreg_raw)& (maxreg_column>maxreg_z)&(maxreg_column==maxreg_t)
           
                [max_valuee1 indt_max_valuee1]=max(max(max(T(:,indy,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(:,indy,:,indt_max_valuee1)));
                [max_valuee1 indx_max_valuee1]= max(T(:,indy,indz_max_valuee1,indt_max_valuee1));                
                [max_valuee2 indz_max_valuee2]=max(max(max(T(:,:,:,indt))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz_max_valuee2,indt)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz_max_valuee2,indt)); 
             if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
             else     
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indz =indz_max_valuee2;
             end
                
         elseif (maxreg_z>maxreg_raw)& (maxreg_z>maxreg_column)&(maxreg_z==maxreg_t) 
             
                [max_valuee1 indt_max_valuee1]=max(max(max(T(:,:,indz,:))));
                [max_valuee1 indy_max_valuee1]=max(max(T(:,:,indz,indt_max_valuee1)));
                [max_valuee1 indx_max_valuee1]= max(T(:,indy_max_valuee1,indz,indt_max_valuee1));                
                [max_valuee2 indz_max_valuee2]=max(max(max(T(:,:,:,indt))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz_max_valuee2,indt)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz_max_valuee2,indt)); 
                
             if max_valuee1>= max_valuee2
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee1;
                   indy =indy_max_valuee1;
                   indt =indt_max_valuee1;
             else     
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indz =indz_max_valuee2;
             end     

        elseif (maxreg_raw==maxreg_column) & (maxreg_raw==maxreg_z)&(maxreg_raw>maxreg_t)
            
                [max_valuee1 indt_max_valuee1]=max(max(max(T(indx,:,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:,indt_max_valuee1)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,indy,:,:))));
                [max_valuee2 indz_max_valuee2]=max(max(T(:,indy,:,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy,indz_max_valuee2,indt_max_valuee2));
                [max_valuee3 indt_max_valuee3]=max(max(max(T(:,:,indz,:))));
                [max_valuee3 indy_max_valuee3]=max(max(T(:,:,indz,indt_max_valuee3)));
                [max_valuee3 indx_max_valuee3]= max(T(:,indy_max_valuee3,indz,indt_max_valuee3)); 
                
                if (max_valuee1>=max_valuee2)&(max_valuee1>=max_valuee3)
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                elseif (max_valuee2>max_valuee1)&(max_valuee2>max_valuee3) 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indz =indz_max_valuee2;
                   indt =indt_max_valuee2;
                   
                else 
                   max_value = max_valuee3;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee3;
                   indy =indy_max_valuee3;
                   indt =indt_max_valuee3;      
                end             
         elseif (maxreg_raw==maxreg_column) & (maxreg_raw>maxreg_z)&(maxreg_raw==maxreg_t)
            
                [max_valuee1 indt_max_valuee1]=max(max(max(T(indx,:,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:,indt_max_valuee1)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,indy,:,:))));
                [max_valuee2 indz_max_valuee2]=max(max(T(:,indy,:,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy,indz_max_valuee2,indt_max_valuee2));
                [max_valuee3 indz_max_valuee3]=max(max(max(T(:,:,:,indt))));
                [max_valuee3 indy_max_valuee3]=max(max(T(:,:,indz_max_valuee3,indt)));
                [max_valuee3 indx_max_valuee3]= max(T(:,indy_max_valuee3,indz_max_valuee3,indt)); 
                
                if (max_valuee1>=max_valuee2)&(max_valuee1>=max_valuee3)
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                elseif (max_valuee2>max_valuee1)&(max_valuee2>max_valuee3) 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indz =indz_max_valuee2;
                   indt =indt_max_valuee2;
                   
                else 
                   max_value = max_valuee3;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee3;
                   indy =indy_max_valuee3;
                   indz =indz_max_valuee3;      
                end 
                
                
         elseif (maxreg_raw>maxreg_column) & (maxreg_raw==maxreg_z)&(maxreg_raw==maxreg_t)
            
                [max_valuee1 indt_max_valuee1]=max(max(max(T(indx,:,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:,indt_max_valuee1)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,:,indz,:))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz,indt_max_valuee2)); 
                [max_valuee3 indz_max_valuee3]=max(max(max(T(:,:,:,indt))));
                [max_valuee3 indy_max_valuee3]=max(max(T(:,:,indz_max_valuee3,indt)));
                [max_valuee3 indx_max_valuee3]= max(T(:,indy_max_valuee3,indz_max_valuee3,indt)); 
                
                if (max_valuee1>=max_valuee2)&(max_valuee1>=max_valuee3)
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                elseif (max_valuee2>max_valuee1)&(max_valuee2>max_valuee3) 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indt =indt_max_valuee2;
                   
                else 
                   max_value = max_valuee3;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee3;
                   indy =indy_max_valuee3;
                   indz =indz_max_valuee3;      
                end  
                
        elseif (maxreg_column>maxreg_raw)& (maxreg_column==maxreg_z)&(maxreg_column==maxreg_t)                
              
                [max_valuee1 indt_max_valuee1]=max(max(max(T(:,indy,:,:))));
                [max_valuee1 indz_max_valuee1]=max(max(T(:,indy,:,indt_max_valuee1)));
                [max_valuee1 indx_max_valuee1]= max(T(:,indy,indz_max_valuee1,indt_max_valuee1)); 
                [max_valuee2 indt_max_valuee2]=max(max(max(T(:,:,indz,:))));
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz,indt_max_valuee2)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz,indt_max_valuee2));
                [max_valuee3 indz_max_valuee3]=max(max(max(T(:,:,:,indt))));
                [max_valuee3 indy_max_valuee3]=max(max(T(:,:,indz_max_valuee3,indt)));
                [max_valuee3 indx_max_valuee3]= max(T(:,indy_max_valuee3,indz_max_valuee3,indt)); 
                
                if (max_valuee1>=max_valuee2)&(max_valuee1>=max_valuee3)
                   max_value = max_valuee1;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee1;
                   indz =indz_max_valuee1;
                   indt =indt_max_valuee1;
                elseif (max_valuee2>max_valuee1)&(max_valuee2>max_valuee3) 
                   max_value = max_valuee2;
                   maxreg = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                   indt =indt_max_valuee2;
                   
                else 
                   max_value = max_valuee3;
                   maxreg = maxreg_raw;
                   indx = indx_max_valuee3;
                   indy =indy_max_valuee3;
                   indz =indz_max_valuee3;      
                end           
%             
%                 
        else  
            [max_value indt]=max(max(max(max(T))));            
            [max_value indz]=max(max(max(T(:,:,:,indt))));
            [max_value indy]=max(max(T(:,:,indz,indt)));
            [max_value indx]= max(T(:,indy,indz,indt)); 
             maxreg=maxreg_t;          
        end        
               
        if maxreg ==0 
            
                [max_value indt] = max(max(max(max(T))));
                [max_value indz] = max(max(max(T(:,:,:,indt))));
                [max_value indy] = max(max(T(:,:,indz,indt)));
                [max_value indx] = max(T(:,indy,indz,indt));  
         end
         maximum_value(j)=max_value;

         
    opt(j) = fap(indx, indy, indz,indt, 1);
    opt(j + l) = fap(indy, indx, indz,indt, 2);
    opt(j + 2*l) = fap(indz, indx, indy,indt, 3);
    opt(j + 3*l) = fap(indt, indx, indy,indz, 4);
    
    
    T(indx,:,:,:) = -1000;
    T(:,indy,:,:) = -1000;
    T(:,:,indz,:) = -1000;
    T(:,:,:,indt) = -1000;
end         
         
         
