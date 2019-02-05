T(:,:,1)= [1 5 8; 10 13 3; 5 8 5];
T(:,:,2)= [ 2 4 6; 3 1 2; 5 16 10];
T(:,:,3) = [11 5 3; 8 7 4; 2 13 5];

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
        
        if maxreg_raw>=maxreg_column
           [max_valuee indy]=max(T(indx,:,k));
            maxreg1=maxreg_raw;
            max_valuee
            maxreg1
            
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
         
         maximum_value(j)=max_val;
         maximum_value
         
    T(index,:,:) = -1000;
    T(:,indey,:) = -1000;
    T(:,:,indz) = -1000;

end