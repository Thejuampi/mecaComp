clear all;close all;
%syms x m l;

M = 9;
x_ini = 0;
x_fin = 1;

%phi 'real':
phi = sym('sin(-1.8*pi*x) + x');

%N[m](x):
N = sym('sin(m*pi*x)');

%Galerkin:
W = sym('sin(l*pi*x)');

%Tridente: (psi)
pendiente = (subs(phi,'x',x_fin) - subs(phi,'x',x_ini))/(x_fin-x_ini);
psi = pendiente*sym('x');

%Metodo:
K = zeros(M,M);
f = zeros(1,M); %1 columna, M filas

for l=1:M
    for m = 1:M
        I = subs(N*W,{'l','m'},{l,m});
        K(l,m) = double(int(I,'x',x_ini,x_fin));
    end
    Wl = subs(W,'l',l);
    f(l) = double(int(phi*Wl,'x',x_ini,x_fin) - int(Wl*psi,'x',x_ini,x_fin));
end

a = K\f';

phi_aprox = psi;
for m = 1:M
    phi_aprox = phi_aprox + subs(N,'m',m)*a(m);
end

dx = 0.05;
x = x_ini:dx:x_fin-dx;
y1 = double(subs(phi,'x',x));
y2 = double(subs(phi_aprox,'x',x));

plot(x,y1,'o');
hold on
plot(x,y2,'.');