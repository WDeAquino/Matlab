%%Autor: Willinton De Aquino Perez

%%Limpieza de comandos y cierre de cualquier proceso previo
clc;close all;clear all;cam=webcam;stop=1;
%%Boton de Control
uicontrol('Style','Pushbutton','String','Close','Callback','stop=0;')
%%Carga de imagen de referencia/busqueda
im=imread('I1.jpg');
I1 = rgb2gray(im);
%%Deteccion de Caracteristicas de imagen cargada
I1_P = detectSURFFeatures(I1);
[I1_F,I1_VP] = extractFeatures(I1,  I1_P);
%%Inicio de camara con ciclo while
while stop
    image = snapshot(cam);
    imshow(image);
    I2 = rgb2gray(image);
    %%Deteccion de caracteristicas en la imagen de camara
    I2_P = detectSURFFeatures(I2);
    [I2_F, I2_VP] = extractFeatures(I2, I2_P);
    %%Comparación de caracteristicas entre imagen cargada y de la camara
    index_pairs = matchFeatures(I1_F, I2_F);
    I1_MP = I1_VP(index_pairs(:,1)).Location;
    I2_MP = I2_VP(index_pairs(:,2)).Location;
    %%Definicion de objetos de transformacion geometrica
    if length(I1_MP)&&length(I2_MP)>3
        gte = vision.GeometricTransformEstimator;
        gte.Method = 'Random Sample Consensus (RANSAC)';
        [tform_matrix, inlierIdx] = step(gte, I1_MP, I2_MP);
        ref_inlier_pts = I1_MP(inlierIdx,:);
        I_inlier_pts = I2_MP(inlierIdx,:);
        %%Transformacion de Puntos esquina
        %Muestra donde esta el objeto dentro de la imagen de la camara
        tform = maketform('affine',double(tform_matrix));
        [width, height,~] = size(im);
        corners = [0,0;height,0;height,width;0,width];
        new_corners = tformfwd(tform, corners(:,1),corners(:,2));
        patch(new_corners(:,1),new_corners(:,2),[0 1 0],'FaceAlpha',0.5);
    end
end
clear ('cam');
close all
