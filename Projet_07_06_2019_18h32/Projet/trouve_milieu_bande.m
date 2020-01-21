function vec_mil=trouve_milieu_bande(I_open)

    [h,w]=size(I_open);

    figure()
    subplot(121)
    hold on
    [mean_r,mean_g,mean_b]=moyenne_colonne_matrix(I_open);
    plot(1:length(I_open(1,:,1)),mean_r,'r');
    plot(1:length(I_open(1,:,1)),mean_g,'g');
    plot(1:length(I_open(1,:,1)),mean_b,'b');
    title('Moyenne r g b')

    subplot(122)
    hold on
    gradient_r=gradient(mean_r);
    gradient_g=gradient(mean_g);
    gradient_b=gradient(mean_b);
    plot(1:length(I_open(1,:,1)),gradient_r,'r');
    plot(1:length(I_open(1,:,1)),gradient_g,'g');
    plot(1:length(I_open(1,:,1)),gradient_b,'b');
    title('gradient r g b')


    figure()
    subplot(121)
    hold on
    I_open_hsv = rgb2hsv(I_open);
    [mean_h,mean_s,mean_v]=moyenne_colonne_matrix(I_open_hsv);
    

    plot(1:length(I_open(1,:,1)),mean_h,'r');
    plot(1:length(I_open(1,:,1)),mean_s,'g');
    plot(1:length(I_open(1,:,1)),mean_v,'b');
    title('Moyenne h s v')
    


    subplot(122)
    hold on
    gradient_h=gradient(mean_h);
    gradient_s=gradient(mean_s);
    gradient_v=gradient(mean_v);
    
    plot(1:length(I_open(1,:,1)),gradient_h,'r');
    plot(1:length(I_open(1,:,1)),gradient_s,'g');
    plot(1:length(I_open(1,:,1)),gradient_v,'b');
    title('gradient h s v')
    
    
    figure()
    
    subplot(211)
    grad_tot = abs(gradient_r) + abs(gradient_g) + abs(gradient_b) + abs(gradient_h) + abs(gradient_s) +abs(gradient_v);
    plot(1:length(I_open(1,:,1)),grad_tot,'k');
    title('somme des gradient r g b h s v')
    
    seuille=zeros(1,length(grad_tot));

%     for k=1:length(gradient_s)
%         if (abs(gradient_s(k))>=(0.1*max(gradient_s)))&&(abs(gradient_b(k))>=0.01) 
%             seuille(k)=1;
%         %elseif ((abs(gradient_b(k))>=0.01)&&(abs(gradient_g(k))>=0.01)

%         else
%             seuille(k)=0;
%         end
%     end

   for k=1:length(grad_tot)
        if (abs(grad_tot(k)))>=0.13
            seuille(k)=1;
        elseif (abs(grad_tot(k))>=0.03)&&(abs(gradient_b(k))>=0.01)&&(abs(gradient_s(k))>=0.02)
            seuille(k)=1;
        else
            seuille(k)=0;
        end
   end
   plot(1:length(I_open(1,:,1)),abs(grad_tot),'k');
   title('abs somme des gradients r g b h s v')
   hold on;
   subplot(212)
   plot(1:length(I_open(1,:,1)),seuille,'b');
   title('seuil obtenu')


    check=1;
    for k=1:length(seuille)
        if check==1
            if seuille(k)==1
                check=0;
                cpt=0;
            end
        else
            if seuille(k)==1
                seuille(k)=0;
            end
            if cpt==floor(0.05*length(seuille))
                cpt=0;
                check=1;
            end
            cpt=cpt+1;
        end
    end

    vec_col=find(seuille);
    vec_mil=zeros(1,length(vec_col)/2);
    for k=1:length(vec_col)
        if mod(k,2)==0
            vec_mil(k/2)=round((vec_col(k-1)+vec_col(k))/2);
        end
    end

    figure()
    imshow(I_open,[]);
    title('resistance avec bandes delimitées')
    for k=1:length(seuille)
        if seuille(k)==1
            figure(17)
            hold on
            plot([k,k],[1,h],'r')
        end
    end
end
