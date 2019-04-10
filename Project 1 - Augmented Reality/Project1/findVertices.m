function coordinate = findVertices(B,P,center,length)

u_z = B(1:3)';
u_x = P(2,:) - P(1,:);
u_x = u_x/norm(u_x);
u_y = cross(u_x,u_z);
u_y = u_y/norm(u_y);

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
for i = 1:8
    coordinate(i,:) = center + vertices(i,1)*u_x + vertices(i,2)*u_y + vertices(i,3)*u_z;
end