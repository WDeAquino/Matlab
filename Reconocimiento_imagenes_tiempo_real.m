clc
clear all
cam=webcam;
stop=1;
uicontrol('Style','Pushbutton','String','Close','Callback','stop=0;')
while stop
    data=snapshot(cam);
    diff_im=imsubtract(data(:,:,1),rgb2gray(data));
    diff_im=medfilt2(diff_im,[3 3]);
    diff_im=im2bw(diff_im,0.3);
    diff_im=bwareaopen(diff_im,300);
    bwP=bwlabel(diff_im,8);
    imagen=regionprops(bwP,'BoundingBox','Centroid');
    imshow(data)
    hold on
    for ob=1:length(imagen)
        bb=imagen(ob).BoundingBox;
        bc=imagen(ob).Centroid;
        rectangle('Position',bb,'EdgeColor','r','Linewidth',2)
        plot(bc(1),bc(2),'y*')
        a=text(bc(1),bc(2),strcat('X: ',num2str(round(bc(1))),'Y: ',num2str(round(bc(2)))));
        set(a, 'FontName','Arial','FontWeight','bold','FontSize',12,'Color','yellow');
    end
    hold off
end
clear ('cam');
close all
