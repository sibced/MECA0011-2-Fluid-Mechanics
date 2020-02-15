
function [u,v,U] = velocity(num, dom, cl, h)

psi = Laplacien(num, dom, cl);
u = zeros(size(psi));   %composante horizontale de vitesse
v = zeros(size(psi));   %composante verticale de vitesse
U = zeros(size(psi));   %norme de vitesse
[nbr_lignes, nbr_colonnes]  = size(psi);

for i = 2:nbr_lignes - 1 
    for j = 2:nbr_colonnes - 1
        v(i,j) = -deriv(psi(i-1,j),psi(i,j),psi(i+1,j),dom(i-1,j),dom(i,j),dom(i+1,j),h);
        u(i,j) = deriv(psi(i, j-1), psi(i,j), psi(i,j+1), dom(i,j-1), dom(i,j), dom(i,j+1),h); 
        U(i,j) = sqrt(u(i,j)^2 + v(i,j)^2);
    end
end

end
