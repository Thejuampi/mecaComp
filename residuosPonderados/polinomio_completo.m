syms x y real;

grado = 3;
p=[];

for j=0:grado
    for i=0:grado-j
        p = [p x^i*y^j];
    end
end

p = sort(p)