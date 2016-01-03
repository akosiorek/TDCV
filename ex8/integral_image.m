function I = integral_image(img)
   
    Y = size(img, 1);
    X = size(img, 2);


    I = zeros(size(img));
    I(1, 1, :) = img(1, 1, :);

    for y = 2:Y
        I(y, 1, :) = I(y-1, 1, :) + img(y, 1, :);
    end

    for x = 2:X
        I(1, y, :) = I(1, x-1, :) + img(1, x, :);
    end

    for y = 2:Y
        y_sum = img(y, 1, :);
        for x = 2:X
            y_sum = y_sum + img(y, x, :);
            I(y, x, :) = y_sum + I(y-1, x, :);
        end
    end
end