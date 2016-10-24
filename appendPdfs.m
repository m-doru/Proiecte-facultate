pdfUri = dir(['PDFs' '/*.' 'pdf']);

mozaic = 'mozaic';

for i = 1:length(pdfUri)
    if ~strstartswith(pdfUri(i).name, mozaic)
        append_pdfs('tema1_rezultate.pdf', ['./PDFs/' pdfUri(i).name]);
        for j = 1:length(pdfUri)
            if strstartswith(pdfUri(j).name, mozaic) && strendswith(pdfUri(j).name, pdfUri(i).name)
                append_pdfs('tema1_rezultate.pdf', ['./PDFs/' pdfUri(j).name]);
            end
        end
    end
end