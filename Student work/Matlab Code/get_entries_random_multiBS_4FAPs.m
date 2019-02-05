function [opt] = get_entries_random_multiBS_4FAPs(fap, common)

    TR = common;
    r = [];
    j = randperm(size(TR, 1));
    k = randperm(size(TR, 1));
    n = randperm(size(TR, 1));
   
    
    for i =1:size(TR, 1)
        opt(i) = fap(i, j(i),k(i),n(i), 1);
        opt(i + size(TR, 1))=fap(j(i), i, k(i), n(i), 2);
        opt(i + 2*size(TR, 1))=fap(k(i), i, j(i), n(i), 3);
        opt(i + 3*size(TR, 1))=fap(n(i), i, j(i), k(i), 4);
    end
