function [imgMedFilt] = pseudoMedian(image)
    imgMedFilt = zeros(size(image));
    imagePad = padarray(image,[2 2]);
    [r,c] = size(imagePad);

    for c1 = 2:r-1
        for c2 = 2:c-1
            medFilter = [imagePad(c1-1,c2-1); imagePad(c1,c2-1); imagePad(c1+1,c2-1); ...
                imagePad(c1-1,c2); imagePad(c1,c2); imagePad(c1+1,c2); ...
                imagePad(c1-1,c2+1); imagePad(c1,c2+1); imagePad(c1+1,c2+1)];

            mins = zeros(1,7); maxs = zeros(1,7);
            for c3 = 1:7
                mins(c3) = min(medFilter(c3:c3+2));
                maxs(c3) = max(medFilter(c3:c3+2));
            end

            imgMedFilt(c1-1,c2-1) = .5 * (max(mins) + min(maxs));
        end
    end
end
