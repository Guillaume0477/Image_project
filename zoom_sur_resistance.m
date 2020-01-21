function [x_min,x_max,y_min,y_max] = zoom_sur_resistance(I_rotate_sans_reflet)%ex [jaune , violet, marron, dorree]

figure(8)
I_rotate_seuil = im2bw(I_rotate_sans_reflet,0.68);
imshow(I_rotate_seuil,[]);

I_rotate_seuil = 1 - I_rotate_seuil;


SE_resitance_carre = strel('square',40);
I_rotate_seuil_open=imclose(I_rotate_seuil,SE_resitance_carre);


figure(9)
imshow(I_rotate_seuil_open,[]);

SE_resitance_hauteur = strel('rectangle',[50,10]);
I_rotate_seuil_open=imopen(I_rotate_seuil_open,SE_resitance_hauteur);

I_rotate_seuil_sans_bord = imclearborder(I_rotate_seuil_open);

figure(10)
imshow(I_rotate_seuil_sans_bord,[]);

SE_resitance_largeur = strel('rectangle',[50,50]);
I_rotate_seuil_sans_bord=imopen(I_rotate_seuil_sans_bord,SE_resitance_largeur);

% figure(11)
% imshow(I_rotate_seuil_sans_bord,[]);
% 
% SE_resitance_hauteur2 = strel('rectangle',[50,10]);
% I_rotate_seuil_sans_bord=imopen(I_rotate_seuil_sans_bord,SE_resitance_hauteur2);


figure(11)
imshow(I_rotate_seuil_sans_bord,[]);


[h, w] = size(I_rotate_seuil_sans_bord);
i = 1;
while sum(I_rotate_seuil_sans_bord(i,:)) == 0 && i <= h
    i = i + 1;
end
i_min = i;
while sum(I_rotate_seuil_sans_bord(i,:)) ~= 0 && i <= h
    i = i + 1;
end
i_max = i;

j = 1;
while sum(I_rotate_seuil_sans_bord(:,j)) == 0 && j <= w
    j = j + 1;
end
j_min = j;
while sum(I_rotate_seuil_sans_bord(:,j)) ~= 0 && j <= w
    j = j + 1;
end
j_max = j;

h = i_max -i_min;
w = j_max -j_min;

x_min = i_min+round(0.2*h);
x_max = i_max-round(0.2*h);
y_min = j_min+round(0.1*w);
y_max = j_max-round(0.1*w);




