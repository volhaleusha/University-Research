function [p,s]=permutes(n)
p=1;
 m=1;
 if n>1
   for a=2:n
     q=zeros(a*m,a);
     r=2:a+1;
        ix=1:m;
     for b=1:a
        q(ix,1)=b;
       q(ix,2:a)=r(p);
       r(b)=b;
       ix=ix+m;
     end
     m=m*a;
     p=q;
   end
end
if nargout>1 
    s = 1-2*rem(fix((1:m)'/2),2); 
end