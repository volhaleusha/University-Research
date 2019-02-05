function [opt] = get_entries_greedy_multiBS_3FAPs(fap, common)

T = common;

l = size(T,1);
opt = zeros(1, 3 * l);

for j=1:l
    % find maximum of input set
    % indx, indy and indz show the index position of maximum values
    [Vi indz] = max(max(max(T)));
    [Vj indy] = max(max(T(:,:,indz)));
    [Vk indx] = max(T(:,indy,indz));  
    
    % find values of input matrices of every BS separately
    opt(j) = fap(indx, indy, indz, 1);
    opt(j + l) = fap(indy, indx, indz, 2);
    opt(j + 2*l) = fap(indz, indx, indy, 3);
    
    % % cover index positions containing max value        
    T(indx,:,:) = -1000;
    T(:,indy,:) = -1000;
    T(:,:,indz) = -1000;
end