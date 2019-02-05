function [opt] = get_entries_max_regret_multiBS_3FAPs(fap, common)

T=common;
l = size(T,1);
opt = zeros(1, 3 * l);
max_value = zeros(1,l);
maxregg = zeros(1,l);
indexx = zeros(1,l);
indeyy = zeros(1,l);
maximum_value = zeros(1,l);
        
for j=1:l
   reg_raw = zeros(1, l);
       reg_column = zeros(1, l);
       index1 = zeros(1, l);
       indey1 = zeros(1, l);
       index2 = zeros(1, l);
       indey2 = zeros(1, l);   
       
       
  for k = 1:l 
      for i=1:l
              
         T1 = T;
         T2 = T;
         
         % Fix one index position (z in this case) and find first maximum 
         % with one fixed and one varying other positions 

         [ca indy1]= max(T1(i,:,k));
         [cd indx1]= max(T2(:,i,k));
         % cover row and column containing firts maximum
         T1(i,indy1,k)=-1000;
         T2(indx1,i,k)=-1000;
         % Fix one index position (z in this case) and find second maximum 
         % with one fixed and one varying other positions 
         [cb indy2]= max(T1(i,:,k));
         [ce indx2]= max(T2(:,i,k));
        % calculate regrets  
        reg_raw_1(i,k)=ca-cb;
        reg_column_1(i,k)=cd-ce;
        
      end
    end
         % as we fixed constantly z position here, find maximum regret of
         % all local regrets for this fixed z position
        [maxreg_z indz]=max(max(max(reg_raw_1,reg_column_1)));

   % repeat the same for all other fixed index positions
    for k=1:l   
        for i=1:l
             
         T1 = T;
         T2 = T;
         [ca indz1]= max(T1(i,k,:));
         [cd indx1]= max(T2(:,k,i));
         
         T1(i,k,indz1)=-1000;
         T2(indx1,k,i)=-1000;
         
         [cb indz2]= max(T1(i,k,:));
         [ce indx2]= max(T2(:,k,i));
         
        reg_raw_2(i,k)=ca-cb;
        reg_z_2(i,k)=cd-ce;

        end  
      end
         
        [maxreg_column indy]=max(max(max(reg_raw_2,reg_z_2)));
        
      for k=1:l  
       for i=1:l
             
         T1 = T;
         T2 = T;
         [ca indz1]= max(T1(k,i,:));
         [cd indy1]= max(T2(k,:,i));
         
         T1(k,indy1,i)=-1000;
         T2(k,i,indz1)=-1000;
         
         [cb indz2]= max(T1(k,i,:));
         [ce indy2]= max(T2(k,:,i));
         
        reg_column_3(i,k)=ca-cb;
        reg_z_3(i,k)=cd-ce;
        
       end 
      end
         
        [maxreg_raw indx]=max(max(max(reg_column_3, reg_z_3)));
 
        % if maximum regret of one fixed position is higher than for other
        % fixed positions- find a maximum value in input matrix from entries that has
        % same index position as this regret
        if (maxreg_raw>=maxreg_column) & (maxreg_raw>=maxreg_z)
            
           [max_value indz]=max(max(T(indx,:,:)));
           [max_value indy]= max(T(indx,:,indz)); 
            maxreg=maxreg_raw;

        elseif (maxreg_column>maxreg_raw)& (maxreg_column>=maxreg_z)
            
            [max_value indz]=max(max(T(:,indy,:)));
            [max_value indx]= max(T(:,indy,indz)); 
            maxreg=maxreg_column;
            
        elseif  (maxreg_z>maxreg_raw)& (maxreg_z>maxreg_column)
            
            [max_value indy]=max(max(T(:,:,indz)));
            [max_value indx]= max(T(:,indy,indz)); 
            maxreg=maxreg_column;
            
            
        elseif  (maxreg_raw == maxreg_column)& (maxreg_raw>maxreg_z)   
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1)); 
                [max_valuee2 indz_max_valuee2]=max(max(T(:,indy,:)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy,indz_max_valuee2)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg1 = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg1 = maxreg_column; 
                   indx = indx_max_valuee2;
                   indz =indz_max_valuee2;
                end             
        elseif  (maxreg_raw==maxreg_z)& (maxreg_raw>maxreg_column)   
                [max_valuee1 indz_max_valuee1]=max(max(T(indx,:,:)));
                [max_valuee1 indy_max_valuee1]= max(T(indx,:,indz_max_valuee1)); 
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz)));
                [max_valuee2indx_max_valuee2]= max(T(:,indy_max_valuee2,indz)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg1 = maxreg_raw;
                   indy = indy_max_valuee1;
                   indz =indz_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg1 = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                end             
        
        elseif  (maxreg_column==maxreg_z)& (maxreg_column>maxreg_raw)   
                [max_valuee1 indz_max_valuee1]=max(max(T(:,indy,:)));
                [max_valuee1 indx_max_valuee1]= max(T(:,indy,indz_max_valuee1)); 
                [max_valuee2 indy_max_valuee2]=max(max(T(:,:,indz)));
                [max_valuee2 indx_max_valuee2]= max(T(:,indy_max_valuee2,indz)); 
                
                if max_valuee1>=max_valuee2
                   max_value = max_valuee1;
                   maxreg1 = maxreg_raw;
                   indx = indx_max_valuee1;
                   indz =indz_max_valuee1;
                else 
                   max_value = max_valuee2;
                   maxreg1 = maxreg_column; 
                   indx = indx_max_valuee2;
                   indy =indy_max_valuee2;
                end             
                
                 
        else
                [max_value indz] = max(max(max(T)));
                [max_value indy] = max(max(T(:,:,indz)));
                [max_value indx] = max(T(:,indy,indz));  
                maxreg=maxreg_z;
      
        end
 
        % in other cases find maximum from the whole input set (Greedy)
        if maxreg==0
            
                [max_value indz] = max(max(max(T)));
                [max_value indy] = max(max(T(:,:,indz)));
                [max_value indx] = max(T(:,indy,indz));  
        end
         
         maximum_value(j)=max_value;

     % find values of input matrices of every BS separately    
    opt(j) = fap(indx, indy, indz, 1);
    opt(j + l) = fap(indy, indx, indz, 2);
    opt(j + 2*l) = fap(indz, indx, indy, 3);
   % cover index positions containing max value       
    T(indx,:,:) = -1000;
    T(:,indy,:) = -1000;
    T(:,:,indz) = -1000;

end