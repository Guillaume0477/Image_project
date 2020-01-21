function str_couleurs = lecture_couleur(Tableau_rgb_hsv,str_bande)%ex [0.12 , 0.03 , 0.03 , 0.30 , 0.60 , 0.05]


ref_noir = [0.03 , 0.02 , 0.02 , 0.10 , 0.60 , 0.05];%
ref_marron = [0.16 , 0.06 , 0.03 , 0.04 , 0.84 , 0.16];%
ref_rouge = [0.41 , 0.05 , 0.05 , 0.43 , 0.91 , 0.41];%
ref_orange = [0.60 , 0.24 , 0.09 , 0.05 , 0.84 , 0.60];%
ref_jaune = [0.57 , 0.43 , 0.11 , 0.12 , 0.80 , 0.57];%
ref_vert = [0.04 , 0.20 , 0.09 , 0.38 , 0.85 , 0.24];%
ref_bleu = [0.02 , 0.07 , 0.10 , 0.57 , 0.75 , 0.10];%
ref_violet = [0.12 , 0.07 , 0.15 , 0.77 , 0.53 , 0.15]; %
ref_gris = [0.24 , 0.20 , 0.14 , 0.13 , 0.45 , 0.24];%
ref_blanc = [0.64 , 0.72 , 0.60 , 0.30 , 0.15 , 0.70]; %
ref_dorree = [0.40 , 0.26 , 0.14 , 0.08 , 0.83 , 0.37];%
ref_argente = [2.0 , 2.0 , 2.0 , 2.0 , 2.0 , 2.0];%

Tableau_rgb_hsv_norm = couleur_normaliseur(Tableau_rgb_hsv);

ref_noir_norm = couleur_normaliseur(ref_noir);
ref_marron_norm = couleur_normaliseur(ref_marron);
ref_rouge_norm = couleur_normaliseur(ref_rouge);
ref_orange_norm = couleur_normaliseur(ref_orange);
ref_jaune_norm = couleur_normaliseur(ref_jaune);
ref_vert_norm = couleur_normaliseur(ref_vert);
ref_bleu_norm = couleur_normaliseur(ref_bleu);
ref_violet_norm = couleur_normaliseur(ref_violet) ;
ref_gris_norm = couleur_normaliseur(ref_gris);
ref_blanc_norm = couleur_normaliseur(ref_blanc);
ref_dorree_norm = couleur_normaliseur(ref_dorree);
ref_argente_norm = couleur_normaliseur(ref_argente);


switch str_bande
    case 'bande'
        Tableau_ref = [ref_noir_norm;ref_marron_norm;ref_rouge_norm;ref_orange_norm;ref_jaune_norm;ref_vert_norm;ref_bleu_norm;ref_violet_norm;ref_gris_norm;ref_blanc_norm];
    case 'dernier_bande'
        Tableau_ref = [ref_dorree_norm;ref_argente_norm];
    otherwise 
        error('errreur bande');
end


min_norm=5;

[ligne,colone]=size(Tableau_ref);

for k=1:ligne
    
    normek = sqrt( (Tableau_ref(k,1) - Tableau_rgb_hsv_norm(1)).^2 + (Tableau_ref(k,2) - Tableau_rgb_hsv_norm(2)).^2 + (Tableau_ref(k,3) - Tableau_rgb_hsv_norm(3)).^2 + (Tableau_ref(k,4) - Tableau_rgb_hsv_norm(4)).^2 + (Tableau_ref(k,6) - Tableau_rgb_hsv_norm(6)).^2 ) ;
    
    if normek < min_norm 
        min_norm = normek;
        num_min_norme = k;

    end
end

switch str_bande
    case 'bande'
        switch num_min_norme
            case 1 
                str_couleurs = 'noir   ' ;
            case 2
                str_couleurs = 'marron '  ;
            case 3
                str_couleurs = 'rouge  ' ;
            case 4
                str_couleurs = 'orange '  ;
            case 5
                str_couleurs = 'jaune  ' ;
            case 6 
                str_couleurs = 'vert   '  ;
            case 7
                str_couleurs = 'bleu   '  ;
            case 8
                str_couleurs = 'violet '  ;
            case 9
                str_couleurs = 'gris   '  ;
            case 10
                str_couleurs = 'blanc  '  ;
            otherwise 
                error('erreur erreur couleur bloute');
        end
    case 'dernier_bande'
        switch num_min_norme
            case 1
                str_couleurs = 'doree  ' ;
            case 2
                str_couleurs = 'argente' ;
            otherwise 
                error('erreur erreur last couleur bloute');
        end
end


