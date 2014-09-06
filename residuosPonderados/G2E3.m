%Ejercicio 3 Guia 1 - RP 2D
% resuelto de forma general, tengo pensado hacerlo de nuevo aprovechando
% las propiedades de simetria del problema en una siguiente iteracion

clear all; close all;
M = 6; %orden de aproximacion
x_ini = -1; x_fin = 1;
y_ini = -1; y_fin = 1;
Q = 0;
k = 1;

%N[m](x)
N = sym('(x^(2*m))*(y^(2*m))'); 
%N=sym('exp(m*x*y)'); no funca con esto
%N = sym('cos(m*pi*x/2)*cos(m*pi*y/2)');

%W[l](x) - GALERKIN
W = subs(N,'m','l');

%psi
psi = sym('0');

%Metodo
K = zeros(M,M);
f = zeros(M,1);

d2Ndx2 = diff(N,'x',2);
d2Ndy2 = diff(N,'y',2);

for l = 1:M
    Wl = subs(W,'l',l);
    Wlx_i = subs(Wl,'x',x_ini);
    Wly_i = subs(Wl,'y',y_ini);
    Wlx_f = subs(Wl,'x',x_fin);
    Wly_f = subs(Wl,'y',x_fin);
    for m = 1:M
        Nm=subs(N,'m',m);
        LNm = subs(d2Ndx2+d2Ndy2,'m',m);
        interior = double(int(int(Wl*k*LNm,'x',x_ini,x_fin),'y',y_ini,y_fin));
        contorno = double(int(Wlx_i*subs(Nm,'x',x_ini), 'y',y_ini,y_fin) + int(Wlx_f*subs(Nm,'x',x_fin), 'y',y_ini,y_fin) + int(Wly_i*subs(Nm,'y',y_ini), 'x',x_ini,x_fin) + int(Wly_f*subs(Nm,'y',y_fin), 'x',x_ini,x_fin));
        K(l,m) = interior + contorno;
    end
    f(l) = -(int(int(Wl*Q,'x',x_ini,x_fin),'y',y_ini,y_fin) + int(Wlx_i*(sym('y^2 -1')),'y',y_ini,y_fin) + int(Wlx_f*(sym('y^2 -1')),'y',y_ini,y_fin) + int(Wly_i*(sym('x^2 -1')),'x',x_ini,x_fin) + int(Wly_f*(sym('x^2 -1')),'x',x_ini,x_fin));
end

a = K\f;

Nx = 25;
Ny = 25;

Lx = x_fin-x_ini;
Ly = y_fin-y_ini;

dx = Lx/Nx;
dy = Ly/Ny;

x = x_ini:dx:x_fin-dx;
y = y_ini:dx:y_fin-dy;

[X, Y] = meshgrid(x,y);

phi_aprox = psi;
for m = 1:M
    phi_aprox = phi_aprox + subs(N,'m',m)*a(m);
end

Z = zeros(Nx,Ny);
for i=1:Nx
    for j=1:Ny
        Z(i,j) = subs(phi_aprox,{'x','y'},{X(i,j),Y(i,j)});
    end
end

surf(X,Y,Z);