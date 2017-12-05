function [ predicted_digit ] = printedDigitRecognize(projection_train,test_image, basis, labels, mu)

    test_image_column = test_image(:);
    centered_test_image = test_image_column - mu;
    projection_image = transpose(basis) * centered_test_image;
    distance_squared = sum((projection_train - projection_image).^2);
    nearest = find(distance_squared==min(distance_squared));
    predicted_digit =  labels(nearest,1);
    
end