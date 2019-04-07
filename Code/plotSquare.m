function plotSquare(vertices,f)

figure(f)
hold on

p1 = vertices(1,:);
p2 = vertices(2,:);
p3 = vertices(3,:);
p4 = vertices(4,:);

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

fill3(x,y,z,1);

p1 = vertices(1,:);
p2 = vertices(2,:);
p3 = vertices(6,:);
p4 = vertices(5,:);

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

fill3(x,y,z,1);

p1 = vertices(1,:);
p2 = vertices(5,:);
p3 = vertices(8,:);
p4 = vertices(4,:);

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

fill3(x,y,z,1);

p1 = vertices(2,:);
p2 = vertices(6,:);
p3 = vertices(7,:);
p4 = vertices(3,:);

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

fill3(x,y,z,1);

p1 = vertices(4,:);
p2 = vertices(3,:);
p3 = vertices(7,:);
p4 = vertices(8,:);

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

fill3(x,y,z,1);

p1 = vertices(5,:);
p2 = vertices(6,:);
p3 = vertices(7,:);
p4 = vertices(8,:);

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

fill3(x,y,z,1);