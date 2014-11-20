clear all; clc;
syms x y xi yi xj yj xk yk alpha beta gamma

cantElem  = 2;
cantNodos = 4;

k = 2;
Q = [5.000; 1.200];

fuentesPuntuales    = [1];
fuentesDistribuidas = [2];

dirichled =   [1 2 4];
neumman   =   [3 4 1];
robbin    =   [3 4];


C = [ 1 xi yi ;
      1 xj yj ;
      1 xk yk ];
  
F = [1 0 0;
     0 1 0;
     0 0 1];
 
 alpha = sym(zeros(3,1));
 beta  = sym(zeros(3,1));
 gamma = sym(zeros(3,1));
 
 for i = 1:3
     coef = C\F(:,i);
     alpha(i) = coef(1);
     beta(i)  = coef(2);
     gamma(i) = coef(3);
 end
 
% X = zeros(cantNodos,2); % 4 nodos, x,y dimensiones
 
 coordinates = [ 0.000, 0.000;
                 5.000, 0.000;
                 5.000, 5.000;
                 0.000, 5.000];
       
 elementos  =    [  1, 2, 4;
                    3, 4, 2 ];

                
%%%%%%%%%%%%%%%%%%%%%
%  4----------3
%  | \        |
%  |   \   2  |
%  |     \    |
%  |   1   \  |
%  1----------2
%%%%%%%%%%%%%%%%%%%%%
                
N = sym(zeros(3,3));
dNx = sym(zeros(3,3));
dNy = sym(zeros(3,3));

for e = 1:cantElem
   
    %x_(1) = xi; x_(2) = xj; x_(3) = xk. Ídem y_
    x_ = coordinates(elementos(e,:),1);
    y_ = coordinates(elementos(e,:),2);
    %Trial functions
    N(e,1) = subs(alpha(1),{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}) + x*subs(beta(1) ,{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}) + y*subs(gamma(1),{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)});
    N(e,2) = subs(alpha(2),{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}) + x*subs(beta(2) ,{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}) + y*subs(gamma(2),{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)});
    N(e,3) = subs(alpha(3),{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}) + x*subs(beta(3) ,{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}) + y*subs(gamma(3),{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)});
    %Derivadas de las trial functions
    dNx(e,1) = diff(N(e,1),x,1);
    dNx(e,2) = diff(N(e,2),x,1);
    dNx(e,3) = diff(N(e,3),x,1);
    
    dNy(e,1) = diff(N(e,1),y,1);
    dNy(e,2) = diff(N(e,2),y,1);
    dNy(e,3) = diff(N(e,3),y,1);
    
end

K = zeros(cantNodos,cantNodos);
f = zeros(cantNodos,1);

M = [2 1 0;
     1 2 0;
     0 0 0];

 for e = 1:cantElem
    
    x_ = coordinates(elementos(e,:),1);
    y_ = coordinates(elementos(e,:),2);
    
    area = 1/2*det(subs(C,{xi,yi,xj,yj,xk,yk},{x_(1),y_(1),x_(2),y_(2),x_(3),y_(3)}));
    
    Kelem = zeros(3,3);
    fElem = zeros(3,1);
    
    for l = 1:3
        for m = 1:3
        
            Kelem(l,m) = dNx(e,l)*k*dNx(e,m) + dNy(e,l)*k*dNy(e,m);
        
        end
        
        
        if(ismember(e,fuentesPuntuales))
            fElem(l) = fElem(l) + subs(N(e,l),{x,y},{1,1})*Q(e)*area;
            continue;
        end
        
        if(ismember(e,fuentesDistribuidas))
            fElem(l) = fElem(l) + 1/3*Q(e)*area;
            continue;
        end
        
        
        
    end
    
    
    Kelem = Kelem*area;
    K(elementos(e,:),elementos(e,:)) = K(elementos(e,:),elementos(e,:)) + Kelem;
    f(elementos(e,:)) = f(elementos(e,:)) + fElem;
 end

 

Tm = K\f;