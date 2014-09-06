%Ejercicio2 Guia 1 RP
clear all; close all;
M = 2; %orden de aproximacion
x_ini = 0;
x_fin = 1;

%N[m](x)
N = sym('x^(m-1)');

%W[l](x) - GALERKIN
W = sym('x^(l-1)');

%psi
psi = sym('0');

K = zeros(M,M);
f = zeros(M,1);

for l = 1:M
    for m = 1:M
        Wl = subs(W,'l',l);
        Nm = subs(N,'m',m);
        LNm = diff(Nm,'x',1) + Nm;
        MNm = diff(Nm,'x',1) + Nm;
        MNm = subs(MNm,'x',x_fin);
        K(l,m) = double(int(Wl*LNm,'x',x_ini,x_fin) + MNm);
    end
    f(l) = -double(int(Wl,'x',x_ini,x_fin));
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