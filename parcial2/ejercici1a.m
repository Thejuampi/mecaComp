k=1;
f=1;
v=100;
h=10;
phi_inf=1;
phi0 = 0;
dx = 1/5;
dt = dx^2;
Vj = dx;
K=zeros(5,5);
a=zeros(5,1);


K(1,1) = 3*Vj/2/dt + 3*k/dx + v/2 ;
K(1,2) = v/2 - k/dx;

for j = 2:4
   K(j,j-1) = -v/2 + k / dx;
   K(j,j)   = 3*Vj/(2*dt) + 2*k/dx;
   K(j,j+1) = v/2 - k/dx;
end

K(5,4) = -v/2 -k/dx;
K(5,5) = 3*Vj/(2*dt) + 2*k/dx;

K