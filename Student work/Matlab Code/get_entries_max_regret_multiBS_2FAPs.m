function [opt] = get_entries_max_regret_multiBS_2FAPs(fap, common)

T=common;
l = size(T,1);
opt = zeros(1, 2 * l);
reg_raw = zeros (1,l);
reg_column = zeros (1,l);

for j=1:l
     
      for i=1:l
         T1 = T; 
         T2 = T;
         
         % find first maximum for every row and column 
         [ca indx1]= max(T1(i,:));
         [cd indy1]= max(T2(:,i));
         
         % cover row and column containing firts maximum
         T1(i,indx1)=-1000;
         T2(indy1,i)=-1000;
         
         %calculate second maximum for every row and column
         [cb indx2]= max(T1(i,:));
         [ce indy2]= max(T2(:,i));
        
        % calculate regrets for every row and column 
        reg_raw(i)=ca-cb;
        reg_column(i)=cd-ce;
        
      end        
      
        % find maximum regret of all columns and rows regrets
        [maxreg_raw indx]=max(reg_raw);
        [maxreg_column indy]=max(reg_column);
        
        % if maximum regret of rows higher than maximum regret of columns-
        % find the maximum value in the  the row containing
        % this regret 
        if maxreg_raw>maxreg_column
            [max_valuee indy]=max(T(indx,:));
            max_val=max_valuee;
            maxreg=maxreg_raw;
            
        % if maximum regret of columnss higher than maximum regret of rows-
        % find the maximum value in the  the column containing
        % this regret     
            
        elseif maxreg_column> maxreg_raw
            [max_valuee indx]=max(T(:,indy));
            max_val=max_valuee;
            maxreg=maxreg_column;
            
            % else check both: columns and rows, for maximum value
        else 
            [max_valuee1 indy_max_valuee1]=max(T(indx,:));
            [max_valuee2 indx_max_valuee2]=max(T(:,indy));
            
            if max_valuee1>=max_valuee2
               indy = indy_max_valuee1;
               max_val=max_valuee1;
               maxreg=maxreg_raw;
            else 
               indx = indx_max_valuee2;
               max_val=max_valuee2;
               maxreg=maxreg_column;
            end                

        end
        
        % if maximum regret is 0 - find maximum from the whole input matrix
         if maxreg==0 
                [max_val indy] = max(max(T));
                [max_val indx] = max(T(:,indy));              
         end
        
          max_value(j)=  T(indx, indy);  
          % find values of input matrices of every BS separately
          opt(j) = fap(indx, indy, 1);
          opt(j + l) = fap(indy, indx, 2);
          
          % cover index positions containing max value   
         T(indx,:) = -1000;
         T(:,indy) = -1000;

end