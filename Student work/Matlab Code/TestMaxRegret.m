% T(:,:,1)= [1 5 8 ; 10 13 3; 5 8 5];
% T(:,:,2)= [ 2 4 6; 3 1 2; 5 16 10];
% T(:,:,3) = [11 5 3; 8 7 4; 2 13 5];
%  T(:,:,1)= [2 5 1; 2 4 6; 3 2 3];
%  T(:,:,2)= [2 5 1; 2 4 6; 3 2 3];
%  T(:,:,3)= [2 5 1; 2 4 6; 3 2 3];
T(:,:,1) = [ 7 7 8 9 7 7 9 9; 9 9 9 9 9 9 9 9 ;8 8 8 9 8 8 9 9 ;9 9 9 9 9 9 9 9;6 6 6 7 6 6 9 7; 8 8 9 9 8 8 9 9; 7 7 8 8 7 7 9 8; 9 9 9 9 9 9 9 9 ]
T(:,:,2) = [9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 8 8 9  9 9 8 8  ;9 9 9 9 9 9 9 9 ;9 8 8 9 9 9 8 8] 
T(:,:,3) = [9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9  ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9] 
T(:,:,4) = [9 8 8 9 9 9 8 8 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;8 8 7 8 9 8 7 7 ;9 9 9 9 9 9 9 9 ;8 8 7 8 9 8 7 7 ;9 8 8 9 9 9 8 8] 
T(:,:,5) = [9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 8 8 9  9 9 8 8  ;9 9 9 9 9 9 9 9 ;9 8 8 9 9 9 8 8] 
T(:,:,6) = [9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9  ;9 9 9 9 9 9 9 9 ;9 9 9 9 9 9 9 9] 
T(:,:,7) = [6 6 5 6 8 7 5 5 ; 9 9 9 9 9 9 9 9 ;8 4 4 8 9 9 6 7; 9 9 9 9 9 9 9 9; 5 5 5 5 8 6 5 5 ; 9 9 9 9 9 9 9 9 ;5 5 5 5 8 6 5 5; 6 6 6 6 9 7 5 6] 
T(:,:,8) = [8 8 8 8 9 9 8 8 ;9 9 9 9 9 9 9 9;9 9 9 9 9 9 9 9; 9 9 9 9 9 9 9 9 ;8 7 7 8 9 8 7 7; 9 9 9 9 9 9 9 9 ;8 7 7 8 9 8 7 7 ;9 8 8 9 9 9 8 8]

l = size(T,1);
opt = zeros(1, 3 * l);
max_value = zeros(1, l);
maxregg = zeros(1, l);
indexx = zeros(1, l);
indeyy = zeros(1, l);

        
for j=1:l
    
  for k = 1:l 
      
       reg_raw = zeros(1, l);
       reg_column = zeros(1, l);
       index1 = zeros(1, l);
       indey1 = zeros(1, l);
       index2 = zeros(1, l);
       indey2 = zeros(1, l);

      for i=1:l
             
         T1 = T;
         T2 = T;
         [ca indx1]= max(T1(i,:,k));
         [cd indy1]= max(T2(:,i,k));
         T1(i,indx1,k)=-1000;
         T2(indy1,i,k)=-1000;
         [cb indx2]= max(T1(i,:,k));
         [ce indy2]= max(T2(:,i,k));
         
        reg_raw(i)=ca-cb;
        reg_column(i)=cd-ce;
        index1(i)= indx1;
        indey1(i)= indy1;
        index2(i)= indx2;
        indey2(i)= indy2;
        reg_raw
        reg_column
        
      end
         
        [maxreg_raw indx]=max(reg_raw);
        [maxreg_column indy]=max(reg_column);
%         
%         if maxreg_raw >= maxreg_column
%            [max_valuee indy]=max(T(indx,:,k));
%             maxreg1=maxreg_raw;
%             max_valuee
%             maxreg1
%         
        
        if maxreg_raw > maxreg_column
           [max_valuee indy]=max(T(indx,:,k));
            maxreg1=maxreg_raw;
            max_valuee
            maxreg1
            
        elseif  maxreg_raw == maxreg_column
            [max_valuee1 indy_max_valuee1]=max(T(indx,:,k));
            [max_valuee2 indx_max_valuee2]=max(T(:,indy,k));
            if max_valuee1>=max_valuee2
               max_valuee = max_valuee1;
               maxreg1 = maxreg_raw;
               indy = indy_max_valuee1;
            else 
               max_valuee = max_valuee2;
               maxreg1 = maxreg_column; 
               indx = indx_max_valuee2;
            end                
%             
        else
            [max_valuee indx]=max(T(:,indy,k));
            maxreg1=maxreg_column;
            max_valuee
            maxreg1
            
            end
       
        max_value(k)=max_valuee;
        maxregg(k)=maxreg1;
        indeyy(k)=indy;
        indexx(k)=indx;
        max_value
        maxregg
        indexx
        indeyy
        
        
  end
  
         [maxreg indz]=max(maxregg);
         index= indexx(indz);
         indey= indeyy(indz);
         max_val=max_value(indz);
         maxreg
         index
         indey
         max_val
         
         
         if max_val<0 
                [max_val indz] = max(max(max(T)));
                [max_val indey] = max(max(T(:,:,indz)));
                [max_val index] = max(T(:,indey,indz));  
         end
         maximum_value(j)=max_val;
         maximum_value
         
    T(index,:,:) = -1000;
    T(:,indey,:) = -1000;
    T(:,:,indz) = -1000;

end