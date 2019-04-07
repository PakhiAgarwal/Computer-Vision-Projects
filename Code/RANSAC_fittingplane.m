function [B,P,inliers] = RANSAC_fittingplane(X,varargin)

numSamp = size(X,1);
if numSamp < 3
    error('Not enough points to fit a plane');
end
delta = 1;
maxIter = 5000;
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
    batch = X(randsample(numSamp,3),:);
    if isColinear(batch)
        continue
    end
    plane_coeff = fitplane(batch);
    
    dist = (X*plane_coeff(1:3) - plane_coeff(4)).^2;
    inlier = dist < delta;
    if sum(inlier == 1) > max_num_inlier
        max_num_inlier = sum(inlier == 1);
        inlier_list = inlier;
        out_plane_coeff = plane_coeff;
        P = batch;
    end
end

B = out_plane_coeff;
inliers = inlier_list;


function P = fitplane(X)

normal = cross(X(2,:) - X(1,:), X(3,:) - X(1,:));
normal = normal'/norm(normal);

d = X(1,:)*normal;
P = [normal;d];

function r = isColinear(X)

tempX = [X(2,:)-X(1,:);X(3,:)-X(1,:)];
r = rank(tempX) < 2;