function opt = get_entries_optimal(mat1, mat2)
TO = mat1 + mat2';

maxvec=[];
T = permutate(TO);
[V I] = max(T(:,1));
maxvec = T(I,:);
maxvec = maxvec(2:length(maxvec));

for i = 1:size(TO, 1)
    opt(i) = mat1(i, maxvec(i));
    opt(i + size(TO, 1)) = mat2(maxvec(i), i);
end
