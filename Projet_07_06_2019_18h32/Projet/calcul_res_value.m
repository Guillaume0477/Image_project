
function res_value = calcul_res_value(tableau_couleur)%ex [jaune ; violet; marron; dorree]


res_value = 0;
    
switch tableau_couleur(1,:)
    case 'noir   ' 
        res_value = res_value + 0 * 10;
    case 'marron '  
        res_value = res_value + 1 * 10;
    case 'rouge  '  
        res_value = res_value + 2 * 10;
    case 'orange '  
        res_value = res_value + 3 * 10;
    case 'jaune  '  
        res_value = res_value + 4 * 10;
    case 'vert   '  
        res_value = res_value + 5 * 10;
    case 'bleu   '  
        res_value = res_value + 6 * 10;
    case 'violet '  
        res_value = res_value + 7 * 10;
    case 'gris   '  
        res_value = res_value + 8 * 10;
    case 'blanc  '  
        res_value = res_value + 9 * 10;
    otherwise 
        error('erreur erreur couleur 1');
end


switch tableau_couleur(2,:)
    case 'noir   ' 
        res_value = res_value + 0;
    case 'marron '  
        res_value = res_value + 1;
    case 'rouge  '  
        res_value = res_value + 2;
    case 'orange '  
        res_value = res_value + 3;
    case 'jaune  '  
        res_value = res_value + 4;
    case 'vert   '  
        res_value = res_value + 5;
    case 'bleu   '  
        res_value = res_value + 6;
    case 'violet '  
        res_value = res_value + 7;
    case 'gris   '  
        res_value = res_value + 8;
    case 'blanc  '  
        res_value = res_value + 9;
    otherwise 
        error('erreur erreur couleur 2');
end


switch tableau_couleur(3,:)
    case 'argente' 
        res_value = res_value*0.01;
    case 'dorree '
        res_value = res_value*0.1;
    case 'noir   '  
        res_value = res_value*1;
    case 'marron '  
        res_value = res_value*10;
    case 'rouge  '  
        res_value = res_value*100;
    case 'orange '  
        res_value = res_value*1000;
    case 'jaune  '  
        res_value = res_value*10000;
    case 'vert   '  
        res_value = res_value*100000;
    case 'bleu   '  
        res_value = res_value*1000000;
    case 'violet '  
        res_value = res_value*10000000;
    otherwise 
        error('erreur erreur couleur 3');
end

switch tableau_couleur(4,:)
    case 'doree  ' 
        disp('tolérance + ou - 5%');
    case 'argente'
        disp('tolérance + ou - 10%');
    otherwise
        error('pas tolerence');
end


end

