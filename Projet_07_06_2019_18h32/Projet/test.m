clear all; close all;
figure(1)
subplot(121)
I_couleur=im2double(imread('image_guigui8.jpg')); % On charge l'image et la convertit en double
I_open=open_image_couleur(I_couleur,'square',15);
imshow(I_open)
I_couleur_hsv=rgb2hsv(I_open);
subplot(122)
I_couleur_hsv(:,:,2)=I_couleur_hsv(:,:,2)+0.4;
I_couleur_rgb=hsv2rgb(I_couleur_hsv);
imshow(I_couleur_rgb)