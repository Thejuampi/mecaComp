% Resolucion del ejemplo de torsion en 2d

% d2/dx2)*phi + (d2/dy2)*phi = -2*G*Theta
% phi(contorno) = 0

syms ax ay x y


ax = [1 3 1];
ay = [1 1 3];

xini = -3;
xfin = 3;
yini = -2;
yfin = 2;

M = 3; % cantidad de funciones de prueba, tamaño de la matriz, etc.

%psi 
psi = 0; % por la condicion de borde phi(contorno) = 0

%N[m](x): funciones simétricas dada las propiedades del problema
N = cos(pi*x/6)*cos(pi*x/4);
