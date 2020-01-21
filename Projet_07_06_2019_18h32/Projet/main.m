%% Rotation
clear all;close all;clc;
warning('off','all')

%78 jaune mort,9tropreseré,12normalephotoachier
%1troptordu,2,3,4,5,6,7,8,9,10,11,12photodemerde
Img=imread('IMG_8.jpg');
I_rotate=rotation_par_hough(Img,0.04,250,0.99);


%% anti reflet
figure()
I_open=open_image_couleur(I_rotate,'rectangle',[20,10]);


%% boost couleur

I_open(:,:,1)=I_open(:,:,1)*1.5;
I_open(:,:,2)=I_open(:,:,2)*1.5;
I_open(:,:,3)=I_open(:,:,3)*1.5;
I_open=normalized_matrix_color(I_open);
figure()
imshow(I_open)
title('Image sans reflet')

%% zoom

[x_min,x_max,y_min,y_max] = zoom_sur_resistance(I_open);
I_zoom=I_open(x_min:x_max,y_min:y_max,:);
figure()
imshow(I_zoom,[])
title('Image resistance zoomée')

% [x_snake,y_snake]=snake(I_open,4.5,100,18,1000,2467,1998,200,150,500);
[hs,ws]=size(I_zoom(:,:,1));

%% mettre bon sens

I_zoom_gray=rgb2gray(I_rotate(x_min:x_max,y_min:y_max,:));
I_zoom_seuil=im2bw(I_zoom_gray,0.8);

figure()
subplot(131)
imshow(I_zoom_gray,[])
title('Image zoomée')

SE_sens = strel('rectangle',[6,5]);
I_zoom_seuil=imclose(I_zoom_seuil,SE_sens);
subplot(132)
imshow(I_zoom_seuil,[])
title('Image zoomée seuilée apres fermeture')

I_zoom_seuil=imopen(I_zoom_seuil,SE_sens);


subplot(133)
imshow(I_zoom_seuil,[])
title('Image zoomée seuilée apres ouvertue')

X=find(I_zoom_seuil);
[w,h]=size(I_zoom_seuil);
I_zoom_bs=I_zoom;
if mean(mean(X))<=(h*w)/2 %de droite Ã  gauche
    I_zoom_bs=fliplr(I_zoom);
end
figure()
imshow(I_zoom_bs);
title('Image zoomée dans le bon sens')

%% compter bandes 

vec_mil=trouve_milieu_bande(I_zoom_bs);

%% lecture couleur

I_zoom_hsv=rgb2hsv(I_zoom_bs);

Tableau_couleur=[];

for k=1:length(vec_mil)
    [mean_R,mean_G,mean_B,mean_H,mean_S,mean_V]= moyenne_colonne_matrix_rgb_hsv(I_zoom_bs,I_zoom_hsv,vec_mil(k));
    if k == (length(vec_mil))
        Tableau_couleur=[Tableau_couleur;lecture_couleur([mean_R,mean_G,mean_B,mean_H,mean_S,mean_V],'dernier_bande')];
    else
        Tableau_couleur=[Tableau_couleur;lecture_couleur([mean_R,mean_G,mean_B,mean_H,mean_S,mean_V],'bande')];
    end
end

Tableau_couleur

%figure()
%imshow(I_zoom_bs);

%% Calcul de resistance

res_value = calcul_res_value(Tableau_couleur)



%%





