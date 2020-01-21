function [mean_R,mean_G,mean_B,mean_H,mean_S,mean_V]=moyenne_colonne_matrix_rgb_hsv(img_rgb,img_hsv,position)

        mean_R=mean(img_rgb(:,position,1));
        mean_G=mean(img_rgb(:,position,2));
        mean_B=mean(img_rgb(:,position,3));
        mean_H=mean(img_hsv(:,position,1));
        mean_S=mean(img_hsv(:,position,2));
        mean_V=mean(img_hsv(:,position,3));
end