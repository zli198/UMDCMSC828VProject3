function [output] = pca(data,dim)
coeff = pca(data);
W = coeff(:, 1:dim);
output = data*W;
end