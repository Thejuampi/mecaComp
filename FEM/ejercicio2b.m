%Ejercicio 2b

nroElem = 2;
x_ini = 0;
x_fin = 1;
L = x_fin-x_ini;

syms x xi xj

N = [(xj-x)/(xj-xi);(x-xi)/(xj-xi)];
dN = [-1/(xj-xi);1/(xj-xi)];

for e=1:nroElem
    
end