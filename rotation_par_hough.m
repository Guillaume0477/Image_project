%% I) Detection des droites 
%lecture de l'image

clear all;close all;clc
%IMG_20190607_134944
I_couleur=im2double(imread('im18.jpg')); % On charge l'image et la convertit en double
I_gris=rgb2gray(I_couleur); % Conversion image rgb en gray
[N1,N2]=size(I_gris);
% I_gris=I_gris(round(N1/2)-500:round(N1/2+500),round(N2/2)-500:round(N2/2)+500);
figure(1)
subplot(131)
imshow(I_gris)
title('Image originale')
%% definition des paramètres de l'algorithme

dtheta=0.04; % Pas du paramètre theta
nb_ligne=0250; % Nombre de lignes horizontales
seuil=0.99; % Seuil 

%% creation de l'image des contours

[Gmag,Gdir]=imgradient(I_gris); %gradient de l'image
Gmag=Gmag.*(1/max(max(Gmag)));
im_contours = edge(I_gris,'Canny'); %Contours de l'image
subplot(132)
imshow(im_contours,[]);
title('Contours de l image par la méthode edge');
subplot(133)
imshow(Gmag,[]);
title('Gradient de l image')

%% Calcul de la matrice d'accumulation

rho_max=sqrt(((N1-1)^2)+((N2-1)^2)); % Calcul du rho max
nb_col=ceil(pi/dtheta); %nb_col genere selon dtheta
H=zeros(nb_ligne,nb_col); %Initialisation de la matrices d'accumulation

drho=2*rho_max/nb_ligne; %Calcul du pas du rho
theta=0:dtheta:pi; %Calcul du vecteur de theta
vec_ro=zeros(1,length(theta)); %Initailisation du vecteur des rho
[h,w]=size(H);

for l=1:N1 %Parcourt les lignes
    for c=1:N2 %Parcourt les colonnes
        if (Gmag(l,c)>0.5) %Si le point est un contours
            vec_ro=c*cos(theta)+l*sin(theta); %Calcul du rho de chaque droite du point
            for col=1:length(theta) %Parcourt les theta
                lig=round((vec_ro(col)+rho_max)/drho); %calcul la ligne du nouveau point de la matrice
                if (lig>h)
                    lig=h;
                end
                H(lig,col)=H(lig,col)+1; %itere la case de la matrice correspondant à la droite
            end
            %plot(theta,vec_ro,'r')
        end
    end 
end
figure(3)
subplot(211)
imagesc(H) %Affiche la matrice d'accumulation
xlabel('\theta (echelle 1:1000)')
title(['Matrice d accumulation pour nb ligne=',num2str(nb_ligne),' et dtheta=',num2str(dtheta)]) 
%% Calcul des maxima locaux 

%seuillage
H=H/max(max(H)); %Normalisation de la matrice d'accumulation
H(H<seuil)=0; %Seuillage de la matrice dependant du seuil en parametre
H(H>=seuil)=1;
subplot(212)
imagesc(H)
xlabel('\theta (echelle 1:1000)')
title(['Matrice d accumulation seuillee pour seuil=',num2str(seuil)])
%% Calcul des points extrémaux

theta_tab=0;
figure(5)
imshow(I_gris)
for l=1:nb_ligne %Parcourt les lignes
    for c=1:nb_col %Parcourt les colonnes
        if (H(l,c)==1) %Si on tombe sur un des point de la matrice seuillee
            rho=(l-1)*drho-rho_max; %On recalcule le theta et le rho de la droite correspondante
            theta=(c-1)*dtheta; 
            theta_tab=[theta_tab,theta];
            if theta==0 %si c'est une droite verticale
                x_min=rho;
                x_max=rho;
                y_min=0;
                y_max=N1;
            else %sinon
                %disp(theta/pi);
                x_max=N2; %On travaille sur les bords verticaux de l'image
                x_min=0;
                y_min=(rho-x_min*cos(theta))/sin(theta); %On calcule les points en
                y_max=(rho-x_max*cos(theta))/sin(theta); %x=0 et x=xmax
            end
            hold on
            plot([x_min x_max],[y_min y_max])

        end
    end
end
hold on
title(['Image finale pour dtheta=',num2str(dtheta),', nb ligne=',num2str(nb_ligne),'et seuil=',num2str(seuil)])
axis([0 N2 0 N1])

%% rotation

theta_moy=mean(theta_tab(2:length(theta_tab)));
I_rotate=imrotate(I_couleur,(theta_moy*(180/pi))-90);
figure(6)
imshow(I_rotate)

