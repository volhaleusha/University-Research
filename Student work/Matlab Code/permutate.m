
function [comb_vec]=permutate(TP)
%perm_matrix = perms(1:size(TP,1));
perm_matrix =permutes(length(1:size(TP,1)));
%number of permutations
max_vec = size(TP,1);
TRUE = size(TP,1)-1;

while(TRUE)
    max_vec= max_vec * (TRUE);
    TRUE = TRUE-1;
end

%vector saving the sum and the indices of the permutations

comb_vec = zeros(max_vec,1+size(TP,1));

for i = 1:max_vec
    comb_vec(i,2:size(TP,1)+1)=perm_matrix(i,:);
    for j = 1: size(TP,1)
        comb_vec(i,1) = comb_vec(i,1) + TP(j,perm_matrix(i,j));
    end
end
end