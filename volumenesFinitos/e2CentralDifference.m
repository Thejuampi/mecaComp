%Ejercicio 2;

clear all; close all;

cantElementos   = 5;
tiempoDesde     = 0;
tiempoHasta     = 1.0;
cantPasosTiempo = 5;
deltaT          = (tiempoHasta - tiempoDesde)/cantPasosTiempo;
longitud        = 1;
deltaX          = longitud/cantElementos;
x               = 0:deltaX:longitud;
t               = tiempoDesde:deltaT:tiempoHasta;

velocidad           = 100; %(100;0;0)
coefConductividad   = 1; %escalar, constante
fuente              = 1; %escalar, constante

condBordeIzquierdoDirichlet  = 0;
condBordeDerechoNeumann      = 1;


K = zeros(cantElementos,cantElementos);
a = zeros(cantElementos,1);
phiAnterior = zeros(cantElementos,1);
%phiActual   = zeros(cantElementos,1);

%K es constante, solo hay que llenarla una ves, lo que varia es b

K(1,1) = velocidad/4 + deltaX/deltaT; 
K(1,2) = velocidad/4 - coefConductividad/deltaX;
a(1)   = velocidad/4*condBordeIzquierdoDirichlet + coefConductividad/deltaX*condBordeIzquierdoDirichlet + fuente*deltaX + phiAnterior(1)*deltaX/deltaT + 1/2*(-velocidad*condBordeIzquierdoDirichlet -coefConductividad/deltaX*(phiAnterior(1) - phiAnterior(2)) + velocidad/2*(phiAnterior(1) + phiAnterior(2)) -coefConductividad/deltaX*(phiAnterior(2) - phiAnterior(1)) );

for j = 2:cantElementos-1
   K(j,j-1) = velocidad/4 + coefConductividad/2/deltaX;
   K(j,j)   = deltaX/deltaT + velocidad/2;
   K(j,j+1) = velocidad/4 - coefConductividad/2/deltaX;
   a(j)     = fuente*deltaX + phiAnterior(j)*deltaX/deltaT + 1/2*( -velocidad/2*( phiAnterior(j-1) + phiAnterior(j) )  - coefConductividad/deltaX*(phiAnterior(j-1) - phiAnterior(j)) + velocidad/2*(phiAnterior(j) + phiAnterior(j+1)) - coefConductividad/deltaX*(phiAnterior(j+1) - phiAnterior(j)) );
end

K(cantElementos,cantElementos-1) = velocidad/4 + coefConductividad/2/deltaX;
K(cantElementos,cantElementos)   = deltaX/deltaT + velocidad/2 - coefConductividad/2/deltaX;
a(cantElementos)                 = -condBordeDerechoNeumann*deltaX/4 + coefConductividad/2*condBordeDerechoNeumann + fuente*deltaX + phiAnterior(cantElementos)*deltaX/deltaT + 1/2*( -velocidad/2*(phiAnterior(end-1) + phiAnterior(end) )  -coefConductividad/deltaX*( phiAnterior(end-1) - phiAnterior(end) ) + velocidad*(phiAnterior(end) + condBordeDerechoNeumann*deltaX/2) - coefConductividad*condBordeDerechoNeumann ); 

phiActual = K\a;


plot(x(2:end),phiActual);
pause(0.15);
phiAnterior = phiActual;

for n = 2:cantPasosTiempo
    a(1)   = velocidad/4*condBordeIzquierdoDirichlet + coefConductividad/deltaX*condBordeIzquierdoDirichlet + fuente*deltaX + phiAnterior(1)*deltaX/deltaT + 1/2*(-velocidad*condBordeIzquierdoDirichlet -coefConductividad/deltaX*(phiAnterior(1) - phiAnterior(2)) + velocidad/2*(phiAnterior(1) + phiAnterior(2)) -coefConductividad/deltaX*(phiAnterior(2) - phiAnterior(1)) );    
    for j = 2:cantElementos-1
        a(j)     = fuente*deltaX + phiAnterior(j)*deltaX/deltaT + 1/2*( -velocidad/2*( phiAnterior(j-1) + phiAnterior(j) )  - coefConductividad/deltaX*(phiAnterior(j-1) - phiAnterior(j)) + velocidad/2*(phiAnterior(j) + phiAnterior(j+1)) - coefConductividad/deltaX*(phiAnterior(j+1) - phiAnterior(j)) );
    end
    a(cantElementos) = -condBordeDerechoNeumann*deltaX/4 + coefConductividad/2*condBordeDerechoNeumann + fuente*deltaX + phiAnterior(cantElementos)*deltaX/deltaT + 1/2*( -velocidad/2*(phiAnterior(end-1) + phiAnterior(end) )  -coefConductividad/deltaX*( phiAnterior(end-1) - phiAnterior(end) ) + velocidad*(phiAnterior(end) + condBordeDerechoNeumann*deltaX/2) - coefConductividad*condBordeDerechoNeumann ); 
    
    phiActual = K\a;
    plot(x(2:end),phiActual);
    phiAnterior = phiActual;
    pause(0.15);
end


