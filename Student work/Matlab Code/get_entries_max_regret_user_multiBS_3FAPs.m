function [opt] = get_entries_max_regret_user_multiBS_3FAPs(fap, common)

T=common;
l = size(T,1);
opt = zeros(1, 3 * l);
max_value = zeros(1, l);

for j=1:l
    
reg_raw = zeros(1, l);
reg_column = zeros(1, l);
reg_t = zeros(1, l);
      for i=1:l
             
         T1 = T;
         T2 = T;
         T3 = T;
        % find first maximum for 1 fixed and other varying index position 
         [ca indz1]= max(max(T1(i,:,:)));
         [ca indy1]= max(T1(i,:,indz1));
         
         [cd indz2]= max(max(T2(:,i,:))); 
         [cd indx2]= max(T2(:,i,indz2)); 
       
         [cf indy3]= max(max(T3(:,:,i))); 
         [cf indx3]= max(T3(:,indy3,i)); 
         
         % cover row and column containing firts maximum
         T1(i,indy1,indz1)=-1000;
         T2(indx2,i,indz2)=-1000;
         T3(indx3,indy3,i)=-1000; 
         % find second maximum for 1 fixed and other varying index position 
         [cb indz1]= max(max(T1(i,:,:)));
         [cb indy1]= max(T1(i,:,indz1));
         
         [ce indz2]= max(max(T2(:,i,:))); 
         [ce indx2]= max(T2(:,i,indz2)); 
       
         [cg indy3]= max(max(T3(:,:,i))); 
         [cg indx3]= max(T3(:,indy3,i)); 
         
        % calculate regrets for every fixed index position        
        reg_raw(i)=ca-cb;
        reg_column(i)=cd-ce;
        reg_t(i)=cf-cg;

      end
         
       % find maximum regret of all regrets for every fixed index position
        [maxreg_raw indx]=max(reg_raw);
        [maxreg_column indy]=max(reg_column);
        [maxreg_t indz]=max(reg_t);
        
        % if maximum regret of one fixed position is higher than for other
        % fixed positions- find a maximum value in input matrix from entries that has
        % same index position as this regret
        if (maxreg_raw>=maxreg_column) & (maxreg_raw>=maxreg_t)
            
           [max_value indz]=max(max(T(indx,:,:)));
           [max_value indy]= max(T(indx,:,indz)); 
            maxreg=maxreg_raw;

        elseif (maxreg_column>maxreg_raw)& (maxreg_column>=maxreg_t)
            
            [max_value indz]=max(max(T(:,indy,:)));
            [max_value indx]= max(T(:,indy,indz)); 
            maxreg=maxreg_column;
            
        elseif  (maxreg_t>maxreg_raw)& (maxreg_t>maxreg_column)
            
            [max_value indy]=max(max(T(:,:,indz)));
            [max_value indx]= max(T(:,indy,indz)); 
            maxreg=maxreg_column;
            
        % in case when 2 maximum regrets of 2 different index positions are
        % the same- find maximum value in input matrix from entries with 
        % the same index positions as this two maximum regrets       
        elseif  (maxreg_raw == maxreg_column)& (maxreg_raw>maxreg_t)   
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
        elseif  (maxreg_raw==maxreg_t)& (maxreg_raw>maxreg_column)   
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
        
        elseif  (maxreg_column==maxreg_t)& (maxreg_column>maxreg_raw)   
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
                maxreg=maxreg_t;
      
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