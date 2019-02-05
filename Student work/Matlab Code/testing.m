T= [ 5 8 9 4; 9 11 8 6; 7 15 10 9; 6 10 12 3];

l = size(Tl,1);
opt = zeros(1, 2 * l);
reg_raw = zeros(1, l);
reg_column = zeros(1, l);
index1 = zeros(1, l);
indey1 = zeros(1, l);
index2 = zeros(1, l);
indey2 = zeros(1, l);

for j=1:l
     
      for i=1:l
         T1 = T; 
         T2 = T;
         [ca indx1]= max(T1(i,:));
         [cd indy1]= max(T2(:,i));
         T1(i,indx1)=-1000;
         T2(indy1,i)=-1000;
         [cb indx2]= max(T1(i,:));
         [ce indy2]= max(T2(:,i));
         
        reg_raw(i)=ca-cb;
        reg_column(i)=cd-ce;
        index1(i)= indx1;
        indey1(i)= indy1;
        index2(i)= indx2;
        indey2(i)= indy2;
        
        ca
        cb
        cd
        ce
        index1
        indey1
        index2
        indey2
        reg_raw
        reg_column
        
      end        
        [maxreg_raw indx]=max(reg_raw);
        [maxreg_column indy]=max(reg_column);
        if maxreg_raw>=maxreg_column
            [max_value indy]=max(T(indx,:));
        else
            [max_value indx]=max(T(:,indy));

        end
          max_value1(j)=  T(indx, indy);

         T(indx,:) = -1000;
         T(:,indy) = -1000;
         max_value1

end