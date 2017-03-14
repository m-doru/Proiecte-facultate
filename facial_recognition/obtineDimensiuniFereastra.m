function [xmin, ymin, xmax, ymax] = obtineDimensiuniFereastra(imgOrig, img, y, x, k, dimFereastra)
    raportx = size(imgOrig, 2)/size(img, 2);
    raporty = size(imgOrig, 1)/size(img, 1);
    xmin = ceil(((x-1)*k+1)*raportx);
    ymin = ceil(((y-1)*k+1)*raporty);
    xmax = ceil(((x-1)*k+dimFereastra)*raportx);
    ymax = ceil(((y-1)*k+dimFereastra)*raporty);
end