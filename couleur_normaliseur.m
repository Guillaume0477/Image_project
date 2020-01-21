function Tableau_rgb_hsv_norm = couleur_normaliseur(Tableau_rgb_hsv)%ex [jaune , violet, marron, dorree]



for k=1:length(Tableau_rgb_hsv)
    Tableau_rgb_hsv_norm(1)=Tableau_rgb_hsv(1) * 1.85 - 0.037; 
    Tableau_rgb_hsv_norm(2)=Tableau_rgb_hsv(2) * 1.69 - 0.0507; 
    Tableau_rgb_hsv_norm(3)=Tableau_rgb_hsv(3) * 1.96 - 0.0588; 
    Tableau_rgb_hsv_norm(4)=Tableau_rgb_hsv(4) * 1.09 - 0.0327; 
    Tableau_rgb_hsv_norm(5)=Tableau_rgb_hsv(5) * 1.35 - 0.189; 
    Tableau_rgb_hsv_norm(6)=Tableau_rgb_hsv(6) * 1.96 - 0.2352; 
end




