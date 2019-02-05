clear

i = 1
j = 1
x = 1:100;

for N = x % For 2...10 UTs 
    j = 1; 
    p1=1;
    p2=2;
    p3=3;
    p4=4;
    p5=5;
    p6=6;
    
    for C = [7] % For 3 and 7 cells
        n = 1:N;
%         c1(i,j) = sum((N - n + 1).^C); % True number of operations Greedy
%         c2(i,j) = C.*sum((N - n + 1).^C); % True number of operations Max-Regret 
%         c3(i,j) = N.^C * log2(N.^C) + N; % True number of operations sorted algorithm (Greedy or Max-Regret)
%         c4(i,j) = N.^(C+1); % Upper bound "approximation" Greedy O(n^(s + 1))
%         c5(i,j) = C .* N.^(C+1); % Upper bound "approximation" Max-Regret O(s * n^(s + 1))

%         Selection:
          c1(i,j) = sum((N - n + 1).^C); % True number of operations Greedy
          c2(i,j) = C.*sum(2*((N - n + 1).^C)); % True number of operations Max-Regret User Oriented

%         Sorting:
          c3(i,j) = N.^C * log2(N.^C) + N; % True number of operations sorted algorithm (Greedy)
          c4(i,j) = C*N.^C * log2(N.^(C-1))+ C*sum((N - n + 1).^2); %max reg User
       
           c5(i,j) = nchoosek(C,p1)*sum(2*((N - n + 1).^C));
           c6(i,j) = nchoosek(C,p2)*sum(2*((N - n + 1).^C));
           c7(i,j) = nchoosek(C,p3)*sum(2*((N - n + 1).^C));
           c8(i,j) = nchoosek(C,p4)*sum(2*((N - n + 1).^C));
           c9(i,j) = nchoosek(C,p5)*sum(2*((N - n + 1).^C));
           c10(i,j) = nchoosek(C,p6)*sum(2*((N - n + 1).^C));
           
          c11(i,j) = (factorial(N.^1))^(C-1);
          
          



          

        j = j + 1;
    end
    i = i + 1;
end

y1 = x.^(C+1);
y2 = C.*x.^(C+1);
% plot(x,c4,'o-',x,c5,'.-',x,c3,'*-')
% plot(x,c1,'o-',x,c2,'.-',x,c3,'*-')
% plot(x,c4,'o-',x,c5,'.-',x,c6,'*-')

%plot(x,c1,'o-',x,c2,'.-',x,c4,'s-',x,c5,'d-')
%plot(x,c1,'o-',x,c2,'.-',x,c3,'*-',x,c4,'s-',x,c5,'d-',x,c6,'p-')
%plot(x,c1,'o-',x,c2,'s-',x,c3,'.-',x,c4,'*-')
plot(x,c5,x,c6,x,c7,x,c8,x,c9,x,c10, x,c11)


