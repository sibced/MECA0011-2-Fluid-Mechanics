function vect = transfo(mat) 

    vect = [mat(91,16:38), mat(92:113, 38)'];
    v_interm = [mat(91:113,16)' , mat(113, 17:37)];
    v_interm = v_interm(end:-1:1);
    vect = [vect, v_interm];
    vect = vect';

end