function R = rotation_euler(angles)
    
    
    a = angles(1);
    b = angles(2);
    c = angles(3);
    
    A = [cos(a) -sin(a) 0; sin(a) cos(a) 0; 0 0 1];
    B = [cos(b) 0 sin(b); 0 1 0; -sin(b) 0 cos(b)];
    C = [1 0 0; 0 cos(c) -sin(c); 0 sin(c) cos(c)];
    
    R = A * B * C;   
end