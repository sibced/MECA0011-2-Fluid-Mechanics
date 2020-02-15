
function [fx,fy] = forces(p,x,y)

fx = 0;
fy = 0; 
global h;

    for i=1:size(p)-1
       
        if x(i+1) > x(i) 
            
            fy = fy + h * ( p(i) + p(i+1) ) / 2;
            

        end
       
        
        if y(i+1) > y(i) 
            
            fx = fx + h * ( p(i) + p(i+1) ) / 2;
            
        end
        
        
        
        if x(i+1) < x(i) 
            
            fy = fy - h * ( p(i) + p(i+1) ) / 2;
            
        end
        
        
        
        if y(i+1) < y(i) 
          
            fx = fx - h * ( p(i) + p(i+1) ) / 2;
            
        end
     
    end 


end 