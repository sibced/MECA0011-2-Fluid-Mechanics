
function [psi,u,v] = submit(which)


if which == 1
    
dom = dlmread('1-dom.txt','\t');
cl = dlmread('1-cl.txt','\t');
num = dlmread('1-num.txt','\t');


[u,v,U] = velocity(num, dom, cl, 0.5);
psi = Laplacien(num, dom, cl);
    
end 


if which == 2 
 
dom = dlmread('2-dom.txt','\t');
cl = dlmread('2-cl.txt','\t');
num = dlmread('2-num.txt','\t');

[u,v,U] = velocity(num, dom, cl, 0.001);
psi = Laplacien(num, dom, cl);
    
end 


if which == 3
   
dom = dlmread('3-dom.txt','\t');
cl = dlmread('3-cl.txt','\t');
num = dlmread('3-num.txt','\t');

[u,v,U] = velocity(num, dom, cl, 0.01);
psi = Laplacien(num, dom, cl);

end


if which == 4
   
dom = dlmread('4-dom.txt','\t');
cl = dlmread('4-cl.txt','\t');
num = dlmread('4-num.txt','\t');

[u,v,U] = velocity(num, dom, cl, 0.01);
psi = Laplacien(num, dom, cl);

end

end





%%%%% COPIES DES AUTRES FONCTIONS UTILES %%%%%% 

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



function [u,v,U] = velocity(num, dom, cl, h)

phi = Laplacien(num, dom, cl);
u = zeros(size(phi));   %composante horizontale de vitesse
v = zeros(size(phi));   %composante verticale de vitesse
U = zeros(size(phi));   %norme de vitesse
[nbr_lignes, nbr_colonnes]  = size(phi);

for i = 2:nbr_lignes - 1 
    for j = 2:nbr_colonnes - 1
        v(i,j) = deriv(phi(i+1, j), phi(i,j), phi(i-1,j), dom(i+1,j), dom(i,j), dom(i-1,j),h);
        u(i,j) = deriv(phi(i, j-1), phi(i,j), phi(i,j+1), dom(i,j-1), dom(i,j), dom(i,j+1),h); 
        U(i,j) = sqrt(u(i,j)^2 + v(i,j)^2);
    end
end

end




%%%%%%%%%%%%


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


%%%%%%%%%%%%%%%


function v = deriv(f_left, f_c, f_right, type_left, type_c, type_right, h)

v = 0;

if type_left ~= 0 && type_right ~= 0
  
   v = (f_right - f_left) / (2*h) ;
    
end

if type_c == 2 && type_left == 0
    
    v = (f_right - f_c)/h;
end

if type_c == 2 && type_right == 0

    v = (f_c - f_left)/h;
    
end


end 

%%%%%

