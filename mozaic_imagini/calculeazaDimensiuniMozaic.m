function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

%completati codul Matlab

y = params.numarPieseMozaicOrizontala * size(params.pieseMozaic(:,:,:,1), 2);
x = ceil(size(params.imgReferinta, 1)/size(params.imgReferinta, 2) * y);

%calculeaza automat numarul de piese pe verticala
params.numarPieseMozaicVerticala = ceil(x/size(params.pieseMozaic, 1));
params.imgReferintaRedimensionata = imresize(params.imgReferinta, [params.numarPieseMozaicVerticala*size(params.pieseMozaic(:,:,:,1), 1) y]);
end