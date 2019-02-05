function [opt] = get_entries_greedy_multiBS_4FAPs(fap, common)

T = common;

l = size(T,1);
opt = zeros(1, 4 * l);

for j=1:l
    
    % find maximum of input set
    % indx, indy, indz and indt show the index position of maximum values
    [Vi indt] = max(max(max(max(T))));
    [Vj indz] = max(max(max(T(:,:,:,indt))));
    [Vk indy] = max(max(T(:,:,indz,indt))); 
    [Vn indx] = max(T(:,indy,indz,indt));   

    % find values of input matrices of every BS separately
    opt(j) = fap(indx, indy, indz, indt, 1);
    opt(j + l) = fap(indy, indx, indz, indt, 2);
    opt(j + 2*l) = fap(indz, indx, indy, indt, 3);
    opt(j + 3*l) = fap(indt, indx, indy, indz, 4);
    
    % % cover index positions containing max value   
    T(indx,:,:,:) = -1000;
    T(:,indy,:,:) = -1000;
    T(:,:,indz,:) = -1000;
    T(:,:,:,indt) = -1000;
end