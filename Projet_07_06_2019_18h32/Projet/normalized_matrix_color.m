function I_normalized=normalized_matrix_color(Img)
    I_normalized=Img/(max(max(max(Img))));
end