function opt = get_entries_greedy(mat1, mat2)

T = mat1 + mat2';

l = size(T,1);
opt = zeros(1, 2 * l);

for j=1:l
    [Vi indy] = max(max(T));
    [Vj indx] = max(T(:,indy));
    
    %[t, i] = max(T(:));
    %indx = ceil(i / l);
    %indy = i - l * (indx - 1);

    opt(j) = mat1(indx, indy);
    opt(j + l) = mat2(indy, indx);
        
    T(indx,:) = -1000;
    T(:,indy) = -1000;
end
    