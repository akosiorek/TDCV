function p = get_patch(I, x, y, s)
   
    p = I(y:y+s(1)-1, x:x+s(2)-1);
    
end