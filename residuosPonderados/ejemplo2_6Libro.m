clear all;close all;
M=3;
N=@(x,m) x.^m;
W=N;
epsilon = 1E-8;

dW = @(x,m) (W(x+epsilon,m)-W(x-epsilon,m))/(2*epsilon); %derivacion numerica Orden²
dN = @(x,m) (N(x+epsilon,m)-N(x-epsilon,m))/(2*epsilon); %idem dW

Wat1=@(m) W(1,m);

K = zeros(M,M);
f = zeros(M,1);

for l = 1:M
    for m = 1:M
        K(l,m) = integral(@(x) dW(x,l).*dN(x,m) + W(l,x).*N(m,x), 0, 1); %Integracion numerica recomendad por MatLab
    end
    f(l) = Wat1(l)*20;
end

a = K\f;

disp(a);