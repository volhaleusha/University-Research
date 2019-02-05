% T(:,:,1)= [1 5 8; 13 10 3; 5 8 5];
% T(:,:,2)= [ 2 4 6; 3 1 2; 5 16 10];
% T(:,:,3) = [1 5 3; 8 7 4; 2 13 5];

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

for j=1:l
    
reg_raw = zeros(1, l);
reg_column = zeros(1, l);
reg_t = zeros(1, l);
      for i=1:l
             
         T1 = T;
         T2 = T;
         T3 = T;

         [ca indz1]= max(max(T1(i,:,:)));
         [ca indy1]= max(T1(i,:,indz1));
         
         [cd indz2]= max(max(T2(:,i,:))); 
         [cd indx2]= max(T2(:,i,indz2)); 
       
         [cf indy3]= max(max(T3(:,:,i))); 
         [cf indx3]= max(T3(:,indy3,i)); 

         T1(i,indy1,indz1)=-1000;
         T2(indx2,i,indz2)=-1000;
         T3(indx3,indy3,i)=-1000; 
         
         [cb indz1]= max(max(T1(i,:,:)));
         [cb indy1]= max(T1(i,:,indz1));
         
         [ce indz2]= max(max(T2(:,i,:))); 
         [ce indx2]= max(T2(:,i,indz2)); 
       
         [cg indy3]= max(max(T3(:,:,i))); 
         [cg indx3]= max(T3(:,indy3,i)); 

         
        reg_raw(i)=ca-cb;
        reg_column(i)=cd-ce;
        reg_t(i)=cf-cg;
        
        reg_raw
        reg_column
        reg_t
        
      end
         
        [maxreg_raw indx]=max(reg_raw);
        [maxreg_column indy]=max(reg_column);
        [maxreg_t indz]=max(reg_t);
        
        if (maxreg_raw>=maxreg_column) & (maxreg_raw>=maxreg_t)
            
           [max_value indz]=max(max(T(indx,:,:)));
           [max_value indy]= max(T3(indx,:,indz)); 
            maxreg=maxreg_raw;
            max_value
            maxreg
            
        elseif (maxreg_column>maxreg_raw)& (maxreg_column>maxreg_t)
            
            [max_value indz]=max(max(T(:,indy,:)));
            [max_value indx]= max(T3(:,indy,indz)); 
            maxreg=maxreg_column;
            max_valuee
            maxreg
          
        elseif (maxreg_t> maxreg_raw) & (maxreg_t>maxreg_column)       
            [max_value indy]=max(max(T(:,:,indz)));
            [max_value indx]= max(T3(:,indy,indz)); 
             maxreg=maxreg_t;
             max_value
             maxreg

        end
        
         if max_value <0 
                [max_value indz] = max(max(max(T)));
                [max_value indy] = max(max(T(:,:,indz)));
                [max_value indx] = max(T(:,indy,indz));  
         end
                 
         
         maximum_value(j)=max_value;
         maximum_value
         
    T(indx,:,:) = -1000;
    T(:,indy,:) = -1000;
    T(:,:,indz) = -1000;

end