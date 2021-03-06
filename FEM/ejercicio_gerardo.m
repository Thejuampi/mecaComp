%ejercicio de FEM
syms x
M = 3; %cantidad de elementos
Dim = 2;

%definición del dominio
x_ini = 0;
x_fin = 1;
L = x_fin-x_ini;
dx = L/M;

x_=x_ini:dx:x_fin;

H = sym(zeros(Dim,M)); %2 Hs por cada elemento (M = cant elem)
dH = sym(zeros(Dim,M));
for i = 1:M
    hi = x_(i+1)-x_(i);
    %H1 y derivada
    H1 = (x_(i+1)-x)/hi;
    dH1 = diff(H1,x,1);
    %H2 y derivada
    H2 = (x-x_(i))/hi;
    dH2 = diff(H2,x,1);
    H(:,i) = [H1;H2];
    dH(:,i) = [dH1;dH2];
end

K_global = zeros(2*Dim,2*Dim);
f_global = zeros(2*Dim,1);
K_elem = zeros(Dim,Dim);
f_elem = zeros(Dim,1);
for i = 1:M
    K_elem = -int( dH(:,i)*dH(:,i)' + H(:,i)*H(:,i)', x, x_(i), x_(i+1) );
    f_elem = -int( x*H(:,i),x,x_(i), x_(i+1));
    K_global(i:i+Dim-1,i:i+Dim-1) = K_global(i:i+Dim-1,i:i+Dim-1) + K_elem;
    f_global(i:i+Dim-1) = f_global(i:i+Dim-1) + f_elem;
end

K_global(1,:) = [1, zeros(1,2*Dim-1)];
K_global(end,:) = [zeros(1,2*Dim-1), 1];
f_global(1) = 0;
f_global(end) = 0;

a = K_global\f_global