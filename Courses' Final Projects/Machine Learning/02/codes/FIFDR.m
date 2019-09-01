function [rs2inds] = FIFDR(sDist,sDistInds)

dsLngth = length(sDist);
IL = 1;
mg = ceil(log10(dsLngth));
IM = mg+1;
Bmin = 1;
Bmax = dsLngth;

while IL<IM
    SL = (Bmax-Bmin+1)/((Bmax-Bmin+1)^(1/(IM-IL)));
    nv = Bmin:SL:Bmax;
    FDRnv = zeros(1,length(nv));
    for r = 1:length(nv)
        Xc = sDist(1:nv(r));
        Xs = sDist(nv(r)+1:end);
        FDRnv(r) = FDRcalc(Xc,Xs);
    end
    FDRnv(isnan(FDRnv)) = 0;
    [~,sFDRinds] = sort(FDRnv);
    if length(sFDRinds)>1 && nv(sFDRinds(end))>=nv(sFDRinds(end-1))
            Bmin = nv(sFDRinds(end-1));
            Bmax = nv(sFDRinds(end));
    end
    if length(sFDRinds)>1 && nv(sFDRinds(end))<nv(sFDRinds(end-1))
            Bmin = nv(sFDRinds(end));
            Bmax = nv(sFDRinds(end-1));
    end
    if length(sFDRinds)==1
            Bmin = nv(sFDRinds(end));
            Bmax = nv(sFDRinds(end));
    end
    IL = IL+1;
end

rs2inds = sDistInds(Bmax+1:end);

end

