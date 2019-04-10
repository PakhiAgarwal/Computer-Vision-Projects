function coordinate = findVertices(normal,basis,center,length)
% This function finds the vertices of the cube in real-world coordinate.
% Inputs: normal, is the normal (column) vector of the planar surface
% basis, is a 3x2 matrix, where the 2 column vectors form an orthonormal basis of the plane
% center, is a column vector where the origin of the local coordinate locates.
% length, is a scalar that determines the length of the cube.

% Outputs: coordinate, is a 6x3 matrix, where each row is the 3D coordinate of a vertex of the cube.

% First, determine the 3 unit directional vector of the local coordinate in terms of real-world coordinate.
u_z = normal';
u_x = basis(:,1)';
% u_x = u_x/norm(u_x);
u_y = basis(:,2)';
% u_y = u_y/norm(u_y);

% Find the coordinate of the vertices in local coordinate.
vertices = [
    length,length,0;
    length,-length,0;
    -length,-length,0;
    -length,length,0;
    length,length,2*length;
    length,-length,2*length;
    -length,-length,2*length;
    -length,length,2*length;
    ];
coordinate = zeros(8,3);

% transform the vertices to real-world coordinate, which is done by summing up the proper multiple of the orthonormal basis vectors and translating according to the center.
for i = 1:8
    coordinate(i,:) = center + vertices(i,1)*u_x + vertices(i,2)*u_y + vertices(i,3)*u_z;
end
