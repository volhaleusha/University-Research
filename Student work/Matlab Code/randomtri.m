function x=randomtri(M)
%Function randomtri
%Description:
%generates ran con una pdf triangular
%Sintaxis:
%x=randomtri(M)
%x: generated random variable.
%M: number of samples generated.
u=rand(1,M);
x=zeros(1,M);
for i=1:M
if u(i)<0.5
x(i)=sqrt((u(i)/2));
else
x(i)=1-sqrt(1-0.5*(u(i)+1));
end
end
end