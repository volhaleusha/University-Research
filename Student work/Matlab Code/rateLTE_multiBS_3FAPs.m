function thrLTE_fap = rateLTE_multiBS_3FAPs(fap)
sd =1E-3;
bit(1) = 0;
bit(2:6) = 2;
bit(7:9) = 4;
bit(10:14) = 6;

code(1) = 0;
code(2) = 0.105;
code(3) = 0.168;
code(4) = 0.275;
code(5) = 0.391;
code(6) = 0.528;
code(7) = 0.332;
code(8) = 0.434;
code(9) = 0.578;
code(10) = 0.415;
code(11) = 0.54;
code(12) = 0.643;
code(13) = 0.716;
code(14) = 0.801;
% for i = 1:14
%     r(i) = (12 * 14 * 96 * bit(i) * code(i)) / sd;
% end
% l(1) = -200;
% l(2) = -6.0934;
% l(3) = -4.06716;
% l(4) = -1.96295;
% l(5) = -0.164423;
% l(6) = 1.92114;
% l(7) = 3.82291;
% l(8) = 5.80874;
% l(9) = 8.46731;
% l(10) = 9.91998;
% l(11) = 12.5036;
% l(12) = 14.756;
% l(13) = 16.0828;
% l(14) = 17.8246;
% 
l(1) = -200;
l(2) = -5;
l(3) = -3.77288;
l(4) = -1.73754;
l(5) = 0.11596;
l(6) = 2.22579;
l(7) = 4.07278;
l(8) = 6.09003;
l(9) = 8.78537;
l(10) = 10.1496;
l(11) = 12.8918;
l(12) = 15.1701;
l(13) = 16.3705;
l(14) = 18.1644;

s = size(fap);
thrLTE_fap=zeros(size(fap));

for i = 1:s(1)
    for j = 1:s(2)
        for k =1: s(3)
            for h =1: s(4)

        tmp=0;
        for n = 1:14
            if fap(i,j,k,h) >= l(n)
                tmp=tmp+1;
            end
        end
        thrLTE_faps= (12 * 14 * 96 * bit(tmp) * code(tmp)) / sd;
        thrLTE_fap(i,j,k,h)=thrLTE_faps;
            end
        end
    end
end
