%fonction qui renvoie vecteur colonne des pressions 
%(classées selon l'ordre de parcours des noeuds)

function p = pressure(U)

[nbx, nby] = size(U);
p = zeros(nbx, nby); 

rho=1000;
g=9.81;
C=0;
mu=1/(2*g);

% Calcul des pressions pour chaque noeud MATRICE :
for i=2:nbx-1
    for j=2:nby-1
        p(i,j) = rho*g*(C-mu*(U(i,j)^2));
    end
end

end