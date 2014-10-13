%ejercicio 3

clear all; close all;
% hasta M = 25 se banca esto.
M = 8;
xe = [0 2 0 2 4 4 4 2 0 6 6 6 6 4 2 0 8 8 8 8 8 6 4 2 0];
ye = [0 0 2 2 0 2 4 4 4 0 2 4 6 6 6 6 0 2 4 6 8 8 8 8 8]; 

N = @(m,x,y) sin(m.*pi*x).*sin(m.*pi*y);

psi = @(x,y) (1-x.^2)+(1-y.^2);
psi_x = @(y) -2*(1-y.^2);
psi_y = @(x) -2*(1-x.^2);

%Derivadas: Gracias wxmaxima :p
d2Ndx2 = @(m,x,y) -(pi.^2.*m.^2.*sin((pi.*m.*x)).*sin((pi.*m.*y)));
d2Ndy2 = @(m,x,y) -(pi.^2.*m.^2.*sin((pi.*m.*x)).*sin((pi.*m.*y)));
%Por Galerkin N=W

K = zeros(M,M);
f = zeros(M,1);

for l = 1:M
    for m = 1:M
        K(l,m) = integral2(@(x,y) N(l,x,y).*d2Ndx2(m,x,y) + N(l,x,y).*d2Ndy2(m,x,y),0,1,0,1);
    end
    f(l) = -integral2(@(x,y) N(l,x,y).*( psi_x(y) + psi_y(x) ), 0, 1, 0, 1);
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
        phi_q(i,j) = psi(X(i,j),Y(i,j)) + sum(a(1:M).*N(1:M,X(i,j),Y(i,j))');
    end
end

surf(X,Y,phi_q);