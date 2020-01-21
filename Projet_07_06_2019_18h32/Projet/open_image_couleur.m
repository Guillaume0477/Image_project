function I_open=open_image_couleur(Img,forme_se,taille_se)
    SE=strel(forme_se,taille_se);
    [h,w]=size(Img(:,:,1));
    I_open=zeros(h,w,3);
    I_open(:,:,1)=imopen(Img(:,:,1),SE);
    I_open(:,:,2)=imopen(Img(:,:,2),SE);
    I_open(:,:,3)=imopen(Img(:,:,3),SE);
    imshow(I_open,[])
end