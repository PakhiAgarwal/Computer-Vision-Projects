function [Normal,Basis,inliers] = RANSAC_fittingplane(X,varargin)

% This function performs RANSAC plane fitting task. Input X is a N-by-3 matrix, where N is the number of 3D points. Optional parameters include: ‘threshold’, which sets the threshold for selecting inliers, and ‘maxIter’, which determines the number of iterations.
% The outputs:
% Normal: the unit normal (column) vector of the planar surface
% Basis: a 3x2 matrix, where the two column vectors form an orthonormal basis for the planar surface
% Inliers: a Nx1 indicator vector, where entries with value 1 indicate inlier samples, and 0 denotes outliers.

numSamp = size(X,1);
if numSamp < 3
    error('Not enough points to fit a plane');
end
% Initialize function parameters
delta = 1;
maxIter = 5000;
% read in user-defined parameters
for i = 1:2:size(varargin,2)
    if(strcmp(varargin{i}, 'threshold'))
        delta = varargin{i+1};
    elseif(strcmp(varargin{i}, 'maxIter'))
        maxIter = varargin{i+1};
    end
end

max_num_inlier = 0;
inlier_list = zeros(numSamp,1);
for iter = 1:maxIter
    % At each iteration, randomly select 3 points to form the batch, and skip this iteration if the 3 points are co-linear.
    batch = X(randsample(numSamp,3),:);
    if isColinear(batch)
        continue
    end
    % Find the plane determined by the 3 selected points. 
    plane_coeff = fitplane(batch);
    
    % Compute the distance between all sample points to the surface, and identify the inliers.
    dist = (X*plane_coeff(1:3) - plane_coeff(4)).^2;
    inlier = dist < delta;
    % Update the best candidate if the number of inliers at the current iteration exceeds the previous one.
    if sum(inlier == 1) > max_num_inlier
        max_num_inlier = sum(inlier == 1);
        inlier_list = inlier;
    end
end

% With the inlier list, find the best fitting plane that minimizes the squared error.
inliers = inlier_list;
[Normal,Basis,~] = affine_fit(X(inliers,:));


function P = fitplane(X)
% This function fits the plane on the given 3 3D points.
% To do that, we compute two vectors from the 3 points, and compute the cross product of the two vectors, which will be the normal vector to the plane determined by the 3 points. Then, plug in any of the three points to find the constant that uniquely defines the plane.


normal = cross(X(2,:) - X(1,:), X(3,:) - X(1,:));
normal = normal'/norm(normal); 

d = X(1,:)*normal;
P = [normal;d];

function r = isColinear(X)

tempX = [X(2,:)-X(1,:);X(3,:)-X(1,:)];
r = rank(tempX) < 2;


function [n,V,p] = affine_fit(X)
% This function finds the best-fitting plane given the set of inliers in terms of the squared error criterion. Reference: https://www.mathworks.com/matlabcentral/fileexchange/43305-plane-fit

p = mean(X,1);

R = bsxfun(@minus,X,p);

[V,~] = eig(R'*R);

n = V(:,1);
V = V(:,2:end);
