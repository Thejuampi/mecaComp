%ejemplo 2.7, verificados los resultados con el libro.

xe = [0 2 0 2 4 4 4 2 0 6 6 6 6 4 2 0 8 8 8 8 8 6 4 2 0];
ye = [0 0 2 2 0 2 4 4 4 0 2 4 6 6 6 6 0 2 4 6 8 8 8 8 8]; 
% hasta M = 25 se banca esto.
%no quise seguir expandiendo mas, porque: 1. no lo creia necesario; 2.
%sigue un patron facilemnte deducible si creen que es necesario mas
%terminos.

M = 3;

N = @(m,x,y) (1-y.^2).*x.^(xe(m)).*y.^(ye(m));
%W = @(l,x,y) (1-y^2).*x.^(x_exp(l)).*y.^(y_exp(l));
dNdx = @(m,x,y) xe(m)*x.^(xe(m)-1).*y.^ye(m).*(1-y.^2);
dNdy = @(m,x,y) ye(m).*x.^(xe(m)).*y.^(ye(m)-1).*(1-y.^2)-2*x.^xe(m).*y.^(ye(m)+1);

K = zeros(M,M);
f = zeros(M,1);

for l = 1:M
    for m = 1:M
        K(l,m) = integral2(@(x,y) dNdx(l,x,y).*dNdx(m,x,y) + dNdy(l,x,y).*dNdy(m,x,y), 0, 1, 0, 1);
    end
    f(l) = integral(@(y) N(l,1,y).*cos(pi.*y./2),0,1);
end

a = K\f;

x_q = -1:0.1:1;
y_q = -1:0.1:1;
n = length(x_q);
[X,Y] = meshgrid(x_q,y_q);
%phi = @(x,y) sum(a(:).*N(1:M,x,y));

phi_q = zeros(n,n);
for i = 1:n
    for j = 1:n
        phi_q(i,j) = sum(a(1:M).*N(1:M,X(i,j),Y(i,j))');
    end
end

surf(X,Y,phi_q);