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
N = sym('x^(m-1)');

%Galerkin:
%W = sym('sin(l*pi*x)');
W = sym('x^(l-1)');

%Tridente: (psi) no se usa
%psi = sym('x');
W_techito = -W;

%Metodo:
K = zeros(M,M);
f = zeros(M,1); %1 columna, M filas

d2N = diff(N,'x',2);
LN = d2N - N;

%N0 = subs(N,'x',0);
%N1 = subs(N,'x',1);

for l=1:M
    for m=1:M
        I = subs(W*LN,{'l','m'},{l,m}) - subs(N,{'m','x'},{m,x_ini})*subs(N,{'m','x'},{l,x_ini}) - subs(N,{'m','x'},{m,x_fin})*subs(N,{'m','x'},{l,x_fin});
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