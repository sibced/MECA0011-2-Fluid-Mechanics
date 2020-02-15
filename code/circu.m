
function c = circu(u,v,x,y)

c = 0; 

for i=1:size(u)-1
   
    if x(i+1) > x(i) 
        
        c = c + ( x(i+1) - x(i) ) * ( ( u(i) + u(i+1) ) / 2 ); 

    end
   
    
    if y(i+1) > y(i) 
        
        c = c + ( y(i+1) - y(i) ) * ( ( v(i) + v(i+1) ) / 2 ); 
        
    end
    
    
    if x(i+1) < x(i) 
        
        c = c - ( x(i) - x(i+1) ) * ( ( u(i+1) + u(i) ) / 2 ); 
        
    end
    
    
    if y(i+1) < y(i) 
        
        c = c - ( y(i) - y(i+1) ) * ( ( v(i+1) + v(i) ) / 2 ); 
        
    end
 
end 

end 