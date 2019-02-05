function opt = get_entries_greedy_multiBS_2FAPs(fap, common)

T = common;

l = size(T,1);
opt = zeros(1, 2 * l);

for j=1:l
    
    % find maximum of input set
    % indx and indy show the index position of maximum values
    [Vi indy] = max(max(T));
    [Vj indx] = max(T(:,indy));

    % find values of input matrices of every BS separately
    opt(j) = fap(indx, indy, 1);
    opt(j + l) = fap(indy, indx, 2);
        
    % cover row and column containing max value
    T(indx,:) = -1000;
    T(:,indy) = -1000;
end
    