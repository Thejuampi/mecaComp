%Ejercicio 1 a

clear all; close all;

cantElementos   = 5;
longitud        = 1;
deltaX          = longitud/cantElementos;
x               = 0:deltaX:longitud;

velocidad           = 100; %(100;0;0)
coefConductividad   = 1; %escalar, constante
fuente              = 1; %escalar, constante

condBordeIzquierdoDirichlet  = 0;
condBordeDerechoNeumann      = 1;


K = zeros(cantElementos,cantElementos);
a = zeros(cantElementos,1);

%Primer Stencil
% phi1·(3k/h-v/2) + phi2(v/2-k/h) = 2/h*condBordeIzquierdoDirichlet +
% velocidad·condBordeIzquierdoDirichlet + f·deltaX;

K(1,1) = -coefConductividad/deltaX + velocidad/2;
K(1,2) = velocidad/2 - coefConductividad/deltaX;
a(1)   = fuente*deltaX + velocidad*condBordeIzquierdoDirichlet + condBordeIzquierdoDirichlet*2*coefConductividad/deltaX;

for j=2:cantElementos-1
   K(j,j-1) = -velocidad/2-coefConductividad/deltaX;
   K(j,j)   = 2 * coefConductividad / deltaX;
   K(j,j+1) = velocidad/2-coefConductividad/deltaX;
end

a(2:cantElementos-1) = fuente*deltaX;

K(cantElementos,cantElementos-1) = -velocidad/2 - coefConductividad/deltaX;
K(cantElementos,cantElementos)   =  velocidad/2 + coefConductividad/deltaX;
a(cantElementos)                 =  fuente*deltaX + condBordeDerechoNeumann*(coefConductividad-velocidad*deltaX/2);

phi = K\a;
phi = [condBordeIzquierdoDirichlet;phi];

plot(x,phi);