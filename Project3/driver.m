A=load('ScurveData.mat');
B=load('FaceData.mat');
curve=A.data3;
curveN=A.data3+0.1*randn(size(curve));
face=[B.data3 B.colors];
% 

%{
[~,Y]=pca(curve);
%{
figure;
plot(Y(:,1),0,'.','Markersize',20);
%}
figure;
plot(Y(:,1),Y(:,2),'.','Markersize',20);

[~,Y]=pca(curveN);
%{
figure;
plot(Y(:,1),0,'.','Markersize',20);
%}
figure;
plot(Y(:,1),Y(:,2),'.','Markersize',20);
 
%
[~,Y]=pca(face);
figure;
plot(Y(:,1),Y(:,2),'.','Markersize',20);
figure;
plot3(Y(:,1),Y(:,2),Y(:,3),'.','Markersize',20);

%}
%{
Y = isomap(curve,100,2);
Y = isomap(curveN,100,2);

Y = isomap(face,300,3);
%

%
% lle(singular matrix, if so modify line36 in lle.m as comment)
Y=lle(curve',100,2);
figure;
plot(Y(1,:),Y(2,:),'.','Markersize',20);
Y=lle(curveN',100,2);
figure;
plot(Y(1,:),Y(2,:),'.','Markersize',20);
%
Y=lle(face',100,3);
figure;
plot3(Y(1,:),Y(2,:),Y(3,:),'.','Markersize',20);
%
%
[Y,loss]=tsne(curve,"Algorithm","exact","Perplexity",30,"Exaggeration",4);
fprintf('KL divergence = %d\n',loss);
figure;
plot(Y(:,1),Y(:,2),'.','Markersize',20);


[Y,loss]=tsne(curveN,"Algorithm","exact","Perplexity",30,"Exaggeration",4);
fprintf('KL divergence = %d\n',loss);
figure;
plot(Y(:,1),Y(:,2),'.','Markersize',20);
%}
[Y,loss]=tsne(face,"Algorithm","exact","Perplexity",40,"Exaggeration",10, "NumDimensions",3);
fprintf('KL divergence = %d\n',loss);
figure;
plot3(Y(:,1),Y(:,2),Y(:,3),'.','Markersize',20);
%
%{
Y=diffusionmap(curve,2);
figure;
plot(Y(1,:),Y(2,:),'.','Markersize',20);

Y=diffusionmap(curveN,2);
figure;
plot(Y(1,:),Y(2,:),'.','Markersize',20);


Y=diffusionmap(face,3);
figure;
plot3(Y(1,:),Y(2,:),Y(3,:),'.','Markersize',20);
%}