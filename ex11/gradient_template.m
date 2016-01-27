function t = gradient_template(img, x, y, w, h, threshold)
    t = orientation(img(y:y+h, x:x+w, :), threshold);
end