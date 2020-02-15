% Fonction qui renvoie : 
% a le vecteur colonne de coefficients de l'équation du noeud central dans le système linéaire à résoudre
% j le vecteur colonne contenant les numéros de colonnes des coefficients contenus dans a
% b la valeur du terme de droite de l'équation.


function [j, a, b] = getCoeff(num_left, num_right, num_down, num_up, num_cent, type_cent, cl_cent)

j=zeros(5,1);
a=zeros(5,1);
b = 0; 

if type_cent == 1
    
    a = ones(4,1); 
    a(5,1) = -4; 
    j = [num_left; num_right; num_down; num_up; num_cent]; 
end

if type_cent == 2
    
    a = 1;
    j = num_cent; 
    b = cl_cent; 
end 


end 

