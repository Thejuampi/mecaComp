%ejemplo 1 sin aproximando sin psi, usando galerkin

% solucion del ejemplo dado en clase

% d2phi/dx2 - phi = 0
% phi(0) = 0
% phi(1) = 1

% L = d2(·)/dx2 - (·);
% p = 0;

% en phi(0) = 0: M = 1; r = 0
% en phi(1) = 1: M = 1; r = -1

clear all;close all;

M = 2;
x_ini = 0;
x_fin = 1;

%N[m](x):
N = sym('sin(m*pi*x)');
%Galerkin:
W = sym('sin(l*pi*x)');
%Tridente: (psi) no se usa
%psi = sym('x');
W_techito = -W;

%Metodo:
K = zeros(M,M);
f = zeros(M,1); %1 columna, M filas

d2N = diff(N,'x',2);
LN = d2N - N;
Lpsi = diff(psi,'x',2) - psi;

for l=1:M
    for m=1:M
        I = subs(W*LN,{'l','m'},{l,m});
        K(l,m) = double(int(I,'x',x_ini,x_fin));
    end
    Wl = subs(W,'l',l);
    f(l) = -double(int(Wl*Lpsi,'x',x_ini,x_fin));
end

a = K\f;

phi_aprox = psi;
for m = 1:M
    phi_aprox = phi_aprox + subs(N,'m',m)*a(m);
end

dx = 0.05;
x = x_ini:dx:x_fin-dx;
%y1 = double(subs(phi,'x',x));
y2 = double(subs(phi_aprox,'x',x));

plot(x,y2,'.');