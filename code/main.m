close all;
clear;


      %%% CHOISIR ICI LE CAS %%% 
        
               cas = 2;

        
global h;

switch cas
    
    case 1
    dom = dlmread('1-dom.txt','\t');
    cl = dlmread('1-cl.txt','\t');
    num = dlmread('1-num.txt','\t');
    h = 0.5;
    
    
    case 2 
    dom = dlmread('2-dom.txt','\t');
    cl = dlmread('2-cl.txt','\t');
    num = dlmread('2-num.txt','\t'); 
    h = 0.001;
    
    
    case 3
    dom = dlmread('3-dom.txt','\t');
    cl = dlmread('3-cl.txt','\t');
    num = dlmread('3-num.txt','\t');
    h = 0.01; 
    
    case 4
    dom = dlmread('4-dom.txt','\t');
    cl = dlmread('4-cl.txt','\t');
    num = dlmread('4-num.txt','\t');
    h = 0.01; 
    
    otherwise 
        disp('ERROR. Cas doit etre = 1, 2, 3 ou 4')
        
end
        

%%% Laplacien
psi = Laplacien(num, dom, cl); 
[nbr_lignes,nbr_colonnes] = size(psi);

%%% Calcul des vitesses
[u,v,U] = velocity(num, dom, cl, h);


%%% Calcul des pressions
p = pressure(U);


%%% MANIP Cas 2
if cas == 2
     for i=2:nbr_lignes-1
         for j=2:nbr_colonnes-1

             if psi(i,j) <= 0.25
                 psi(i,j) = NaN;
                 p(i,j) = NaN; 
             end
         end 
     end 
     
    %limite du corps
    bordure = psi;
     for i=2:nbr_lignes-1
         for j=2:nbr_colonnes-1

             if bordure(i,j) > 0.253 || bordure(i,j) < 0.25
                 bordure(i,j) = NaN;
             end
         end 
     end
end 


 
%%% MANIP Cas 3 

if cas == 3 || cas == 4
     for i=2:nbr_lignes-1
         for j=2:nbr_colonnes-1
             if psi(i,j) == 0
                 psi(i,j) = NaN;
             end
         end 
     end 
end




%%% graphique


[nbx,nby] = size(psi(2:end-1, 2:end-1));
[X,Y] = meshgrid((0:h:(nbx-1)*h),(0:h:(nby-1)*h));

if cas == 2
    subplot(2,1,1)
end
contourf(X,Y,psi(2:end-1, 2:end-1)')
colormap('winter')
shading('interp')
axis('equal')
title('Ecoulement')
xlabel('x') 
ylabel('y') 


if cas == 2
subplot(2,1,2)
hold on
contour(X,Y,p(2:end-1, 2:end-1)','ShowText','on')
pcolor(X,Y,bordure(2:end-1, 2:end-1)')
colormap('winter')
shading('flat')
axis('equal')
title('Fonction de pression')
xlabel('x') 
ylabel('y') 
hold off
end


if cas == 3 || cas == 4    
p_col = transfo(p);
Y_col = transfo(Y');
X_col = transfo(X');
u_col = transfo(u);
v_col = transfo(v); 

    
%%% Calcul des forces
[fx,fy] = forces(p_col, X_col, Y_col)

%%% Calcul de la circulation 
c = circu(u_col, v_col, X_col, Y_col)
end




if cas == 2
%%% Calcul de la distance entre la source et l'isobare 
    
%%% on cherche l'abscisse du a , la source
U = abs(U);
M = max(max(U));
[i,j] = find(U == M);
X_t = X';
a_source = X_t(i,j)


%%% on cherche l'abscisse du point x , l'isobare
U_inf = 4; rho=1000; g=9.81; C=0; mu=1/(2*g);

p_inf = rho*g*(C-mu*(U_inf^2));
p_copy = p - p_inf;

[i,j] = find(abs(p_copy) < 14); %14 = précision la plus petite pour retrouver 1 seule valeur

[nbx,nby] = size(psi);
[X,Y] = meshgrid((0:h:(nbx-1)*h),(0:h:(nby-1)*h));
X_t = X';
x_isobare = X_t(i,j)


%%% distance a et x : 
distance = a_source - x_isobare
end