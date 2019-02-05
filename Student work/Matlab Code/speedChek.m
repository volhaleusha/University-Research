n = 200000

tHung = 0;
for i = 1:n
    m1 = 50 * rand(10, 10);
    m2 = 50 * rand(10, 10);
    tic
    get_entries_optimalHung(m1, m2);
    tHung = tHung + toc;
end
tHung
tGr = 0;
for i = 1:n
    m1 = 50 * rand(10, 10);
    m2 = 50 * rand(10, 10);
    tic
    get_entries_greedy(m1, m2);
    tGr = tGr + toc;
end
tGr
tR = 0;
for i = 1:n
    m1 = 50 * rand(10, 10);
    m2 = 50 * rand(10, 10);
    tic
    get_entries_random(m1, m2);
    tR = tR + toc;
end
tR
    
tHung / tR
tGr / tR
tR / tR

tHung / tGr
    