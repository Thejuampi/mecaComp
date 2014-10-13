%ejercicio 4 symbolico, ya demasiado me hizo renegar esto...

syms x y

N11 = x.*(1-y.^2);
N12 = y.*(1-y.^2);
N21 = x.^3.*(1-y.^2);
N22 = x.^2*y.*(1-y.^2);
N31 = x.*y.^2.*(1-y.^2);
N32 = y.^3.*(1-y.^2);

Ns = [N11 N12;N21 N22;N31 N32];

N = @(m) [Ns(m,1) 0; 0 Ns(m,2)];

LN = @(m) [diff(Ns(m,1),x,1), 0;0, diff(Ns(m,2),y,1);diff(Ns(m,1),y,1), diff(Ns(m,2),x,1)];
LNt = @(m) [diff(Ns(m,1),x,1), 0, diff(Ns(m,1),y,1); 0, diff(Ns(m,2),y,1), diff(Ns(m,2),x,1)];

E = 30/16;
v = 0.25;

D = E/(1-v^2)*[1 v 0;v 1 0;0 0 (1-v)/2];

K = zeros(6,6);
f = zeros(6,1);

for l = 1:3
    for m = 1:3
        Klm = LNt(l)*D*LN(m);
        K(2*(l-1)+1:2*(l-1)+2,2*(m-1)+1:2*(m-1)+2) = K(2*(l-1)+1:2*(l-1)+2,2*(m-1)+1:2*(m-1)+2) + int(int(Klm,y,0,1),x,0,1);
    end
end