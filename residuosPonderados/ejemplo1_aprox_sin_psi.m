%ejemplo 1 sin aproximando sin psi, usando galerkin: DEAD END, ver si es 
% posible solucionarlo en otro momento, o consultar con profesor.

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
%N = sym('sin(m*pi*x)');
N = sym('(x-x_ini)^m*(x-x_fin)');
N = subs(N,{'x_ini','x_fin'},{x_ini,x_fin});
%Galerkin:
%W = sym('sin(l*pi*x)');
W = sym('(x-x_ini)^l*(x-x_fin)');
W = subs(W,{'x_ini','x_fin'},{x_ini,x_fin});
%Tridente: (psi) no se usa
%psi = sym('x');
W_techito = -W;

%Metodo:
K = zeros(M,M);
f = zeros(M,1); %1 columna, M filas

d2N = diff(N,'x',2);
LN = d2N - N;
N0 = subs(N,'x',0); %por definicion N(borde) = 0, asi que esto es un dead end...
N1 = subs(N,'x',1);

for l=1:M
    for m=1:M
        I = subs(W*LN,{'l','m'},{l,m}) - subs(N0,'m',m)*subs(N0,'m',l) - subs(N1,'m',m)*subs(N1,'m',l);
        K(l,m) = double(int(I,'x',x_ini,x_fin));
    end
    Wl = subs(W,{'l','x'},{l,x_fin});
    f(l) = double(Wl);
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