%% anti reflet

SE=strel('square',8);
I_rotate_sans_reflet(:,:,1)=imopen(I_rotate(:,:,1),SE);
I_rotate_sans_reflet(:,:,2)=imopen(I_rotate(:,:,2),SE);
I_rotate_sans_reflet(:,:,3)=imopen(I_rotate(:,:,3),SE);
figure(7)
imshow(I_rotate_sans_reflet,[])

I_rotatehsv = rgb2hsv(I_rotate_sans_reflet);

figure(8)
imshow(I_rotatehsv,[])

%% zoom sur resistance

[x_min,x_max,y_min,y_max] = zoom_sur_resistance(I_rotate_sans_reflet);

im_resistance_zoom = I_rotate_sans_reflet(x_min:x_max, y_min:y_max ,:);
figure(12)
imshow(im_resistance_zoom,[]);


%% boost couleur

% I_rotate(:,:,1)=I_rotate(:,:,1)*2;
% I_rotate(:,:,2)=I_rotate(:,:,2)*2;
% I_rotate(:,:,3)=I_rotate(:,:,3)*2;
% figure(8)
% imshow(I_rotate)

%% snake

%I_snake=I_rotate(2485:2580,1882:2114,:);%1
% I_snake=I_rotate(2485:2580,1882:2114,:);%2
% I_snake=I_rotate(2485:2580,1882:2114,:);%3
% I_snake=I_rotate(2485:2580,1882:2114,:);%4
% I_snake=I_rotate(2485:2580,1882:2114,:);%5
% I_snake=I_rotate(2485:2580,1882:2114,:);%6
%I_snake=I_rotate(2480:2547,2072:2319,:);%7
% I_snake=I_rotate(2485:2580,1882:2114,:);%8
%I_snake=I_rotate(2350:2429,1660:1898,:);%9
% I_snake=I_rotate(2485:2580,1882:2114,:);%10
%I_snake=I_rotate(2193:2264,2125:2363,:);%11
% I_snake=I_rotate(2485:2580,1882:2114,:);%12
% I_snake=I_rotate(2485:2580,1882:2114,:);%13
% I_snake=I_rotate(2485:2580,1882:2114,:);%14
% I_snake=I_rotate(2485:2580,1882:2114,:);%15
% I_snake=I_rotate(2485:2580,1882:2114,:);%16
%I_snake=I_rotate(2251:2320,1811:2067,:);%17
% I_snake=I_rotate(2485:2580,1882:2114,:);%18
% I_snake=I_rotate(2485:2580,1882:2114,:);%19
%I_snake=I_rotate(18:1945,2308:2574,:);%20
% I_snake=I_rotate(2485:2580,1882:2114,:);%21
% I_snake=I_rotate(2485:2580,1882:2114,:);%22
%I_snake=I_rotate(1938:2020,2437:2689,:);%23
% I_snake=I_rotate(2485:2580,1882:2114,:);%24
% I_snake=I_rotate(2485:2580,1882:2114,:);%25

% 
% [hs,ws]=size(I_snake(:,:,1));
% figure(9)
% c_avant = I_snake(1,1,1);
% imshow(I_snake,[]);
% 



%% compter bandes 
% 
% 
% 
% figure(10)
% 
% hold on
% [mean_1,mean_2,mean_3]=moyenne_colonne_matrix(I_snake);
% 
% subplot(231)
% plot(mean_1,'r');
% subplot(232)
% plot(mean_2,'g');
% subplot(233)
% plot(mean_3,'b');
% 
% subplot(231)
% r=(mean(mean_1(144:183)))
% subplot(232)
% g=(mean(mean_2(144:183)))
% subplot(233)
% b=(mean(mean_3(144:183)))
% 
% legend('r','g','b');
% 
% hold on
% I_snakehsv = rgb2hsv(I_snake);
% [mean_11,mean_22,mean_33]=moyenne_colonne_matrix(I_snakehsv);
% 
% subplot(234)
% plot(mean_1,'r');
% subplot(235)
% plot(mean_2,'g');
% subplot(236)
% plot(mean_3,'b');
% 
% subplot(234)
% h=(mean(mean_11(144:183)))
% subplot(235)
% s=(mean(mean_22(144:183)))
% subplot(236)
% v=(mean(mean_33(144:183)))
% legend('h','s','v');
% 
% figure(11)
% imshow(I_snake(:,:,:),[]);
% 
% figure(12)
% imshow(I_snakehsv(:,:,:),[]);

