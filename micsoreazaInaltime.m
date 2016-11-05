function img = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)
%micsoreaza imaginea cu un numar de pixeli 'numarPixeliInaltime' pe inaltime (elimina drumuri de la stanga la dreapta) 
%
%input: img - imaginea initiala
%       numarPixeliLatime - specifica numarul de drumuri de la stanga la dreapta eliminate
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%       ploteazaDrum - specifica daca se ploteaza drumul gasit la fiecare pas. Valori posibile:
%                    0 - nu se ploteaza
%                    1 - se ploteaza
%       culoareDrum  - specifica culoarea cu care se vor plota pixelii din drum. Valori posibile:
%                    [r g b]' - triplete RGB (e.g [255 0 0]' - rosu)          
%                           
% output: img - imaginea redimensionata obtinuta prin eliminarea drumurilor

img = permute(img, [2 1 3]);

for i = 1:numarPixeliInaltime
   disp(['Eliminam drumul orizontal numarul ' num2str(i) ...
       ' dintr-un total de ' num2str(numarPixeliInaltime)]);
   
   E = calculeazaEnergie(img);
   
   drum = selecteazaDrumVertical(E, metodaSelectareDrum);
   
   %afiseaza drum
    if ploteazaDrum
        ploteazaDrumOrizontal(img,E,drum,culoareDrum);
        pause(1);
        close(gcf);
    end
   
   img = eliminaDrumVertical(img, drum);
end

img = permute(img, [2 1 3]);

end