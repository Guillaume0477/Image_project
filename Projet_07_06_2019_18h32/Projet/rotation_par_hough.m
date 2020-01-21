function [I_rotate]=rotation_par_hough(nom_image,dtheta,nb_ligne,seuil)

% I_couleur=im2double(imread(nom_image)); % On charge l'image et la convertit en double
I_gris=rgb2gray(nom_image); % Conversion image rgb en gray
[N1,N2]=size(I_gris);
% I_gris=I_gris(round(N1/2)-500:round(N1/2+500),round(N2/2)-500:round(N2/2)+500);
figure()
subplot(121)
imshow(I_gris)
title('Image originale')
%% creation de l'image des contours

[Gmag,Gdir]=imgradient(I_gris); %gradient de l'image
Gmag=Gmag.*(1/max(max(Gmag)));
subplot(122)
imshow(Gmag,[]);
title('Gradient de l image')

%% Calcul de la matrice d'accumulation

rho_max=sqrt(((N1-1)^2)+((N2-1)^2)); % Calcul du rho max
nb_col=ceil(pi/dtheta); %nb_col genere selon dtheta
H=zeros(nb_ligne,nb_col); %Initialisation de la matrices d'accumulation

drho=2*rho_max/nb_ligne; %Calcul du pas du rho
theta=0:dtheta:pi; %Calcul du vecteur de theta
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
figure()
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
figure()
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
I_rotate=imrotate(nom_image,(theta_moy*(180/pi))-90);
figure()
imshow(I_rotate)
title('Image horizontale')
end