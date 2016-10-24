function imgMozaic = adaugaPieseMozaic(params)
%adaugaPieseMozaic
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata)

if c == 1
    imgMozaic = uint8(zeros(h, w, 3));
else
    imgMozaic = uint8(zeros(h,w,c));
end
%if c == 1
 %  for i = 1:N
  %      params.pieseMozaic(:,:,1,i) = rgb2gray(params.pieseMozaic(:,:,:,i));
   %end
   %params.pieseMozaic(:,:,2:end,:) = [];
%end

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        %completati codul Matlab
        mediiPiese = zeros(1, 1, C, N);
        for i = 1:N
            mediiPiese(:,:,:,i) = mean(mean(params.pieseMozaic(:,:,:,i))); 
        end
        
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        
        for i = 1:params.numarPieseMozaicVerticala
            for j = 1:params.numarPieseMozaicOrizontala
                pixeliReferinta = params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:);
                mediePixeliReferinta = mean(mean(pixeliReferinta));
                
                distante = zeros(1, N);
                for k = 1:N
                    distante(k) = sqrt(sum((mediiPiese(:,:,:,k) - mediePixeliReferinta).^2));
                end
                [~, indexMinim] = min(distante);
                
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = ...
                    params.pieseMozaic(:,:,:, indexMinim);
                    
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCulori'
        %completati codul Matlab
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        
        for i = 1:params.numarPieseMozaicVerticala
            for j = 1:params.numarPieseMozaicOrizontala
                pixeliReferinta = params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:);
                
                distante = zeros(1, N);
                for k = 1:N
                    if c == 1
                        piesa = rgb2gray(params.pieseMozaic(:,:,:,k));
                    else
                        piesa = params.pieseMozaic(:,:,:,k);
                    end
                    distante(k) = sqrt(sum((piesa(:) - pixeliReferinta(:)).^2));
                end
                [~, indexMinim] = min(distante);
                
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = ...
                    params.pieseMozaic(:,:,:, indexMinim);
                    
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
    otherwise
        fprintf('EROARE, optiune necunoscut \n');
    
end
    
    
    
    
    
