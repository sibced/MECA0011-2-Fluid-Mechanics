
function matPhi = Laplacien(num, dom, cl)


%%%%%%%%%%      Remplissage de A et b       %%%%%%%%%%%%%

% création des vecteurs ligne, colonne, valeurs de même taille
ligne = [];
colonne = [];
valeur = []; 

M = max(max(num)); % taille de A : M * M 
 % membre de droite du syst

[nbr_lignes, nbr_colonnes]  = size(num); 

for i=2:nbr_lignes-1
    
    for j=2:nbr_colonnes-1
       
       if (num(i,j) ~= 0) 
       [j_, a_, b_] = getCoeff(num(i, j-1), num(i, j+1), num(i+1, j), num(i-1, j), num(i,j), dom(i,j), cl(i,j));
       
       if dom(i,j) == 1
           ligne = [ligne; num(i,j); num(i,j); num(i,j); num(i,j); num(i,j)];
       
       else 
           ligne = [ligne; num(i,j)];
       end
       
       colonne = [colonne; j_]; 
       valeur = [valeur; a_]; 
       
       b(num(i,j), 1) = b_;  
       end 
      
       
    end
end
       

A = sparse(ligne, colonne, valeur); 

%%%%%%%%%%      Résolution du système        %%%%%%%%%%%%%

phi = A\b;

%%%%%%%%%%      Conversion de Phi en Matrice       %%%%%%%%%%%%%

matPhi = zeros(nbr_lignes, nbr_colonnes);

for i=2:nbr_lignes-1

    for j=2:nbr_colonnes-1
        if (num(i,j) ~= 0) 
        indice = num(i,j); 
        matPhi(i,j) = phi(indice);
        end
    end 
end 

end 