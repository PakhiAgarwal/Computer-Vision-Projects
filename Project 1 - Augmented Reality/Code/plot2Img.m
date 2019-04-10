function plot2Img(fig,vertices,rotM,trans,pixelCenter,focalLength,width,height)

% This function plots the cube to the original image.
% Inputs: fig, is the figure to plot in;
% vertices, is a 6x3 matrix, where each row contains a vertex;
% rotM, is a 3x3 rotation matrix for this image;
% trans, is a column translation vector for this image
% pixelCenter, is a row vector denoting the pixel index of the image center;
% focalLength, is a scalar value denoting the focal length of this camera model;
% width and length, are scalar values that denote the number of pixels in width and in length.


vertices_pix = zeros(8,2);
depth_vertex = zeros(8,1);
for i = 1:size(vertices,1)
    % First transform the real-world coordinate to camera coordinate, and record the depth of the vertex
    vertices_c = (-rotM*vertices(i,:)' - trans')';
    depth_vertex(i) = vertices_c(3);
    % transform the camera coordinate to film coordinate
    vertices_f = focalLength*(vertices_c/vertices_c(3));
    % transform film coordinate to pixel coordinate
    vertices_pix(i,:) = pixelCenter + vertices_f(1,1:2);
end
% determine the depth of each surface
depth_surf = zeros(6,1);
surf = [
    1 2 3 4;
    1 2 6 5;
    1 5 8 4;
    2 6 7 3;
    4 3 7 8;
    5 6 7 8;
    ];
for i = 1:6
    depth_surf(i) = min([depth_vertex(surf(i,1)),depth_vertex(surf(i,2)),depth_vertex(surf(i,3)),depth_vertex(surf(i,4))]);
end
% sort the depth of each surface and draw the surfaces in deep to shallow order.
[~,depth_surf_order] = sort(depth_surf,'descend');
figure(fig)
for i = 1:6
    p1 = vertices_pix(surf(depth_surf_order(i),1),:);
    p2 = vertices_pix(surf(depth_surf_order(i),2),:);
    p3 = vertices_pix(surf(depth_surf_order(i),3),:);
    p4 = vertices_pix(surf(depth_surf_order(i),4),:);

    x = [p1(1) p2(1) p3(1) p4(1)];
    y = [p1(2) p2(2) p3(2) p4(2)];
%     z = [p1(3) p2(3) p3(3) p4(3)];

    fill(x,y,1);
end

