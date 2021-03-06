clear all
close all
X = csvread('point3D.csv');

f1 = figure;

plot3(X(:,1),X(:,2),X(:,3),'bo');
hold on

[normal,basis,inliers] = RANSAC_fittingplane(X,'threshold',0.001,'maxIter',50000);
center = mean(X(inliers,:),1);
plot3(X(inliers,1),X(inliers,2),X(inliers,3),'ro');
plot3(center(1),center(2),center(3),'rx');
length = 0.1;
vertices = findVertices(normal,basis,center,length);

plotSquare(vertices,f1);

cameraFile = csvread('camera.csv');
width = cameraFile(1,2);
height = cameraFile(1,3);
focalLength = cameraFile(1,4);
pixelCenter = cameraFile(1,[5,6]);

imgFile = csvread('images.csv');
numImg = size(imgFile,1);
for img = 1:numImg
    imgName = ['P' num2str(imgFile(img,10)) '.JPG'];
    quat = imgFile(img,2:5);
    Trans = imgFile(img,6:8);
    rotM = quat2rotm(quat);
    
    f = figure;
    img_temp = imread(imgName);
    imshow(img_temp);
    hold on
    plot2Img(f,vertices,rotM,Trans,pixelCenter,focalLength,width,height);
end
