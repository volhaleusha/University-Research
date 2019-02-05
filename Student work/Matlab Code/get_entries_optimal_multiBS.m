function opt = get_entries_optimal_multiBS(fap, TO)

maxvec=[];
T = permutate(TO);
[V I] = max(T(:,1));
maxvec = T(I,:);
maxvec = maxvec(2:length(maxvec));

for i = 1:size(TO, 1)
    opt(i) = fap(i, maxvec(i),1);
    opt(i + size(TO, 1)) = fap(maxvec(i), i,2);
end
