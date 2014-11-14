%Ejercicio 2;

clear all; close all;

cantElementos   = 5;
tiempoDesde     = 0;
tiempoHasta     = 0.01;
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

K(1,1) = -deltaX/deltaT + 3*coefConductividad/2/deltaX + velocidad/2; 
K(1,2) = -coefConductividad/deltaX/2;
a(1)   = fuente*deltaX - phiAnterior(1)*deltaX/deltaT + 1/2*velocidad*condBordeIzquierdoDirichlet + coefConductividad/deltaX*condBordeIzquierdoDirichlet + 1/2*(velocidad*condBordeIzquierdoDirichlet - 2*coefConductividad/deltaX*(phiAnterior(1) - condBordeIzquierdoDirichlet)) - 1/2*(velocidad*phiAnterior(1) - coefConductividad/deltaX*(phiAnterior(2) - phiAnterior(1)));

for j = 2:cantElementos-1
   K(j,j-1) = -velocidad/2 - coefConductividad/2/deltaX;
   K(j,j)   = -deltaX/deltaT + coefConductividad/deltaX + velocidad/2;
   K(j,j+1) = -coefConductividad/2/deltaX;
   a(j)     = fuente*deltaX - phiAnterior(j)*deltaX/deltaT + 1/2*(velocidad*phiAnterior(j-1) - coefConductividad/deltaX*(phiAnterior(j) - phiAnterior(j-1))) - 1/2*(velocidad*phiAnterior(j) - coefConductividad/deltaX*(phiAnterior(j+1) - phiAnterior(j)));
end

K(cantElementos,cantElementos-1) = - velocidad/2 - coefConductividad/2/deltaX;
K(cantElementos,cantElementos)   = -deltaX/deltaT + velocidad/2 + coefConductividad/2/deltaX;
a(cantElementos)                 = fuente*deltaX - phiAnterior(end)*deltaX/deltaT + coefConductividad/2*condBordeDerechoNeumann + 1/2*(velocidad*phiAnterior(end-1) - coefConductividad/deltaX*(phiAnterior(end)-phiAnterior(end-1))) - 1/2*(velocidad*phiAnterior(end) - coefConductividad*condBordeDerechoNeumann);
phiActual = K\a;

hold on;

plot(x(2:end),phiActual);
pause(0.8);
phiAnterior = phiActual;

for n = 2:cantPasosTiempo
    a(1)                = fuente*deltaX - phiAnterior(1)*deltaX/deltaT + 1/2*velocidad*condBordeIzquierdoDirichlet + coefConductividad/deltaX*condBordeIzquierdoDirichlet + 1/2*(velocidad*condBordeIzquierdoDirichlet - 2*coefConductividad/deltaX*(phiAnterior(1) - condBordeIzquierdoDirichlet)) - 1/2*(velocidad*phiAnterior(1) - coefConductividad/deltaX*(phiAnterior(2) - phiAnterior(1)));
    for j = 2:cantElementos-1
        a(j)            = fuente*deltaX - phiAnterior(j)*deltaX/deltaT + 1/2*(velocidad*phiAnterior(j-1) - coefConductividad/deltaX*(phiAnterior(j) - phiAnterior(j-1))) - 1/2*(velocidad*phiAnterior(j) - coefConductividad/deltaX*(phiAnterior(j+1) - phiAnterior(j)));
    end
    a(cantElementos)    = fuente*deltaX - phiAnterior(end)*deltaX/deltaT + coefConductividad/2*condBordeDerechoNeumann + 1/2*(velocidad*phiAnterior(end-1) - coefConductividad/deltaX*(phiAnterior(end)-phiAnterior(end-1))) - 1/2*(velocidad*phiAnterior(end) - coefConductividad*condBordeDerechoNeumann);
    
    phiActual = K\a;
    plot(x(2:end),phiActual);
    phiAnterior = phiActual;
    pause(0.15);
end
