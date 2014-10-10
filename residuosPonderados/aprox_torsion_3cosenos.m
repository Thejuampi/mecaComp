% pasar el vector 'a' de tres componentes
% x, y deben ser del mismo tamaño
function phi = aprox_torsion_3cosenos(a,x,y)
    [X, Y] = meshgrid(x,y);
    if length(a) > 3 
        a = a(1:3);
    else
        disp('Pasame bien el a, porque sino no ando');
        return;
    end
    if size(x) ~= size(y)
        disp('size(x) ~= size(y)');
        return;
    end
    phi = a(1)*cos(pi*X/6).*cos(pi*Y/4) + a(2)*cos(3*pi*X/6).*cos(pi*Y/4) + a(3)*cos(pi*X/6).*cos(3*pi*Y/4);
    surf(X,Y,phi);
end