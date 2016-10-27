dirName = 'PDFs';

pdfUri = dir([dirName '/*.' 'pdf']);

mozaic = 'mozaic';

indexPdfName = 1;
pdfsNames = cell(1);

% append_pdfs('tema1_rezultate.pdf', 'FirstPage.pdf');
pdfsNames{indexPdfName} = 'FirstPage.pdf';
indexPdfName = indexPdfName + 1;


for i = 1:length(pdfUri)
    if ~strstartswith(pdfUri(i).name, mozaic)
%         append_pdfs('tema1_rezultate.pdf', [dirName '/' pdfUri(i).name]);
        pdfsNames{indexPdfName} = [dirName '/' pdfUri(i).name];
        indexPdfName = indexPdfName + 1;
        for j = 1:length(pdfUri)
            if strstartswith(pdfUri(j).name, mozaic) && strendswith(pdfUri(j).name, pdfUri(i).name)
%                 append_pdfs('tema1_rezultate.pdf', [dirName '/' pdfUri(j).name]);
                pdfsNames{indexPdfName} = [dirName '/' pdfUri(j).name];
                indexPdfName = indexPdfName + 1;
            end
        end
    end
end

disp('Done appending test and individually chosen images');

% append_pdfs('tema1_rezultate.pdf', 'Variatia numarului de piese pe orizontala.pdf');
pdfsNames{indexPdfName} = 'Variatia numarului de piese pe orizontala.pdf';
indexPdfName = indexPdfName + 1;

disp('Done appending horizontal size variated images');

pdfUri = dir(['PDFsCifar10' '/*.' 'pdf']);
dirName = 'PDFsCifar10';

for i = 1:length(pdfUri)
    if ~strstartswith(pdfUri(i).name, mozaic)
%         append_pdfs('tema1_rezultate.pdf', [dirName '/' pdfUri(i).name]);
        pdfsNames{indexPdfName} = [dirName '/' pdfUri(i).name];
        indexPdfName = indexPdfName + 1;
        for j = 1:length(pdfUri)
            if strstartswith(pdfUri(j).name, mozaic) && strendswith(pdfUri(j).name, pdfUri(i).name)
%                 append_pdfs('tema1_rezultate.pdf', [dirName '/' pdfUri(j).name]);
                pdfsNames{indexPdfName} = [dirName '/' pdfUri(j).name];
                indexPdfName = indexPdfName + 1;
            end
        end
    end
end

append_pdfs('tema1_rezultate.pdf', pdfsNames{:});