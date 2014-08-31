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
%Colocacion puntual usa el delta d(x-x[l]):
% W = sym('sin(l*pi*x)'); 
%Tridente: (psi)
psi = sym('x');

%Metodo:
K = zeros(M,M);
f = zeros(M,1); %1 columna, M filas

d2N = diff(N,'x',2);
LN = d2N - N;
Lpsi = diff(psi,'x',2) - psi;

dx = (x_fin-x_ini)/(M+1);
xl = x_ini+dx:dx:x_fin-dx;
%xl = [1/3,2/3];

for l=1:M
    for m=1:M
        I = subs(LN,{'m','x'},{m,xl(l)});
        K(l,m) = double(I);
    end
    f(l) = -subs(Lpsi,'x',xl(l));
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