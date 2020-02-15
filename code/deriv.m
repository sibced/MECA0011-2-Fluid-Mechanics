% Calcul des vitesses 


function v = deriv(f_left, f_c, f_right, type_left, type_c, type_right, h)

v = NaN;

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