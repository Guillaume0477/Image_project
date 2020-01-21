function I_tophat=tophat_image_couleur(Img,forme_se,taille_se)
    SE=strel(forme_se,taille_se);
    I_gray=rgb2gray(Img);
    I_tophat_gray=imtophat(I_gray,SE);
    I_tophat = ind2rgb(I_tophat_gray, colormap);
    imshow(I_tophat,[])
end