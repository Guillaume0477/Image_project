function [mean_1,mean_2,mean_3]=moyenne_colonne_matrix(img)
        mean_1=mean(img(:,:,1));
        mean_2=mean(img(:,:,2));
        mean_3=mean(img(:,:,3));
end