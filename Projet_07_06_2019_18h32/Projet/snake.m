function [x_snake,y_snake]=snake(img,alpha,beta,gamma,I,centre_x,centre_y,a,b,K)

% %% Parametres
% alpha=12; %parametre qui resserre le cercle
% beta=1; %parametre qui fait ressembler le snake a un cercle/raideur 
% gamma=6;%Parametre qui donne a quel point le snake se colle aux contours
% 
% I = 1000; % Nombre d'iteration
% %coordonnees de l'ovale initial du snake
% centre_x = 500;
% centre_y = 500;
% a = 120;
% b = 120;
% K = 500; %Nombre de points du snake
%% Chargement de l'image
%Import de l'image 
img=rgb2gray(img);
[h,w]=size(img);
% img=ones(size(img));

%% Initialisation du snake
%Parametres du snake
theta=0:(2*pi)/K:2*pi-((2*pi)/K);

x_snake=((a*cos(theta))+centre_x)';
y_snake=((b*sin(theta))+centre_y)';

% Calcul des gradients
[gradient_x,gradient_y] = imgradientxy(img); %gradient x et y de l'image
gradient_norme = sqrt(gradient_x.^2+gradient_y.^2);% norme du gradient de l'image
gradient_norme=gradient_norme*(255/(max(max(gradient_norme))-min(min(gradient_norme))));
% gradient_norme=gradient_norme*1000;

D2= full(spdiags(bsxfun(@times,ones(K,1),[1 1 -2 1 1]),[-K+1 -1 0 1 K-1],K,K));
D4= full(spdiags(bsxfun(@times,ones(K,1),[-4 1 1 -4 6 -4 1 1 -4]),[-K+1 -K+2 -2 -1 0 1 2 K-2 K-1],K,K));
D = alpha*D2-beta*D4;  %Creation de la matrice D selon la formule
A=inv(eye(K)-D); %Matrice A selon theorie

[gradient_Eimage_x,gradient_Eimage_y] = imgradientxy(gradient_norme); %gradient x et y de l'image
gradient_Eimage_x=gradient_Eimage_x./(max(max(gradient_Eimage_x))+1e-10);%normalisation
gradient_Eimage_y=gradient_Eimage_y./(max(max(gradient_Eimage_y))+1e-10);
%% Affichage initial
figure(7)
subplot(121)
hold on
imshow(img,[])
hold on
plot(x_snake,y_snake,'r')
title('Image originale')
subplot(122)
imshow(gradient_norme,[]);

%% Evolution du snake
gradxx=zeros(K,1);
gradyy=zeros(K,1);
cpt_fig=0;
% figure(15)
for i=1:I
    for k=1:K
        gradxx(k)= gamma*gradient_Eimage_x(ceil(y_snake(k))+1,ceil(x_snake(k)));
        gradyy(k)= gamma*gradient_Eimage_y(ceil(y_snake(k))+1,ceil(x_snake(k)));
    end
    old_x_snake=x_snake;
    x_snake=round(A*(x_snake+gradxx));
    difference=x_snake-old_x_snake;
%     plot(difference);
    y_snake=round(A*(y_snake+gradyy));
    if (mod(i,I/10)==0)
        fig=cpt_fig+8;
        figure(8)
        hold on
        imshow(img,[])
        hold on
        plot(x_snake,y_snake,'r')
        title(['Image originale itération:',num2str(i)])
        cpt_fig=cpt_fig+1;
        pause(1)
    end
end