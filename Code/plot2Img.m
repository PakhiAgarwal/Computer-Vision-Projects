function plot2Img(fig,vertices,rotM,trans,pixelCenter,focalLength,width,height)

vertices_pix = zeros(8,2);
depth_vertex = zeros(8,1);
for i = 1:size(vertices,1)
    vertices_c = (-rotM*vertices(i,:)' - trans')';
    depth_vertex(i) = vertices_c(3);
    vertices_f = focalLength*(vertices_c/vertices_c(3));
    
%     vertices_f(1:2) = vertices_f(1:2)./([width height]);
    vertices_pix(i,:) = pixelCenter + vertices_f(1,1:2);
end
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