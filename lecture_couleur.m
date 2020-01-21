function str_couleurs = lecture_couleur(Tableau_rgb_hsv)%ex [jaune , violet, marron, dorree]


ref_noir = [0.12 , 0.03 , 0.03 , 0.30 , 0.60 , 0.05];
ref_marron = [0.06 , 0 , 0 , 0.90 , 1 , 0.06];
%ref_marron = [0.22 , 0.10 , 0.11 , 0.90 , 0.57 , 0.20];
ref_rouge = [0.37 , 0.05 , 0.07 , 0.95 , 0.88 , 0.37];
ref_orange = [0.51 , 0.23 , 0.11 , 0.06 , 0.74 , 0.51];
ref_jaune = [0.48 , 0.37 , 0.11 , 0.12 , 0.78 , 0.47];
ref_vert = [0.06 , 0.16 , 0.10 , 0.38 , 0.72 , 0.12];
ref_bleu = [0.02 , 0.08 , 0.12 , 0.58 , 0.80 , 0.12];
ref_violet = [0.08 , 0.06 , 0.12 , 0.77 , 0.45 , 0.12]; 
ref_gris = [0.24 , 0.20 , 0.15 , 0.13 , 0.38 , 0.24];
ref_blanc = [0.56 , 0.62 , 0.54 , 0.30 , 0.14 , 0.63]; 
%ref_dorree = [0.30 , 0.26 , 0.16 , 0.10 , 0.80 , 0.29];

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




Tableau_ref = [ref_noir_norm;ref_marron_norm;ref_rouge_norm;ref_orange_norm;ref_jaune_norm;ref_vert_norm;ref_bleu_norm;ref_violet_norm;ref_gris_norm;ref_blanc_norm];%ref_dorree

min_norm=5;

for k=1:length(Tableau_ref)
    
        
    normek = sqrt( (Tableau_ref(k,1) - Tableau_rgb_hsv_norm(1)).^2 + (Tableau_ref(k,2) - Tableau_rgb_hsv_norm(2)).^2 + (Tableau_ref(k,3) - Tableau_rgb_hsv_norm(3)).^2 + (Tableau_ref(k,4) - Tableau_rgb_hsv_norm(4)).^2 + (Tableau_ref(k,6) - Tableau_rgb_hsv_norm(6)).^2 ) ;
    
    %+ (Tableau_ref(k,5) - Tableau_rgb_hsv_norm(5)).^2
    
    disp (normek)
    if normek < min_norm 
        min_norm = normek;
        num_min_norme = k;

    end
end
disp (min_norm)

switch num_min_norme
    case 1 
        str_couleurs = 'noir' ;
    case 2
        str_couleurs = 'marron'  ;
    case 3
        str_couleurs = 'rouge' ;
    case 4
        str_couleurs = 'orange'  ;
    case 5
        str_couleurs = 'jaune' ;
    case 6 
        str_couleurs = 'vert'  ;
    case 7
        str_couleurs = 'bleu'  ;
    case 8
        str_couleurs = 'violet'  ;
    case 9
        str_couleurs = 'gris'  ;
    case 10
        str_couleurs = 'blanc'  ;
    case 11 
        str_couleurs = 'dorre' ;
    otherwise 
        error('erreur erreur couleur bloute');
end






