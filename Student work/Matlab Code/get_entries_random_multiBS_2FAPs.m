function [opt] = get_entries_random_multiBS_2FAPs(fap, common)
  
    TR = common;
    r = [];
    r = randperm(size(TR, 1));


    for i =1:size(TR, 1)
        opt(i) = fap(i, r(i), 1);
        opt(i + size(TR, 1))=fap(r(i), i, 2);
    end
