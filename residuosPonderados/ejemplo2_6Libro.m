clear all;close all;
M=4;
N=@(x,m) x.^m;
W=@(x,l) x.^l;
epsilon = 1E-8;

%dW = @(x,m) (W(x+epsilon,m)-W(x-epsilon,m))/(2*epsilon); %derivacion numerica Orden²
%dN = @(x,m) (N(x+epsilon,m)-N(x-epsilon,m))/(2*epsilon); %idem dW

dW = @(x,m) m.*x.^(m-1);
dN = dW;

Wat1=@(m) W(1,m);

K = zeros(M,M);
f = zeros(M,1);

for l = 1:M
    for m = 1:M
        I1 = integral(@(x) dW(x,l).*dN(x,m), 0, 1);
        I2 = integral(@(x) W(x,l).*N(x,m), 0, 1);
        K(l,m) = I1+I2; %Integracion numerica recomendad por MatLab
    end
    f(l) = Wat1(l)*20;
end

a = K\f;

phi = @(x) a(1:M).*N(x,1:M)';
dphi = @(x) a(1:m).*dN(x,1:M)';

x = 0:0.1:1;

phi_q = zeros(size(x));
dphi_q = zeros(size(x));

for i = 1:length(x)
    phi_q(i) = sum(phi(x(i)));
    dphi_q(i) = sum(dphi(x(i)));
end

plot(x,phi_q);
