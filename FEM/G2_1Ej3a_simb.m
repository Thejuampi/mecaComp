% Resolucion del ejercicio 3a de la guia de elementos finitos 1D
% COORDENADAS CARTESIANAS - INTEGRACION SIMBOLICA
% PDE a resolver: -(d2phi_dx2) + phi - x = 0
% Cond. de borde: phi(0) = phi(1) = 0
% Parametros de entrada: 
%   xnode: conjuntos de nodos
%   sp: bandera para trabajar o no con matrices sparse
%       sp != 0 --> matriz sparse
%       sp == 0 --> matriz llena
function [phi,phi_ex] = G2_1Ej3a_simb(xnode,sp)
    syms x
    
    % Cantidad de nodos y elementos
    Nnod = length(xnode);
    Nelem = Nnod - 1;
    
    % Condiciones de borde
    phi_left = 0;
    phi_right = 0;
    
    Kele = zeros(Nelem,2,2);
    fele = zeros(Nelem,2);

    % Ensamble de cada elemento: matriz y termino derecho
    for iele=1:Nelem
        xi = xnode(iele);
        xj = xnode(iele+1);
        h = xj-xi;
        N = [(h-(x-xi))/h (x-xi)/h];
        dNdx = [-1/h 1/h];
        for il=1:2
            for jl=1:2
                integ = dNdx(il)*dNdx(jl) + N(il)*N(jl);
                Kele(iele,il,jl) = double(int(integ,x,xi,xj));
            end
            integ2 = N(il)*x;
            fele(iele,il) = double(int(integ2,x,xi,xj));
        end
    end
    
    if sp
        rows = [];
        cols = [];
        coef = [];
    else
        Kg = zeros(Nnod,Nnod);
    end
    fg = zeros(Nnod,1);

    % Ensamble de la matriz global y el residuo global
    for iele=1:Nelem
        indx_global = [iele iele+1];
        %i_local(il)=1 -> i_global(ig) = iele;
        %j_local(jl)=2 -> j_global(jg) = iele+1;
        if sp    
            for il=1:2
                ig = indx_global(il);
                for jl=1:2
                    jg = indx_global(jl);
                    rows = [rows;ig];
                    cols = [cols;jg];    
                    coef = [coef;Kele(iele,il,jl)];
                end
                fg(ig) = fg(ig) + fele(iele,il);
            end
        else
            for il=1:2
                ig = indx_global(il);
                for jl=1:2
                    jg = indx_global(jl);
                    Kg(ig,jg) = Kg(ig,jg) + Kele(iele,il,jl);
                end
                fg(ig) = fg(ig) + fele(iele,il);
            end
        end
    end
    if sp
        Kg = sparse(rows,cols,coef);
    end

    % CB Dirichlet
    % Condicion phi(x=0) = 0
    Kg(1,:) = 0;
    Kg(1,1) = 1;
    fg(1) = phi_left;
    % Condicion phi(x=1) = 0
    Kg(Nnod,:) = 0;
    Kg(Nnod,Nnod) = 1;
    fg(Nnod) = phi_right;

    % Resolucion del sist. de ecuaciones
    phi = Kg\fg;
    
    % Solucion analitica
    denom = exp(1)-exp(-1);
    phi_anal = -exp(x)/denom + exp(-x)/denom + x;
    phi_ex = subs(phi_anal,x,xnode);
    
    % Grafica de comparacion: analitica vs FEM
    figure(1);clf;plot(xnode,phi,'o-',xnode,phi_ex,'r');
end