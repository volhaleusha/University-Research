function [opt] = get_entries_max_regret_multiBS_4FAPs(fap, common)
% see comments to the code of function
% get_entries_max_regret_multiBS_3FAPs --> has the same principles
T=common;
l = size(T,1);
opt = zeros(1, 4 * l);
max_value = zeros(1, l);
maxregg = zeros(1, l);
indexx = zeros(1, l);
indeyy = zeros(1, l);
        
for j=1:l
     % fixed last position 
    
    for k = 1:l 
     for n= 1:l
       for i=1:l
             
         T1 = T;
         T2 = T;
         T3 = T;
         [ca indy1]= max(T1(i,:,n,k));
         [cd indx1]= max(T2(:,n,i,k));
         [cc indz1]= max(T3(n,i,:,k));
         
         T1(i,indy1,n,k)=-1000;
         T2(indx1,n,i,k)=-1000;
         T3(n,i,indz1,k)=-1000;
         
         [cb indx2]= max(T1(i,:,n,k));
         [ce indy2]= max(T2(:,n,i,k));
         [cf indz2]= max(T3(n,i,:,k));
         
        reg_raw_1(i,n,k)=ca-cb;
        reg_z_1(i,n,k)=cd-ce;
        reg_column_1(i,n,k)=cc-cf;

      end
     end
    end
      
   [maxreg_t_raw indt_raw] = max(max(max(reg_raw_1)));
   [maxreg_t_z indt_z] = max(max(max(reg_z_1)));
   [maxreg_t_column indt_column] = max(max(max(reg_column_1)));
   
   maxreg_t = maxreg_t_raw;
   indt = indt_raw;
   if maxreg_t_z > maxreg_t
       maxreg_t = maxreg_t_z;
       indt = indt_z;
   elseif maxreg_t_column > maxreg_t
       maxreg_t = maxreg_t_column;
       indt = indt_column;
   end
    
%    [maxreg_t indt]=max(max(max(max(reg_raw_1,reg_z_1))));
%    reg_column_1 = max(max(max(reg_column_1)));
%    [maxreg_t indt]=max(max(maxreg_t,reg_column_1));  
    
       % fixed third position
    for k = 1:l 
      for n= 1:l     
       for i=1:l
             
         T1 = T;
         T2 = T;
         T3 = T;
         [ca indy1]= max(T1(i,:,k,n));
         [cd indx1]= max(T2(:,n,k,i));
         [cc indt1]= max(T3(n,i,k,:));
         
         T1(i,indy1,k,n)=-1000;
         T2(indx1,n,k,i)=-1000;
         T3(n,i,k,indt1)=-1000;
         
         [cb indx2]= max(T1(i,:,k,n));
         [ce indy2]= max(T2(:,n,k,i));
         [cf indt2]= max(T3(n,i,k,:));
         
        reg_raw_2(i,n,k)=ca-cb;
        reg_t_2(i,n,k)=cd-ce;
        reg_column_2(i,n,k)=cc-cf;

       end
      end
    end
    
    [maxreg_z_raw indz_raw] = max(max(max(reg_raw_2)));
   [maxreg_z_t indz_t] = max(max(max(reg_t_2)));
   [maxreg_z_column indz_column] = max(max(max(reg_column_2)));
   
   maxreg_z = maxreg_z_raw;
   indz = indz_raw;
   if maxreg_z_t > maxreg_t
       maxreg_z = maxreg_z_t;
       indz = indz_z;
   elseif maxreg_z_column > maxreg_z
       maxreg_z = maxreg_z_column;
       indz = indz_column;
   end   
       
    
%    [maxreg_z indz]=max(max(max(max(reg_raw_2,reg_t_2))));
%     reg_column_2 = max(max(max(reg_column_2)));
%    [maxreg_z indz]=max(max(maxreg_z,reg_column_2));  
   
              
       % fixed second position
  for k = 1:l 
       for n= 1:l              
         for i=1:l
       
         T1 = T;
         T2 = T;
         T3 = T;
         [ca indz1]= max(T1(i,k,:,n));
         [cd indx1]= max(T2(:,k,n,i));
         [cc indt1]= max(T3(n,k,i,:));
         
         T1(i,k,indz1,n)=-1000;
         T2(indx1,k,n,i)=-1000;
         T3(n,k,i,indt1)=-1000;
         
         [cb indz2]= max(T1(i,k,:,n));
         [ce indx2]= max(T2(:,k,n,i));
         [cf indt2]= max(T3(n,k,i,:));
         
        reg_raw_3(i,n,k)=ca-cb;
        reg_t_3(i,n,k)=cd-ce;
        reg_z_3(i,n,k)=cc-cf;
        
         end
      end
  end
    
   [maxreg_y_raw indy_raw] = max(max(max(reg_raw_3)));
   [maxreg_y_z indy_z] = max(max(max(reg_z_3)));
   [maxreg_y_t indy_t] = max(max(max(reg_t_3)));
   
   maxreg_column = maxreg_y_raw;
   indy = indy_raw;
   if maxreg_y_z > maxreg_column
      maxreg_column = maxreg_y_z;
       indy = indy_z;
   elseif maxreg_y_t > maxreg_column
       maxreg_y = maxreg_y_t;
       indy = indy_t;
   end    
  
    
%     [maxreg_column indy]=max(max(max(max(reg_raw_3,reg_t_3))));
%     reg_z_3 = max(max(max(reg_z_3)));
%    [maxreg_column indy]=max(max(maxreg_column,reg_z_3));  
              
      % fixed first position
  for k = 1:l 
    for n= 1:l           
         for i=1:l
            
         T1 = T;
         T2 = T;
         T3 = T;
         [ca indz1]= max(T1(k,i,:,n));
         [cd indy1]= max(T2(k,:,n,i));
         [cc indt1]= max(T3(k,n,i,:));
         
         T1(k,i,indz1,n)=-1000;
         T2(k,indy1,n,i)=-1000;
         T3(k,n,i,indt1)=-1000;
         
         [cb indz2]= max(T1(k,i,:,n));
         [ce indy2]= max(T2(k,:,n,i));
         [cf indt2]= max(T3(k,n,i,:));
         
        reg_column_4(i,n,k)=ca-cb;
        reg_t_4(i,n,k)=cd-ce;
        reg_z_4(i,n,k)=cc-cf;

        end
    end
  end

  
   [maxreg_x_column indx_column] = max(max(max(reg_column_4)));
   [maxreg_x_z indx_z] = max(max(max(reg_z_4)));
   [maxreg_x_t indx_t] = max(max(max(reg_t_4)));
   
   maxreg_raw = maxreg_x_column;
   indx = indx_column;
   if maxreg_x_z > maxreg_raw
       maxreg_raw = maxreg_x_z;
       indx = indx_z;
   elseif maxreg_x_t > maxreg_raw
       maxreg_raw = maxreg_x_t;
       indx = indx_t;
   end 
% [maxreg_raw indx]=max(max(max(max(reg_column_4,reg_t_4))));
% reg_z_4 = max(max(max(reg_z_4)));
% [maxreg_raw indx]=max(max(maxreg_raw,reg_z_4));  
%        

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
         
         