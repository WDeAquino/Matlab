%%Autor: Willinton De Aquino Perez

%%Limpieza de comandos y cierre de cualquier proceso previo
clc;close all;clear all;cam=webcam;stop=1;
%%Boton de Control
uicontrol('Style','Pushbutton','String','Close','Callback','stop=0;')
%%Declaracion del detector
Rostro = vision.CascadeObjectDetector('FrontalFaceCART');
Rostro.MergeThreshold =10;
%%Definicion de 
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]);

while stop
    I = snapshot(cam);
    imshow(I);
    %%Deteccion de rostros
    bbox = step(Rostro, I);
    %%Marca en los rostros encontrados
    I_faces = step(shapeInserter, I, int32(bbox));
    imshow(I_faces);
end

clear ('cam');
close all
